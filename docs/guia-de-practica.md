# Guía de práctica

Esta guía te acompaña desde la descarga del material hasta la comprobación de tus consultas. El laboratorio trabaja con SQLite y datos ficticios de una tienda de videojuegos.

## Preparar el laboratorio

En GitHub, elige **Code → Download ZIP** y descomprime el archivo en una carpeta. Si ya tienes la carpeta, abre `laboratorio.html` directamente con doble clic.

El motor SQLite y los datos vienen dentro de ese archivo HTML. No necesitas instalar SQLite, crear una base de datos ni iniciar un servidor. Espera a que el laboratorio indique **Base lista · SQLite local**. Al terminar de cargar, verás las tablas disponibles, una consulta inicial y el catálogo que devuelve.

## Ejecutar y modificar una consulta

1. Haz clic dentro del editor **Consulta SQL**.
2. Escribe o modifica la consulta.
3. Pulsa **Ejecutar**. También puedes usar **Ctrl/⌘ + Intro**.
4. Lee la tabla de resultados. Si SQLite encuentra un error, el laboratorio lo muestra en el panel **Resultado**, junto a la tabla y a la derecha en pantallas anchas.
5. Cambia la consulta y vuelve a ejecutarla para comparar el resultado.

El editor inicial muestra los títulos y precios del catálogo. Úsalo como punto de partida para el Reto 1, que pregunta qué videojuego tiene el precio más alto y cuál es su precio. Resuélvelo paso a paso antes de abrir los archivos con respuestas.

## Seguir los retos

Abre [`retos.md`](../retos.md) y resuelve las preguntas en orden. Puedes dejarlo abierto junto al laboratorio. Los ejercicios empiezan con consultas de catálogo y avanzan hacia filtros, ordenación, agregaciones y relaciones entre tablas.

La tabla lateral del laboratorio muestra los nombres de las tablas y sus columnas. Consulta el [modelo de datos](modelo-de-datos.md) si quieres entender cómo se conectan los clientes, pedidos, videojuegos y líneas de pedido.

## Reproducir un resultado de referencia

Haz primero tu propio intento. Después abre [`consulta_01.sql`](../consulta_01.sql) con un editor de texto, copia su contenido y pégalo en **Consulta SQL**. Pulsa **Ejecutar** para volver a producir la salida de referencia del Reto 1.

Compara el nombre y el orden de las columnas, además de las filas, con el objeto del mismo reto en [`resultados.json`](../resultados.json). Ese archivo contiene las salidas esperadas de los diez ejercicios.

[`soluciones.sql`](../soluciones.sql) reúne las respuestas SQL de todos los retos. Consúltalo después de intentar cada pregunta para no adelantarte la solución.

## Conservar tu trabajo

El laboratorio ejecuta las consultas en memoria y no guarda los cambios en un archivo. Copia las consultas que quieras conservar en un archivo `.sql` propio antes de cerrar o recargar la página. Al volver a abrir el laboratorio, se cargan de nuevo los datos y la consulta inicial.
