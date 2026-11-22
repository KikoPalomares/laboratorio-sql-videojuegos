#!/usr/bin/env python3
"""Verifica localmente las diez soluciones contra SQLite y resultados.json."""
from __future__ import annotations

import json
import math
import re
import sqlite3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
EXPECTED_RETO_1 = "SELECT titulo, precio_euros\nFROM videojuegos\nORDER BY precio_euros DESC\nLIMIT 1;"


def require(condition: bool, message: str) -> None:
    if not condition:
        raise SystemExit(f"ERROR: {message}")


def parse_solutions(source: str) -> dict[int, str]:
    chunks = re.split(r"(?m)^--\s*Reto\s+(\d+):[^\r\n]*\r?\n", source.strip())
    solutions: dict[int, str] = {}
    for index in range(1, len(chunks), 2):
        reto = int(chunks[index])
        sql = chunks[index + 1].strip()
        if sql:
            solutions[reto] = sql
    return solutions


def matches(actual: object, expected: object) -> bool:
    if isinstance(expected, (int, float)) and not isinstance(expected, bool):
        return isinstance(actual, (int, float)) and math.isclose(
            float(actual), float(expected), rel_tol=0.0, abs_tol=1e-9
        )
    return actual == expected


def verify_examples(connection: sqlite3.Connection, challenge: int, reference: dict) -> int:
    path = ROOT / "ejemplos" / f"reto-{challenge:02}.sql"
    count = 0
    found_solution = False
    checked_sales_totals = False
    statement = ""
    for line in path.read_text(encoding="utf-8").splitlines(keepends=True):
        if not statement and (not line.strip() or line.lstrip().startswith("--")):
            continue
        statement += line
        if not sqlite3.complete_statement(statement):
            continue
        result = connection.execute(statement)
        columns = [column[0] for column in result.description or []]
        rows = [list(row) for row in result.fetchall()]
        if columns == reference["columnas"] and rows == reference["filas"]:
            found_solution = True
        if challenge == 10 and columns == ["pedidos", "unidades", "ingresos_euros"]:
            totals = connection.execute(
                "SELECT (SELECT COUNT(*) FROM pedidos), SUM(unidades), "
                "SUM(unidades * precio_unitario_euros) FROM lineas_pedido"
            ).fetchone()
            require(rows == [list(totals)], "El cierre debe distinguir pedidos, unidades e ingresos.")
            checked_sales_totals = True
        count += 1
        statement = ""
    require(not statement.strip(), f"Consulta inconclusa en {path.name}.")
    require(found_solution, f"{path.name} debe incluir el resultado de referencia del reto.")
    if challenge == 10:
        require(checked_sales_totals, "Falta el resumen de pedidos, unidades e ingresos.")
    return count


def main() -> None:
    required_files = (
        "index.html",
        "laboratorio.html",
        "retos.md",
        "tienda.sql",
        "consulta_01.sql",
        "soluciones.sql",
        "resultados.json",
        "src/laboratorio-template.html",
        "scripts/build.mjs",
        "licenses/sql.js/LICENSE",
        "licenses/sql.js/AUTHORS",
        "LICENSE",
        ".nojekyll",
    )
    for relative in required_files:
        require((ROOT / relative).is_file(), f"Falta {relative}.")

    html = (ROOT / "laboratorio.html").read_text(encoding="utf-8")
    require("@@" not in html, "laboratorio.html conserva marcadores del generador.")
    require("/Users/" not in html, "laboratorio.html contiene una ruta local del equipo de producción.")
    require(not re.search(r"<script\s+src=|<link\s+rel=[\"']stylesheet", html, re.I), "El HTML intenta cargar recursos externos.")
    for selector in ('id="consulta"', 'id="ejecutar"', 'id="resultados"'):
        require(selector in html, f"Falta el selector {selector}.")

    index = (ROOT / "index.html").read_text(encoding="utf-8")
    require('http-equiv="refresh"' in index and 'href="./laboratorio.html"' in index,
            "index.html no dirige a laboratorio.html con rutas relativas.")

    queries = parse_solutions((ROOT / "soluciones.sql").read_text(encoding="utf-8"))
    require(tuple(sorted(queries)) == tuple(range(1, 11)), "Se requieren exactamente diez consultas numeradas.")
    require(queries[1] == EXPECTED_RETO_1, "La consulta del reto 1 no coincide con el SQL aprobado.")
    consulta_01 = (ROOT / "consulta_01.sql").read_text(encoding="utf-8").strip()
    require(consulta_01 == EXPECTED_RETO_1, "consulta_01.sql no coincide con el reto 1 aprobado.")

    expected_rows = json.loads((ROOT / "resultados.json").read_text(encoding="utf-8"))
    expected_by_id = {int(result["reto"]): result for result in expected_rows}
    require(tuple(sorted(expected_by_id)) == tuple(range(1, 11)), "resultados.json debe cubrir los retos 1–10.")

    connection = sqlite3.connect(":memory:")
    example_count = 0
    try:
        connection.executescript((ROOT / "tienda.sql").read_text(encoding="utf-8"))
        connection.execute("PRAGMA query_only = ON")
        for reto in range(1, 11):
            reference = expected_by_id[reto]
            cursor = connection.execute(queries[reto])
            columns = [description[0] for description in (cursor.description or [])]
            rows = [list(row) for row in cursor.fetchall()]
            require(columns == reference["columnas"], f"Reto {reto}: columnas {columns!r} no coinciden.")
            require(len(rows) == len(reference["filas"]), f"Reto {reto}: número de filas distinto.")
            for row_index, (actual_row, expected_row) in enumerate(zip(rows, reference["filas"]), start=1):
                require(len(actual_row) == len(expected_row), f"Reto {reto}, fila {row_index}: número de columnas distinto.")
                for column_index, (actual, expected) in enumerate(zip(actual_row, expected_row), start=1):
                    require(matches(actual, expected),
                            f"Reto {reto}, fila {row_index}, columna {column_index}: {actual!r} != {expected!r}.")
            examples = verify_examples(connection, reto, reference)
            example_count += examples
            print(f"Reto {reto}/10 · {len(rows)} filas de referencia · {examples} ejemplos ejecutados")
    finally:
        connection.close()

    print(f"Verificación completa. Diez soluciones y {example_count} consultas del curso.")


if __name__ == "__main__":
    main()
