# Laboratorio SQL de una tienda de videojuegos

Material para practicar consultas SQL sobre una tienda ficticia de videojuegos. Incluye un laboratorio que funciona en el navegador, diez retos, un conjunto de datos de ejemplo y resultados de referencia.

## Empezar

En GitHub, elige **Code → Download ZIP** y descomprime el archivo. Si ya tienes la carpeta, abre `laboratorio.html` directamente. Haz doble clic en ese archivo para abrir el laboratorio en el navegador.

El laboratorio carga la base de datos en el navegador. No hace falta instalar SQLite ni preparar una base. Espera a que aparezca **Base lista · SQLite local**. El editor ya muestra una consulta inicial y su resultado.

Modifica el texto del editor para probar una consulta. Pulsa **Ejecutar** o usa **Ctrl/⌘ + Intro**. El resultado aparece junto al editor y se actualiza cada vez que vuelves a ejecutar.

## Primera práctica sin pistas

Empieza por el Reto 1 de [`retos.md`](retos.md), que sigue el ejercicio de introducción del curso. El laboratorio arranca mostrando el catálogo con sus títulos y precios. Modifica esa consulta hasta responder la pregunta del reto.

Deja [`consulta_01.sql`](consulta_01.sql), [`soluciones.sql`](soluciones.sql) y [`resultados.json`](resultados.json) para después de tu primer intento. Los dos últimos contienen las respuestas de los diez retos.

Cuando quieras reproducir el resultado de referencia del Reto 1, abre `consulta_01.sql` en un editor de texto, copia su contenido, pégalo en el editor del laboratorio y ejecútalo. Compara las columnas y filas con la entrada del Reto 1 en `resultados.json`.

La [guía de práctica](docs/guia-de-practica.md) explica el recorrido completo. El [modelo de datos](docs/modelo-de-datos.md) describe las cuatro tablas y sus relaciones.

## Datos de práctica

- `clientes` contiene las personas, incluidas las que todavía no han hecho pedidos.
- `videojuegos` contiene el catálogo y el precio anunciado de cada juego.
- `pedidos` contiene la fecha y el cliente de cada pedido.
- `lineas_pedido` conecta los pedidos con los juegos e indica las unidades y el precio por unidad.

Todos los datos son ficticios. El esquema completo está en [`tienda.sql`](tienda.sql). Las diez consultas de referencia se comprueban con SQLite y sus salidas se guardan en `resultados.json`; el repositorio incluye el verificador [`scripts/verify.py`](scripts/verify.py).

## Licencia

El material del repositorio se distribuye bajo la [licencia MIT](LICENSE).

## Para quienes modifiquen el material

Los pasos de reconstrucción y comprobación no hacen falta para practicar. Si vas a cambiar el laboratorio o las consultas, instala las dependencias, genera el HTML y verifica las diez soluciones con estos comandos.

```sh
npm ci
npm run build
python3 scripts/verify.py
```
