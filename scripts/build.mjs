#!/usr/bin/env node
import { createHash } from "node:crypto";
import { readFile, writeFile, mkdir } from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";

const ROOT = path.resolve(fileURLToPath(new URL("../", import.meta.url)));
const TEMPLATE_PATH = path.join(ROOT, "src", "laboratorio-template.html");
const SEED_PATH = path.join(ROOT, "tienda.sql");
const PACKAGE_PATH = path.join(ROOT, "node_modules", "sql.js", "package.json");
const BUNDLE_PATH = path.join(ROOT, "node_modules", "sql.js", "dist", "sql-wasm-inline.js");
const LICENSE_PATH = path.join(ROOT, "node_modules", "sql.js", "LICENSE");
const AUTHORS_PATH = path.join(ROOT, "node_modules", "sql.js", "AUTHORS");
const LAB_PATH = path.join(ROOT, "laboratorio.html");
const THIRD_PARTY_DIR = path.join(ROOT, "licenses", "sql.js");
const VERSION = "1.16.0";

async function readLf(filePath) {
  return (await readFile(filePath, "utf8")).replace(/\r\n/g, "\n");
}

async function main() {
  const packageInfo = JSON.parse(await readFile(PACKAGE_PATH, "utf8"));
  if (packageInfo.name !== "sql.js" || packageInfo.version !== VERSION) {
    throw new Error(`Se esperaba sql.js ${VERSION}; se encontró ${packageInfo.name}@${packageInfo.version}.`);
  }

  const template = await readLf(TEMPLATE_PATH);
  const seed = await readLf(SEED_PATH);
  const bundle = await readLf(BUNDLE_PATH);
  const upstreamLicenseRaw = await readLf(LICENSE_PATH);
  const upstreamLicense = upstreamLicenseRaw.trim();
  const authors = await readLf(AUTHORS_PATH);

  if (bundle.toLowerCase().includes("</script")) {
    throw new Error("El bundle incluye un cierre de script y no puede incrustarse con seguridad.");
  }

  let seedJson = JSON.stringify(seed);
  seedJson = seedJson.replace(/&/g, "\\u0026").replace(/</g, "\\u003c").replace(/>/g, "\\u003e");
  const licenseText = [
    `sql.js v${VERSION} · MIT License`,
    "Fuente del paquete oficial: https://github.com/sql-js/sql.js",
    "",
    upstreamLicense,
  ].join("\n");

  const replacements = new Map([
    ["@@SEED_SQL_JSON@@", seedJson],
    ["@@SQLJS_INLINE_BUNDLE@@", bundle],
    ["@@SQLJS_MIT_LICENSE@@", licenseText],
  ]);
  let html = template;
  for (const [marker, replacement] of replacements) {
    const occurrences = html.split(marker).length - 1;
    if (occurrences !== 1) throw new Error(`El marcador ${marker} debe aparecer una vez; se encontró ${occurrences}.`);
    html = html.replace(marker, replacement);
  }

  if (html.includes("@@") || html.includes("/Users/")) {
    throw new Error("El HTML compilado conserva un marcador o una ruta de máquina local.");
  }
  if (/<script\s+src=/i.test(html) || /<link\s+rel=["']stylesheet/i.test(html)) {
    throw new Error("El laboratorio debe ser autónomo y no cargar scripts ni hojas de estilo externos.");
  }
  if (!html.includes('id="consulta"') || !html.includes('id="ejecutar"') || !html.includes('id="resultados"')) {
    throw new Error("El laboratorio perdió uno de los selectores de interfaz acordados.");
  }

  const index = await readLf(path.join(ROOT, "index.html"));
  if (!index.includes('http-equiv="refresh"') || !index.includes('href="./laboratorio.html"')) {
    throw new Error("index.html debe dirigir a ./laboratorio.html desde la raíz del sitio.");
  }

  await mkdir(THIRD_PARTY_DIR, { recursive: true });
  await writeFile(path.join(THIRD_PARTY_DIR, "LICENSE"), upstreamLicenseRaw, "utf8");
  await writeFile(path.join(THIRD_PARTY_DIR, "AUTHORS"), authors, "utf8");
  await writeFile(LAB_PATH, html, "utf8");

  const seedSha = createHash("sha256").update(seed, "utf8").digest("hex");
  const bundleSha = createHash("sha256").update(bundle, "utf8").digest("hex");
  console.log(`Generado: ${path.relative(ROOT, LAB_PATH)}`);
  console.log(`sql.js ${VERSION} · bundle SHA-256 ${bundleSha}`);
  console.log(`Seed SHA-256 ${seedSha}`);
  console.log(`HTML: ${Buffer.byteLength(html, "utf8").toLocaleString("es-ES")} bytes`);
}

main().catch(error => {
  console.error(error.stack || error);
  process.exitCode = 1;
});
