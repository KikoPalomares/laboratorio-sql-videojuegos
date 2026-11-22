-- Reto 10. Clasificar el catálogo por ventas
-- Ejecuta cada consulta por separado en el laboratorio.

-- 1. Tres preguntas, tres métricas
SELECT v.titulo, SUM(lp.unidades) AS unidades_vendidas
FROM lineas_pedido AS lp
JOIN videojuegos AS v ON v.id = lp.videojuego_id
GROUP BY v.id, v.titulo
ORDER BY unidades_vendidas DESC, v.titulo
LIMIT 3;

SELECT v.titulo,
       SUM(lp.unidades * lp.precio_unitario_euros) AS facturacion_euros
FROM lineas_pedido AS lp
JOIN videojuegos AS v ON v.id = lp.videojuego_id
GROUP BY v.id, v.titulo
ORDER BY facturacion_euros DESC, v.titulo
LIMIT 3;

-- 2. La unión interna deja fuera el catálogo vacío
SELECT v.id, v.titulo, SUM(lp.unidades) AS unidades_vendidas
FROM videojuegos AS v
JOIN lineas_pedido AS lp ON lp.videojuego_id = v.id
GROUP BY v.id, v.titulo
ORDER BY v.id;

SELECT COUNT(*) AS juegos_en_catalogo
FROM videojuegos;

-- 3. Conservar cada juego
SELECT v.titulo,
       COALESCE(SUM(lp.unidades * lp.precio_unitario_euros), 0) AS facturacion_euros,
       COALESCE(SUM(lp.unidades), 0) AS unidades_vendidas,
       COUNT(DISTINCT p.id) AS numero_pedidos
FROM videojuegos AS v
LEFT JOIN lineas_pedido AS lp ON lp.videojuego_id = v.id
LEFT JOIN pedidos AS p ON p.id = lp.pedido_id
GROUP BY v.id, v.titulo
ORDER BY facturacion_euros DESC, unidades_vendidas DESC, v.titulo ASC;

SELECT v.titulo,
       SUM(lp.unidades) AS suma_sin_rellenar,
       COALESCE(SUM(lp.unidades), 0) AS unidades_con_cero
FROM videojuegos AS v
LEFT JOIN lineas_pedido AS lp ON lp.videojuego_id = v.id
GROUP BY v.id, v.titulo
ORDER BY v.id;

-- 4. Pausa: prepara el informe del catálogo
SELECT id, titulo
FROM videojuegos
ORDER BY id;

-- 5. Solución: informe de ocho juegos
SELECT v.titulo,
       COALESCE(SUM(lp.unidades * lp.precio_unitario_euros), 0) AS facturacion_euros,
       COALESCE(SUM(lp.unidades), 0) AS unidades_vendidas,
       COUNT(DISTINCT p.id) AS numero_pedidos
FROM videojuegos AS v
LEFT JOIN lineas_pedido AS lp ON lp.videojuego_id = v.id
LEFT JOIN pedidos AS p ON p.id = lp.pedido_id
GROUP BY v.id, v.titulo
ORDER BY facturacion_euros DESC, unidades_vendidas DESC, v.titulo ASC;

SELECT v.titulo,
       COALESCE(SUM(lp.unidades * lp.precio_unitario_euros), 0) AS facturacion_euros,
       COALESCE(SUM(lp.unidades), 0) AS unidades_vendidas,
       COUNT(DISTINCT p.id) AS numero_pedidos
FROM videojuegos AS v
LEFT JOIN lineas_pedido AS lp ON lp.videojuego_id = v.id
LEFT JOIN pedidos AS p ON p.id = lp.pedido_id
WHERE v.titulo = 'Mareas de Datos'
GROUP BY v.id, v.titulo;

-- 6. Revisar los recuentos
SELECT v.titulo, COUNT(*) AS filas_resultantes, COUNT(p.id) AS pedidos_contados, COUNT(DISTINCT p.id) AS pedidos_distintos
FROM videojuegos AS v
LEFT JOIN lineas_pedido AS lp ON lp.videojuego_id = v.id
LEFT JOIN pedidos AS p ON p.id = lp.pedido_id
GROUP BY v.id, v.titulo
ORDER BY v.id;

SELECT v.titulo, COUNT(*) AS filas_resultantes, COUNT(p.id) AS pedidos_contados
FROM videojuegos AS v
LEFT JOIN lineas_pedido AS lp ON lp.videojuego_id = v.id
LEFT JOIN pedidos AS p ON p.id = lp.pedido_id
WHERE v.titulo = 'Mareas de Datos'
GROUP BY v.id, v.titulo;

-- 7. Vender más o facturar más
SELECT v.titulo, SUM(lp.unidades) AS unidades_vendidas
FROM videojuegos AS v
JOIN lineas_pedido AS lp ON lp.videojuego_id = v.id
GROUP BY v.id, v.titulo
ORDER BY unidades_vendidas DESC, v.titulo
LIMIT 1;

SELECT v.titulo, SUM(lp.unidades * lp.precio_unitario_euros) AS facturacion_euros
FROM videojuegos AS v
JOIN lineas_pedido AS lp ON lp.videojuego_id = v.id
GROUP BY v.id, v.titulo
ORDER BY facturacion_euros DESC, v.titulo
LIMIT 1;

-- 8. Pausa: un reto de transferencia
SELECT id, titulo
FROM videojuegos
ORDER BY titulo;

-- 9. Solución: Pixel en cuatro pedidos
SELECT v.titulo,
       COUNT(DISTINCT p.id) AS numero_pedidos
FROM videojuegos AS v
LEFT JOIN lineas_pedido AS lp ON lp.videojuego_id = v.id
LEFT JOIN pedidos AS p ON p.id = lp.pedido_id
GROUP BY v.id, v.titulo
ORDER BY numero_pedidos DESC, v.titulo ASC;

SELECT v.titulo, COUNT(DISTINCT p.id) AS numero_pedidos
FROM videojuegos AS v
LEFT JOIN lineas_pedido AS lp ON lp.videojuego_id = v.id
LEFT JOIN pedidos AS p ON p.id = lp.pedido_id
WHERE v.titulo = 'Pixel de Medianoche'
GROUP BY v.id, v.titulo;

-- 10. Cierre del curso
SELECT v.titulo,
       COALESCE(SUM(lp.unidades * lp.precio_unitario_euros), 0) AS facturacion_euros,
       COALESCE(SUM(lp.unidades), 0) AS unidades_vendidas,
       COUNT(DISTINCT p.id) AS numero_pedidos
FROM videojuegos AS v
LEFT JOIN lineas_pedido AS lp ON lp.videojuego_id = v.id
LEFT JOIN pedidos AS p ON p.id = lp.pedido_id
GROUP BY v.id, v.titulo
ORDER BY facturacion_euros DESC, unidades_vendidas DESC, v.titulo ASC;

SELECT COUNT(*) AS pedidos,
       SUM(unidades) AS unidades,
       SUM(unidades * precio_unitario_euros) AS ingresos_euros
FROM lineas_pedido;
