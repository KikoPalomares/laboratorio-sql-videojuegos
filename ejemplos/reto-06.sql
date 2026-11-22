-- Reto 6. Unir tablas para leer las ventas
-- Ejecuta cada consulta por separado en el laboratorio.

-- 1. Del identificador al juego
SELECT videojuego_id, SUM(unidades) AS unidades_vendidas
FROM lineas_pedido
GROUP BY videojuego_id
ORDER BY unidades_vendidas DESC, videojuego_id ASC;

SELECT id, titulo, precio_euros
FROM videojuegos
ORDER BY id;

-- 2. Dos tablas, un dato común
SELECT id, titulo, precio_euros
FROM videojuegos
ORDER BY id;

SELECT pedido_id, videojuego_id, unidades, precio_unitario_euros
FROM lineas_pedido
ORDER BY id
LIMIT 6;

-- 3. La primera unión
SELECT lp.id AS linea_id, lp.videojuego_id, v.titulo, lp.unidades
FROM lineas_pedido AS lp
INNER JOIN videojuegos AS v ON v.id = lp.videojuego_id
ORDER BY lp.id;

SELECT lp.pedido_id, v.titulo, lp.unidades, lp.precio_unitario_euros
FROM lineas_pedido AS lp
INNER JOIN videojuegos AS v ON v.id = lp.videojuego_id
ORDER BY lp.pedido_id, v.titulo;

-- 4. Pausa: descifra un identificador
SELECT pedido_id, videojuego_id, unidades, precio_unitario_euros
FROM lineas_pedido
WHERE videojuego_id = 6
ORDER BY pedido_id, id;

-- 5. Solución: el seis tiene nombre
SELECT id, titulo
FROM videojuegos
WHERE id = 6;

SELECT lp.pedido_id, v.titulo, lp.unidades
FROM lineas_pedido AS lp
INNER JOIN videojuegos AS v ON v.id = lp.videojuego_id
WHERE lp.videojuego_id = 6
ORDER BY lp.pedido_id;

SELECT v.titulo, SUM(lp.unidades) AS unidades_vendidas
FROM lineas_pedido AS lp
INNER JOIN videojuegos AS v ON v.id = lp.videojuego_id
WHERE v.id = 6
GROUP BY v.id, v.titulo;

-- 6. Pedidos y líneas de pedido
SELECT p.id AS pedido_id, p.fecha, lp.videojuego_id, lp.unidades
FROM pedidos AS p
INNER JOIN lineas_pedido AS lp ON lp.pedido_id = p.id
WHERE p.id = 1005
ORDER BY lp.id;

SELECT p.id AS pedido_id, p.fecha, v.titulo, lp.unidades
FROM pedidos AS p
INNER JOIN lineas_pedido AS lp ON lp.pedido_id = p.id
INNER JOIN videojuegos AS v ON v.id = lp.videojuego_id
ORDER BY p.fecha, p.id, v.titulo;

-- 7. El precio que se cobró
SELECT lp.pedido_id, v.titulo, v.precio_euros AS precio_catalogo, lp.precio_unitario_euros AS precio_cobrado
FROM lineas_pedido AS lp
INNER JOIN videojuegos AS v ON v.id = lp.videojuego_id
WHERE lp.pedido_id = 1005
ORDER BY lp.id;

SELECT p.id AS pedido_id, p.fecha, v.titulo, lp.unidades, lp.precio_unitario_euros, lp.unidades * lp.precio_unitario_euros AS subtotal_euros
FROM pedidos AS p
INNER JOIN lineas_pedido AS lp ON lp.pedido_id = p.id
INNER JOIN videojuegos AS v ON v.id = lp.videojuego_id
WHERE p.id = 1005
ORDER BY lp.id;

-- 8. Pausa: reconstruye el pedido
SELECT p.id AS pedido_id, p.fecha, lp.videojuego_id, lp.unidades, lp.precio_unitario_euros
FROM pedidos AS p
INNER JOIN lineas_pedido AS lp ON lp.pedido_id = p.id
WHERE p.id = 1005
ORDER BY lp.id;

-- 9. Solución: el detalle completo
SELECT p.id AS pedido_id, p.fecha, v.titulo, lp.unidades, lp.precio_unitario_euros
FROM pedidos AS p
JOIN lineas_pedido AS lp ON lp.pedido_id = p.id
JOIN videojuegos AS v ON v.id = lp.videojuego_id
WHERE p.id = 1005
ORDER BY p.fecha, p.id, v.titulo;

SELECT p.id AS pedido_id,
       p.fecha,
       v.titulo,
       lp.unidades,
       lp.precio_unitario_euros
FROM pedidos AS p
JOIN lineas_pedido AS lp ON lp.pedido_id = p.id
JOIN videojuegos AS v ON v.id = lp.videojuego_id
ORDER BY p.fecha ASC, p.id ASC, v.titulo ASC;

-- 10. Leer la unión con criterio
SELECT COUNT(*) AS lineas_originales
FROM lineas_pedido;

SELECT COUNT(*) AS lineas_con_pedido_y_juego
FROM pedidos AS p
INNER JOIN lineas_pedido AS lp ON lp.pedido_id = p.id
INNER JOIN videojuegos AS v ON v.id = lp.videojuego_id;

SELECT v.id, v.titulo
FROM videojuegos AS v
LEFT JOIN lineas_pedido AS lp ON lp.videojuego_id = v.id
WHERE lp.id IS NULL
ORDER BY v.id;
