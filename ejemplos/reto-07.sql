-- Reto 7. Conservar filas con LEFT JOIN
-- Ejecuta cada consulta por separado en el laboratorio.

-- 1. La ausencia también responde
SELECT c.id AS cliente_id, c.nombre, p.id AS pedido_id
FROM clientes AS c
INNER JOIN pedidos AS p ON p.cliente_id = c.id
ORDER BY c.id, p.id;

SELECT COUNT(*) AS filas_con_pedido,
       COUNT(DISTINCT c.id) AS clientes_con_pedido
FROM clientes AS c
INNER JOIN pedidos AS p ON p.cliente_id = c.id;

-- 2. La izquierda conserva la fila
SELECT c.id AS cliente_id, c.nombre, p.id AS pedido_id, p.fecha
FROM clientes AS c
LEFT JOIN pedidos AS p ON p.cliente_id = c.id
ORDER BY c.id, p.id;

SELECT COUNT(*) AS filas_conservadas
FROM clientes AS c
LEFT JOIN pedidos AS p ON p.cliente_id = c.id;

-- 3. Qué filas conserva cada unión
SELECT (SELECT COUNT(*) FROM clientes AS c INNER JOIN pedidos AS p ON p.cliente_id = c.id) AS filas_internas,
       (SELECT COUNT(*) FROM clientes AS c LEFT JOIN pedidos AS p ON p.cliente_id = c.id) AS filas_por_la_izquierda;

SELECT c.id AS cliente_id, c.nombre, p.id AS pedido_id
FROM clientes AS c
LEFT JOIN pedidos AS p ON p.cliente_id = c.id
WHERE p.id IS NOT NULL
ORDER BY c.id, p.id;

-- 4. Pausa: encuentra quien no compró
SELECT c.nombre, p.id AS pedido_id
FROM clientes AS c
LEFT JOIN pedidos AS p ON p.cliente_id = c.id
ORDER BY c.id, p.id;

-- 5. Solución: identificar los nulos
SELECT c.id AS cliente_id,
       c.nombre
FROM clientes AS c
LEFT JOIN pedidos AS p ON p.cliente_id = c.id
WHERE p.id IS NULL
ORDER BY c.id ASC;

SELECT COUNT(*) AS clientes_sin_pedido
FROM clientes AS c
LEFT JOIN pedidos AS p ON p.cliente_id = c.id
WHERE p.id IS NULL;

-- 6. El filtro puede ir en la unión
SELECT c.id AS cliente_id, c.nombre, p.id AS pedido_id, p.fecha
FROM clientes AS c
LEFT JOIN pedidos AS p
  ON p.cliente_id = c.id
 AND p.fecha >= '2026-11-01'
 AND p.fecha < '2026-12-01'
ORDER BY c.id, p.id;

SELECT c.id AS cliente_id, c.nombre, p.id AS pedido_id, p.fecha
FROM clientes AS c
LEFT JOIN pedidos AS p ON p.cliente_id = c.id
WHERE p.fecha >= '2026-11-01'
  AND p.fecha < '2026-12-01'
ORDER BY c.id, p.id;

-- 7. Contar pedidos sin contar nulos
SELECT c.nombre, COUNT(*) AS filas_del_resultado, COUNT(p.id) AS pedidos_reales
FROM clientes AS c
LEFT JOIN pedidos AS p ON p.cliente_id = c.id
GROUP BY c.id, c.nombre
ORDER BY c.id;

SELECT COUNT(p.id) AS total_pedidos
FROM clientes AS c
LEFT JOIN pedidos AS p ON p.cliente_id = c.id;

-- 8. Pausa: pedidos de noviembre por cliente
SELECT c.nombre, p.id AS pedido_id, p.fecha
FROM clientes AS c
LEFT JOIN pedidos AS p ON p.cliente_id = c.id
ORDER BY c.id, p.id;

-- 9. Solución: el periodo dentro de ON
SELECT c.id AS cliente_id,
       c.nombre,
       COUNT(p.id) AS pedidos_en_noviembre
FROM clientes AS c
LEFT JOIN pedidos AS p
  ON p.cliente_id = c.id
 AND p.fecha >= '2026-11-01'
 AND p.fecha < '2026-12-01'
GROUP BY c.id, c.nombre
ORDER BY c.id;

SELECT COUNT(p.id) AS total_pedidos_en_noviembre
FROM clientes AS c
LEFT JOIN pedidos AS p
  ON p.cliente_id = c.id
 AND p.fecha >= '2026-11-01'
 AND p.fecha < '2026-12-01';

-- 10. Una comprobación antes de agrupar
SELECT COUNT(*) AS clientes
FROM clientes;

SELECT c.nombre, COUNT(p.id) AS pedidos
FROM clientes AS c
LEFT JOIN pedidos AS p ON p.cliente_id = c.id
GROUP BY c.id, c.nombre
HAVING COUNT(p.id) > 1
ORDER BY c.id;
