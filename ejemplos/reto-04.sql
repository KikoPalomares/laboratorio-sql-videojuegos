-- Reto 4. Contar y promediar con cuidado
-- Ejecuta cada consulta por separado en el laboratorio.

-- 2. Contar filas y mirar los valores
SELECT COUNT(*) AS total_juegos
FROM videojuegos;

SELECT precio_euros
FROM videojuegos
ORDER BY precio_euros ASC;

-- 3. Pausa: calcula el resumen del catálogo
SELECT titulo, precio_euros
FROM videojuegos
ORDER BY precio_euros ASC, titulo ASC;

-- 4. Leer promedio y extremos
SELECT COUNT(*) AS total_videojuegos,
       ROUND(AVG(precio_euros), 2) AS precio_medio_euros
FROM videojuegos;

SELECT MIN(precio_euros) AS precio_minimo, MAX(precio_euros) AS precio_maximo
FROM videojuegos;

-- 5. Qué significa un valor nulo
SELECT COUNT(*) AS filas, COUNT(precio_euros) AS precios_con_valor
FROM videojuegos;

WITH valores(precio) AS (VALUES (10), (NULL), (20))
SELECT COUNT(*) AS filas,
       COUNT(precio) AS valores_conocidos,
       ROUND(AVG(precio), 2) AS media,
       MIN(precio) AS minimo,
       MAX(precio) AS maximo
FROM valores;

-- 6. Precio y unidades responden a cosas distintas
SELECT COUNT(*) AS lineas,
       SUM(unidades) AS unidades_vendidas,
       ROUND(AVG(unidades), 2) AS media_unidades_por_linea
FROM lineas_pedido;

SELECT id, precio_unitario_euros, unidades
FROM lineas_pedido
ORDER BY id ASC
LIMIT 6;

-- 7. Pausa: pondera cada unidad vendida
SELECT precio_unitario_euros, unidades
FROM lineas_pedido
ORDER BY id ASC;

SELECT ROUND(AVG(precio_unitario_euros), 2) AS precio_medio_por_linea
FROM lineas_pedido;

-- 8. Resolver el promedio ponderado
SELECT COUNT(*) AS lineas,
       SUM(unidades) AS unidades_vendidas,
       ROUND(AVG(precio_unitario_euros), 2) AS promedio_precio_por_linea,
       ROUND(SUM(precio_unitario_euros * unidades) * 1.0 / SUM(unidades), 2) AS precio_ponderado_por_unidad
FROM lineas_pedido;

SELECT SUM(precio_unitario_euros * unidades) AS importe_total_euros,
       SUM(unidades) AS unidades_vendidas,
       ROUND(SUM(precio_unitario_euros * unidades) * 1.0 / SUM(unidades), 2) AS precio_ponderado_por_unidad
FROM lineas_pedido;
