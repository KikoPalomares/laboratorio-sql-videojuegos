-- Reto 9. Calcular el ticket medio por pedido
-- Ejecuta cada consulta por separado en el laboratorio.

-- 1. Qué significa ticket medio
SELECT SUM(unidades * precio_unitario_euros) AS ingresos_totales
FROM lineas_pedido;

SELECT COUNT(*) AS numero_pedidos
FROM pedidos;

-- 2. El subtotal de una línea
SELECT v.titulo, lp.unidades, lp.precio_unitario_euros,
       lp.unidades * lp.precio_unitario_euros AS subtotal_euros
FROM lineas_pedido AS lp
JOIN videojuegos AS v ON v.id = lp.videojuego_id
WHERE lp.pedido_id = 1001
ORDER BY lp.id;

SELECT SUM(unidades * precio_unitario_euros) AS importe_pedido_1001
FROM lineas_pedido
WHERE pedido_id = 1001;

-- 3. Una fila por pedido
SELECT p.id AS pedido_id,
       p.fecha,
       SUM(lp.unidades * lp.precio_unitario_euros) AS total_euros
FROM pedidos AS p
JOIN lineas_pedido AS lp ON lp.pedido_id = p.id
GROUP BY p.id, p.fecha
ORDER BY p.id;

SELECT p.id AS pedido_id,
       SUM(lp.unidades * lp.precio_unitario_euros) AS total_euros
FROM pedidos AS p
JOIN lineas_pedido AS lp ON lp.pedido_id = p.id
WHERE p.id = 1007
GROUP BY p.id;

-- 4. Pausa: calcula un ticket
SELECT pedido_id, unidades, precio_unitario_euros
FROM lineas_pedido
WHERE pedido_id = 1004
ORDER BY id;

-- 5. Solución del pedido 1004. Tres copias a 20 € y una a 50 € suman 110 €.
SELECT p.id AS pedido_id,
       SUM(lp.unidades * lp.precio_unitario_euros) AS total_euros
FROM pedidos AS p
JOIN lineas_pedido AS lp ON lp.pedido_id = p.id
WHERE p.id = 1004
GROUP BY p.id;

SELECT COUNT(*) AS pedidos_con_total
FROM (
  SELECT p.id
  FROM pedidos AS p
  JOIN lineas_pedido AS lp ON lp.pedido_id = p.id
  GROUP BY p.id
);

-- 6. Nombrar el paso intermedio
WITH totales_por_pedido AS (
  SELECT p.id AS pedido_id,
         SUM(lp.unidades * lp.precio_unitario_euros) AS total_euros
  FROM pedidos AS p
  JOIN lineas_pedido AS lp ON lp.pedido_id = p.id
  GROUP BY p.id
)
SELECT pedido_id, total_euros
FROM totales_por_pedido
ORDER BY pedido_id;

WITH totales_por_pedido AS (
  SELECT p.id AS pedido_id,
         SUM(lp.unidades * lp.precio_unitario_euros) AS total_euros
  FROM pedidos AS p
  JOIN lineas_pedido AS lp ON lp.pedido_id = p.id
  GROUP BY p.id
)
SELECT ROUND(AVG(total_euros), 2) AS ticket_medio_euros
FROM totales_por_pedido;

-- 7. Un promedio con el grano equivocado
SELECT ROUND(AVG(lp.unidades * lp.precio_unitario_euros), 2) AS subtotal_medio_por_linea
FROM pedidos AS p
JOIN lineas_pedido AS lp ON lp.pedido_id = p.id;

WITH totales_por_pedido AS (
  SELECT p.id AS pedido_id,
         SUM(lp.unidades * lp.precio_unitario_euros) AS total_euros
  FROM pedidos AS p
  JOIN lineas_pedido AS lp ON lp.pedido_id = p.id
  GROUP BY p.id
)
SELECT ROUND(AVG(total_euros), 2) AS ticket_medio_por_pedido
FROM totales_por_pedido;

-- 8. Pausa: ticket medio de la tienda
SELECT id AS pedido_id
FROM pedidos
ORDER BY id;

-- 9. Solución: el promedio de ocho tickets
WITH totales_por_pedido AS (
    SELECT p.id AS pedido_id,
           SUM(lp.unidades * lp.precio_unitario_euros) AS total_euros
    FROM pedidos AS p
    JOIN lineas_pedido AS lp ON lp.pedido_id = p.id
    GROUP BY p.id
)
SELECT ROUND(AVG(total_euros), 2) AS ticket_medio_euros
FROM totales_por_pedido;

WITH totales_por_pedido AS (
  SELECT p.id AS pedido_id,
         SUM(lp.unidades * lp.precio_unitario_euros) AS total_euros
  FROM pedidos AS p
  JOIN lineas_pedido AS lp ON lp.pedido_id = p.id
  GROUP BY p.id
)
SELECT COUNT(*) AS pedidos,
       SUM(total_euros) AS ingresos,
       ROUND(AVG(total_euros), 2) AS ticket_medio
FROM totales_por_pedido;

-- 10. Comprobar el total antes de cerrar
WITH totales_por_pedido AS (
  SELECT p.id AS pedido_id,
         SUM(lp.unidades * lp.precio_unitario_euros) AS total_euros
  FROM pedidos AS p
  JOIN lineas_pedido AS lp ON lp.pedido_id = p.id
  GROUP BY p.id
)
SELECT COUNT(*) AS pedidos,
       SUM(total_euros) AS ingresos,
       ROUND(AVG(total_euros), 2) AS ticket_medio
FROM totales_por_pedido;

WITH totales_por_pedido AS (
  SELECT p.id AS pedido_id,
         SUM(lp.unidades * lp.precio_unitario_euros) AS total_euros
  FROM pedidos AS p
  JOIN lineas_pedido AS lp ON lp.pedido_id = p.id
  GROUP BY p.id
)
SELECT SUM(total_euros) AS ingresos_totales
FROM totales_por_pedido;
