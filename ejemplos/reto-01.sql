-- Reto 1. La primera consulta: el precio más alto
-- Ejecuta cada consulta por separado en el laboratorio.

-- 2. Leer y ordenar el catálogo
SELECT titulo, precio_euros
FROM videojuegos;

SELECT titulo, precio_euros
FROM videojuegos
ORDER BY precio_euros DESC;

SELECT titulo, precio_euros
FROM videojuegos
ORDER BY precio_euros DESC
LIMIT 1;

-- 3. Pausa: busca el precio más bajo
SELECT titulo, precio_euros
FROM videojuegos
ORDER BY precio_euros DESC
LIMIT 1;

-- 4. Resolver el extremo contrario
SELECT titulo, precio_euros
FROM videojuegos
ORDER BY precio_euros ASC
LIMIT 1;

SELECT titulo, precio_euros
FROM videojuegos
ORDER BY precio_euros ASC;

-- 5. Una fila puede representar cosas distintas
SELECT id, cliente_id, fecha
FROM pedidos
ORDER BY id ASC
LIMIT 4;

SELECT id, titulo, precio_euros
FROM videojuegos
ORDER BY id ASC
LIMIT 4;

-- 6. Mostrar columnas y decidir un orden
SELECT titulo, precio_euros
FROM videojuegos
ORDER BY precio_euros DESC, titulo ASC
LIMIT 3;

SELECT precio_euros, titulo
FROM videojuegos
ORDER BY precio_euros DESC, titulo ASC
LIMIT 3;

-- 7. Deshacer un empate con otro criterio
WITH ejemplo(titulo, precio_euros) AS (VALUES ('Zeta', 30), ('Amanecer', 30), ('Lunar', 20))
SELECT titulo, precio_euros
FROM ejemplo
ORDER BY precio_euros DESC;

WITH ejemplo(titulo, precio_euros) AS (VALUES ('Zeta', 30), ('Amanecer', 30), ('Lunar', 20))
SELECT titulo, precio_euros
FROM ejemplo
ORDER BY precio_euros DESC, titulo ASC;

-- 8. Aplicar el orden ascendente
WITH ejemplo(titulo, precio_euros) AS (VALUES ('Zeta', 30), ('Amanecer', 30), ('Lunar', 20))
SELECT titulo, precio_euros
FROM ejemplo
ORDER BY precio_euros ASC, titulo ASC;

SELECT titulo, precio_euros
FROM videojuegos
ORDER BY precio_euros ASC, titulo ASC
LIMIT 3;

-- 9. Cierre: leer antes de contar
SELECT id, fecha
FROM pedidos
ORDER BY id ASC
LIMIT 3;
