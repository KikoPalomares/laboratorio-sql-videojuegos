-- Reto 5. Sumar unidades por videojuego
-- Ejecuta cada consulta por separado en el laboratorio.

-- 2. Una línea no siempre es una unidad
SELECT videojuego_id, pedido_id, unidades
FROM lineas_pedido
ORDER BY id ASC
LIMIT 6;

SELECT COUNT(*) AS lineas, SUM(unidades) AS unidades
FROM lineas_pedido;

-- 3. Agrupar y sumar por identificador
SELECT videojuego_id, SUM(unidades) AS unidades_vendidas
FROM lineas_pedido
GROUP BY videojuego_id
ORDER BY videojuego_id ASC;

SELECT videojuego_id, COUNT(*) AS lineas, SUM(unidades) AS unidades_vendidas
FROM lineas_pedido
GROUP BY videojuego_id
ORDER BY videojuego_id ASC;

-- 4. Pausa: ordena los grupos por unidades
SELECT videojuego_id, SUM(unidades) AS unidades_vendidas
FROM lineas_pedido
GROUP BY videojuego_id
ORDER BY videojuego_id ASC;

-- 5. Leer la clasificación y sus empates
SELECT videojuego_id, SUM(unidades) AS unidades_vendidas
FROM lineas_pedido
GROUP BY videojuego_id
ORDER BY unidades_vendidas DESC, videojuego_id ASC;

SELECT videojuego_id, SUM(unidades) AS unidades_vendidas
FROM lineas_pedido
GROUP BY videojuego_id
ORDER BY unidades_vendidas DESC, videojuego_id DESC;

-- 6. Filtrar filas o filtrar grupos
SELECT videojuego_id, COUNT(*) AS lineas, SUM(unidades) AS unidades_vendidas
FROM lineas_pedido
WHERE unidades > 1
GROUP BY videojuego_id
ORDER BY unidades_vendidas DESC, videojuego_id ASC;

SELECT videojuego_id, SUM(unidades) AS unidades_vendidas
FROM lineas_pedido
GROUP BY videojuego_id
HAVING SUM(unidades) >= 5
ORDER BY unidades_vendidas DESC, videojuego_id ASC;

-- 7. Pausa: conserva grupos que superan el umbral
SELECT videojuego_id, SUM(unidades) AS unidades_vendidas
FROM lineas_pedido
GROUP BY videojuego_id
ORDER BY unidades_vendidas DESC, videojuego_id ASC;

-- 8. Comprobar HAVING frente a WHERE
SELECT videojuego_id, SUM(unidades) AS unidades_vendidas
FROM lineas_pedido
GROUP BY videojuego_id
HAVING SUM(unidades) >= 3
ORDER BY unidades_vendidas DESC, videojuego_id ASC;

SELECT videojuego_id, SUM(unidades) AS unidades_vendidas
FROM lineas_pedido
WHERE unidades >= 3
GROUP BY videojuego_id
ORDER BY unidades_vendidas DESC, videojuego_id ASC;
