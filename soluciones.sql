-- Reto 1: ¿Qué videojuego tiene el precio más alto y cuál es ese precio?
SELECT titulo, precio_euros
FROM videojuegos
ORDER BY precio_euros DESC
LIMIT 1;

-- Reto 2: ¿Qué juegos cuestan 30 euros o menos? Ordénalos de menor a mayor precio.
SELECT titulo, precio_euros
FROM videojuegos
WHERE precio_euros <= 30
ORDER BY precio_euros ASC, titulo ASC;

-- Reto 3: ¿Qué pedidos se hicieron en noviembre de 2026? Muéstralos por fecha.
SELECT id AS pedido_id, fecha
FROM pedidos
WHERE fecha >= '2026-11-01' AND fecha < '2026-12-01'
ORDER BY fecha ASC, id ASC;

-- Reto 4: ¿Cuántos juegos hay y cuál es su precio medio?
SELECT COUNT(*) AS total_videojuegos,
       ROUND(AVG(precio_euros), 2) AS precio_medio_euros
FROM videojuegos;

-- Reto 5: ¿Qué identificadores de juego acumulan más unidades vendidas?
SELECT videojuego_id, SUM(unidades) AS unidades_vendidas
FROM lineas_pedido
GROUP BY videojuego_id
ORDER BY unidades_vendidas DESC, videojuego_id ASC;

-- Reto 6: ¿Qué juegos aparecen en cada línea de pedido, en qué fecha y a qué precio se vendieron?
SELECT p.id AS pedido_id,
       p.fecha,
       v.titulo,
       lp.unidades,
       lp.precio_unitario_euros
FROM pedidos AS p
JOIN lineas_pedido AS lp ON lp.pedido_id = p.id
JOIN videojuegos AS v ON v.id = lp.videojuego_id
ORDER BY p.fecha ASC, p.id ASC, v.titulo ASC;

-- Reto 7: ¿Qué clientes todavía no han hecho ningún pedido?
SELECT c.id AS cliente_id,
       c.nombre
FROM clientes AS c
LEFT JOIN pedidos AS p ON p.cliente_id = c.id
WHERE p.id IS NULL
ORDER BY c.id ASC;

-- Reto 8: ¿Cuánto se facturó cada mes, cuántas unidades se vendieron y cuántos pedidos hubo?
SELECT strftime('%Y-%m', p.fecha) AS mes,
       COUNT(DISTINCT p.id) AS numero_pedidos,
       SUM(lp.unidades) AS unidades_vendidas,
       SUM(lp.unidades * lp.precio_unitario_euros) AS facturacion_euros
FROM pedidos AS p
JOIN lineas_pedido AS lp ON lp.pedido_id = p.id
GROUP BY strftime('%Y-%m', p.fecha)
ORDER BY mes ASC;

-- Reto 9: ¿Cuál es el ticket medio por pedido, contando cada pedido una sola vez?
WITH totales_por_pedido AS (
    SELECT p.id AS pedido_id,
           SUM(lp.unidades * lp.precio_unitario_euros) AS total_euros
    FROM pedidos AS p
    JOIN lineas_pedido AS lp ON lp.pedido_id = p.id
    GROUP BY p.id
)
SELECT ROUND(AVG(total_euros), 2) AS ticket_medio_euros
FROM totales_por_pedido;

-- Reto 10: ¿Cómo queda el catálogo ordenado por facturación, con unidades y número de pedidos para cada juego? Incluye también los juegos sin ventas.
SELECT v.titulo,
       COALESCE(SUM(lp.unidades * lp.precio_unitario_euros), 0) AS facturacion_euros,
       COALESCE(SUM(lp.unidades), 0) AS unidades_vendidas,
       COUNT(DISTINCT p.id) AS numero_pedidos
FROM videojuegos AS v
LEFT JOIN lineas_pedido AS lp ON lp.videojuego_id = v.id
LEFT JOIN pedidos AS p ON p.id = lp.pedido_id
GROUP BY v.id, v.titulo
ORDER BY facturacion_euros DESC, unidades_vendidas DESC, v.titulo ASC;
