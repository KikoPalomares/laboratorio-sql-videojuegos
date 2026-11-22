-- Reto 3. Filtrar pedidos por un mes
-- Ejecuta cada consulta por separado en el laboratorio.

-- 2. Leer el formato antes de filtrar
SELECT id, fecha, typeof(fecha) AS tipo_fecha
FROM pedidos
ORDER BY fecha ASC, id ASC;

SELECT id, fecha
FROM pedidos
WHERE fecha >= '2026-11-01' AND fecha < '2026-12-01'
ORDER BY fecha ASC, id ASC;

-- 3. Cambiar el final del intervalo
SELECT id, fecha
FROM pedidos
WHERE fecha >= '2026-11-01' AND fecha < '2026-11-08'
ORDER BY fecha ASC, id ASC;

SELECT id, fecha
FROM pedidos
WHERE fecha >= '2026-11-01' AND fecha < '2026-12-01'
ORDER BY fecha ASC, id ASC;

-- 4. Pausa: cambia el intervalo a octubre
SELECT id, fecha
FROM pedidos
WHERE fecha >= '2026-11-01' AND fecha < '2026-12-01'
ORDER BY fecha ASC, id ASC;

-- 5. Resolver octubre con el mismo patrón
SELECT id, fecha
FROM pedidos
WHERE fecha >= '2026-10-01' AND fecha < '2026-11-01'
ORDER BY fecha ASC, id ASC;

SELECT id, fecha
FROM pedidos
WHERE fecha >= '2026-11-01' AND fecha < '2026-12-01'
ORDER BY fecha ASC, id ASC;

-- 6. Errores de formato y tipo en SQLite
SELECT id, fecha
FROM pedidos
WHERE fecha >= 20261101 AND fecha < 20261201
ORDER BY fecha ASC, id ASC;

SELECT id, fecha
FROM pedidos
WHERE fecha >= '01/11/2026' AND fecha <= '30/11/2026'
ORDER BY fecha ASC, id ASC;

SELECT typeof(fecha) AS tipo_fecha, fecha
FROM pedidos
ORDER BY id ASC
LIMIT 4;

-- 7. Pausa: prueba el límite exclusivo
WITH fechas(fecha) AS (VALUES ('2026-11-30'), ('2026-12-01'), ('2026-12-02'))
SELECT fecha
FROM fechas
ORDER BY fecha ASC;

-- 8. Ver por qué noviembre termina antes de diciembre
WITH fechas(fecha) AS (VALUES ('2026-11-30'), ('2026-12-01'), ('2026-12-02'))
SELECT fecha
FROM fechas
WHERE fecha BETWEEN '2026-11-01' AND '2026-12-01'
ORDER BY fecha ASC;

WITH fechas(fecha) AS (VALUES ('2026-11-30'), ('2026-12-01'), ('2026-12-02'))
SELECT fecha
FROM fechas
WHERE fecha >= '2026-11-01' AND fecha < '2026-12-01'
ORDER BY fecha ASC;

SELECT id AS pedido_id, fecha
FROM pedidos
WHERE fecha >= '2026-11-01' AND fecha < '2026-12-01'
ORDER BY fecha ASC, id ASC;

-- 9. Cierre: un mes como intervalo
SELECT id, fecha
FROM pedidos
WHERE fecha >= '2026-11-01' AND fecha < '2026-12-01'
ORDER BY fecha ASC, id ASC;
