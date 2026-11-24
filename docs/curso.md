# Seguir el curso en el laboratorio

Abre el laboratorio y ten a mano los [diez retos](../retos.md). Si ya sabes utilizar una cláusula, el minuto de la tabla te permite saltar al siguiente tema.

| Inicio | Capítulo | SQL que se ejecuta en pantalla |
| --- | --- | --- |
| 00:40 | 1. La primera consulta: el precio más alto | [Ver consultas](../ejemplos/reto-01.sql) |
| 07:23 | 2. Filtrar por precio sin perder la frontera | [Ver consultas](../ejemplos/reto-02.sql) |
| 15:35 | 3. Filtrar pedidos por un mes | [Ver consultas](../ejemplos/reto-03.sql) |
| 23:42 | 4. Contar y promediar con cuidado | [Ver consultas](../ejemplos/reto-04.sql) |
| 31:39 | 5. Sumar unidades por videojuego | [Ver consultas](../ejemplos/reto-05.sql) |
| 39:57 | 6. Unir tablas para leer las ventas | [Ver consultas](../ejemplos/reto-06.sql) |
| 49:04 | 7. Conservar filas con LEFT JOIN | [Ver consultas](../ejemplos/reto-07.sql) |
| 57:14 | 8. Resumir las ventas por mes | [Ver consultas](../ejemplos/reto-08.sql) |
| 1:05:27 | 9. Calcular el ticket medio por pedido | [Ver consultas](../ejemplos/reto-09.sql) |
| 1:13:46 | 10. Clasificar el catálogo por ventas | [Ver consultas](../ejemplos/reto-10.sql) |

La guía de descarga empieza en el 00:13, justo antes de la primera consulta.

Para practicar con los empates, las tres fechas o el valor `NULL`, copia el bloque completo desde `WITH` hasta el punto y coma. Esas filas de ejemplo sólo existen dentro de esa consulta.

## Te toca a ti

Cada capítulo tiene dos prácticas. La consigna permanece diez segundos en pantalla. Pausa el vídeo, escribe la consulta y pulsa **Ejecutar**. Cuando tengas tu resultado, reanuda el vídeo y compáralo con la solución. Los archivos SQL de la tabla incluyen los pasos intermedios y las soluciones.


### Reto 1. La primera consulta: el precio más alto

- Cambia el orden para encontrar el juego más barato y conserva una sola fila.
- En estos tres registros, pon los precios de menor a mayor y conserva los títulos de la A a la Z si empatan. ¿Qué fila queda primero?

### Reto 2. Filtrar por precio sin perder la frontera

- Cambia el límite inclusivo por uno estricto: ¿qué título desaparece y cuántos resultados quedan?
- Devuelve juegos de hasta 30 € cuyo título sea Ritmo de Neón o Niebla en Marte. Agrupa las alternativas con paréntesis.

### Reto 3. Filtrar pedidos por un mes

- Modifica los dos límites para ver todos los pedidos de octubre de 2026. ¿Qué cuatro identificadores salen?
- Filtra el ejemplo para conservar solo noviembre y excluir el 1 de diciembre. Escribe un intervalo semiabierto.

### Reto 4. Contar y promediar con cuidado

- Resume videojuegos en una fila: cuenta títulos y calcula precio medio, mínimo y máximo.
- Calcula el precio medio por unidad vendida, ponderando cada precio por unidades. Compáralo con la media por línea.

### Reto 5. Sumar unidades por videojuego

- Ordena los grupos por unidades vendidas, de mayor a menor. En los empates, ordena videojuego_id de menor a mayor.
- Añade una condición para conservar solo grupos con al menos 3 unidades vendidas en total.

### Reto 6. Unir tablas para leer las ventas

- Une las líneas con el catálogo para obtener el título del videojuego con ID 6 y el total de unidades vendidas.
- Muestra para las dos líneas del pedido 1005 la fecha, el título, las unidades y el precio unitario cobrado.

### Reto 7. Conservar filas con LEFT JOIN

- Devuelve el identificador y el nombre de cada cliente que todavía no tiene ningún pedido.
- Cuenta los pedidos de noviembre de 2026 por cliente y conserva en el resultado también a quienes no compraron ese mes.

### Reto 8. Resumir las ventas por mes

- Muestra cuántos pedidos hubo en cada mes de 2026.
- Prepara un resumen mensual con pedidos, unidades vendidas y facturación en euros.

### Reto 9. Calcular el ticket medio por pedido

- Calcula el importe total del pedido 1004 a partir de sus líneas de venta.
- Calcula el ticket medio por pedido para toda la tienda, redondeado a dos decimales.

### Reto 10. Clasificar el catálogo por ventas

- Genera una clasificación de los ocho juegos con facturación, unidades y número de pedidos; incluye los que no tengan ventas.
- Clasifica todos los juegos por número de pedidos distintos y encuentra cuál aparece en más pedidos.
