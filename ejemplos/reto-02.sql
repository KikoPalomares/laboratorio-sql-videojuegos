-- Reto 2. Filtrar por precio sin perder la frontera
-- Ejecuta cada consulta por separado en el laboratorio.

-- 2. Conservar solo algunas filas
SELECT titulo, precio_euros
FROM videojuegos
ORDER BY precio_euros ASC, titulo ASC;

SELECT titulo, precio_euros
FROM videojuegos
WHERE precio_euros <= 30
ORDER BY precio_euros ASC, titulo ASC;

-- 3. La diferencia entre menor y menor o igual
SELECT titulo, precio_euros
FROM videojuegos
WHERE precio_euros = 30;

SELECT titulo, precio_euros
FROM videojuegos
WHERE precio_euros <= 30
ORDER BY precio_euros ASC, titulo ASC;

-- 4. Pausa: predice qué queda fuera
SELECT titulo, precio_euros
FROM videojuegos
WHERE precio_euros = 30;

-- 5. Comprobar la frontera con dos filtros
SELECT titulo, precio_euros
FROM videojuegos
WHERE precio_euros < 30
ORDER BY precio_euros ASC, titulo ASC;

SELECT titulo, precio_euros
FROM videojuegos
WHERE precio_euros <= 30
ORDER BY precio_euros ASC, titulo ASC;

-- 6. Combinar condiciones sin cambiar la pregunta
SELECT titulo, precio_euros
FROM videojuegos
WHERE precio_euros <= 30 AND titulo = 'Ritmo de Neón' OR titulo = 'Niebla en Marte'
ORDER BY precio_euros ASC, titulo ASC;

SELECT titulo, precio_euros
FROM videojuegos
WHERE precio_euros <= 30 AND (titulo = 'Ritmo de Neón' OR titulo = 'Niebla en Marte')
ORDER BY precio_euros ASC, titulo ASC;

-- 7. Pausa: formula un filtro combinado
SELECT titulo, precio_euros
FROM videojuegos
WHERE precio_euros <= 30
ORDER BY precio_euros ASC, titulo ASC;

-- 8. Resolver la combinación
SELECT titulo, precio_euros
FROM videojuegos
WHERE precio_euros <= 30 AND (titulo = 'Ritmo de Neón' OR titulo = 'Niebla en Marte')
ORDER BY precio_euros ASC, titulo ASC;

SELECT titulo, precio_euros
FROM videojuegos
WHERE (precio_euros = 15 OR precio_euros = 25) AND precio_euros <= 30
ORDER BY precio_euros ASC, titulo ASC;

-- 9. Cierre: escribe la pregunta con precisión
SELECT titulo, precio_euros
FROM videojuegos
WHERE precio_euros <= 30
ORDER BY precio_euros ASC, titulo ASC;
