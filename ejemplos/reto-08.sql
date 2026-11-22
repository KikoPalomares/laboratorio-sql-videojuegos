-- Reto 8. Resumir las ventas por mes
-- Ejecuta cada consulta por separado en el laboratorio.

-- 1. La pregunta mensual
SELECT strftime('%Y-%m', fecha) AS mes, COUNT(*) AS pedidos
FROM pedidos
GROUP BY strftime('%Y-%m', fecha)
ORDER BY mes;

SELECT id AS pedido_id, fecha
FROM pedidos
ORDER BY fecha, id;

-- 2. Convertir una fecha en mes
SELECT fecha, strftime('%Y-%m', fecha) AS mes
FROM pedidos
ORDER BY fecha;

SELECT fecha
FROM pedidos
WHERE fecha >= '2026-10-01' AND fecha < '2026-11-01'
ORDER BY fecha;

-- 3. Filtrar un mes completo
SELECT id AS pedido_id, fecha
FROM pedidos
WHERE fecha >= '2026-10-01' AND fecha < '2026-11-01'
ORDER BY fecha;

SELECT id AS pedido_id, fecha
FROM pedidos
WHERE fecha >= '2026-11-01' AND fecha < '2026-12-01'
ORDER BY fecha;

-- 4. Pausa: pedidos por mes
SELECT fecha
FROM pedidos
ORDER BY fecha, id;

-- 5. Solución: cuatro pedidos cada mes
SELECT strftime('%Y-%m', p.fecha) AS mes,
       COUNT(*) AS numero_pedidos
FROM pedidos AS p
GROUP BY strftime('%Y-%m', p.fecha)
ORDER BY mes ASC;

SELECT strftime('%Y-%m', fecha) AS mes, COUNT(*) AS numero_pedidos
FROM pedidos
GROUP BY mes
ORDER BY mes;

-- 6. El pedido se repite al unir líneas
SELECT strftime('%Y-%m', p.fecha) AS mes,
       COUNT(p.id) AS filas_de_linea,
       COUNT(DISTINCT p.id) AS pedidos_distintos
FROM pedidos AS p
JOIN lineas_pedido AS lp ON lp.pedido_id = p.id
GROUP BY strftime('%Y-%m', p.fecha)
ORDER BY mes;

SELECT strftime('%Y-%m', p.fecha) AS mes,
       p.id AS pedido_id,
       COUNT(*) AS lineas_de_ese_pedido
FROM pedidos AS p
JOIN lineas_pedido AS lp ON lp.pedido_id = p.id
GROUP BY mes, p.id
ORDER BY mes, p.id;

-- 7. Sumar unidades e ingresos
SELECT strftime('%Y-%m', p.fecha) AS mes,
       SUM(lp.unidades) AS unidades_vendidas
FROM pedidos AS p
JOIN lineas_pedido AS lp ON lp.pedido_id = p.id
GROUP BY mes
ORDER BY mes;

SELECT strftime('%Y-%m', p.fecha) AS mes,
       SUM(lp.unidades * lp.precio_unitario_euros) AS facturacion_euros
FROM pedidos AS p
JOIN lineas_pedido AS lp ON lp.pedido_id = p.id
GROUP BY mes
ORDER BY mes;

-- 8. Pausa: informe mensual completo
SELECT p.id AS pedido_id, p.fecha, lp.unidades, lp.precio_unitario_euros
FROM pedidos AS p
JOIN lineas_pedido AS lp ON lp.pedido_id = p.id
ORDER BY p.fecha, p.id, lp.id
LIMIT 5;

-- 9. Solución: agrupar sin duplicar pedidos
SELECT strftime('%Y-%m', p.fecha) AS mes,
       COUNT(DISTINCT p.id) AS numero_pedidos,
       SUM(lp.unidades) AS unidades_vendidas,
       SUM(lp.unidades * lp.precio_unitario_euros) AS facturacion_euros
FROM pedidos AS p
JOIN lineas_pedido AS lp ON lp.pedido_id = p.id
GROUP BY strftime('%Y-%m', p.fecha)
ORDER BY mes ASC;

SELECT (SELECT COUNT(*) FROM pedidos) AS pedidos,
       (SELECT SUM(unidades) FROM lineas_pedido) AS unidades,
       (SELECT SUM(unidades * precio_unitario_euros) FROM lineas_pedido) AS facturacion_euros;

-- 10. Conciliar cifras antes de promediar
SELECT strftime('%Y-%m', p.fecha) AS mes,
       COUNT(DISTINCT p.id) AS pedidos,
       SUM(lp.unidades) AS unidades,
       SUM(lp.unidades * lp.precio_unitario_euros) AS euros
FROM pedidos AS p
JOIN lineas_pedido AS lp ON lp.pedido_id = p.id
GROUP BY mes
ORDER BY mes;

SELECT COUNT(DISTINCT p.id) AS pedidos_totales,
       SUM(lp.unidades) AS unidades_totales,
       SUM(lp.unidades * lp.precio_unitario_euros) AS ingresos_totales
FROM pedidos AS p
JOIN lineas_pedido AS lp ON lp.pedido_id = p.id;
