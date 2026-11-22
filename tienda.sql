-- Tienda ficticia para practicar SQLite.
-- Ejecuta este archivo una sola vez sobre una base de datos vacía.
PRAGMA foreign_keys = ON;

CREATE TABLE clientes (
    id INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL
);

CREATE TABLE videojuegos (
    id INTEGER PRIMARY KEY,
    titulo TEXT NOT NULL UNIQUE,
    precio_euros INTEGER NOT NULL CHECK (precio_euros >= 0)
);

CREATE TABLE pedidos (
    id INTEGER PRIMARY KEY,
    cliente_id INTEGER NOT NULL,
    fecha TEXT NOT NULL CHECK (fecha GLOB '????-??-??'),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE lineas_pedido (
    id INTEGER PRIMARY KEY,
    pedido_id INTEGER NOT NULL,
    videojuego_id INTEGER NOT NULL,
    unidades INTEGER NOT NULL CHECK (unidades > 0),
    precio_unitario_euros INTEGER NOT NULL CHECK (precio_unitario_euros >= 0),
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    FOREIGN KEY (videojuego_id) REFERENCES videojuegos(id),
    UNIQUE (pedido_id, videojuego_id)
);

INSERT INTO clientes (id, nombre) VALUES
    (1, 'Nebulosa Azul'),
    (2, 'Cartucho Errante'),
    (3, 'Cometa Verde'),
    (4, 'Pixel Nómada'),
    (5, 'Lector Solar'),
    (6, 'Isla del Eco'),
    (7, 'Taller Horizonte');

-- Órbita de Cobre tiene el ID 8 para que ordenar por precio sea visible.
INSERT INTO videojuegos (id, titulo, precio_euros) VALUES
    (1, 'Niebla en Marte', 45),
    (2, 'Bosque Binario', 35),
    (3, 'Pixel de Medianoche', 20),
    (4, 'Islas de Silicio', 30),
    (5, 'Laberinto Lunar', 50),
    (6, 'Ritmo de Neón', 15),
    (7, 'Mareas de Datos', 25),
    (8, 'Órbita de Cobre', 60);

INSERT INTO pedidos (id, cliente_id, fecha) VALUES
    (1001, 1, '2026-10-04'),
    (1002, 2, '2026-10-06'),
    (1003, 3, '2026-10-14'),
    (1004, 1, '2026-10-27'),
    (1005, 4, '2026-11-02'),
    (1006, 5, '2026-11-12'),
    (1007, 2, '2026-11-20'),
    (1008, 3, '2026-11-24');

-- En esta muestra, el precio cobrado coincide con el precio del catálogo.
INSERT INTO lineas_pedido
    (id, pedido_id, videojuego_id, unidades, precio_unitario_euros)
VALUES
    (1, 1001, 3, 2, 20),
    (2, 1001, 1, 1, 45),
    (3, 1002, 6, 4, 15),
    (4, 1003, 4, 1, 30),
    (5, 1003, 2, 1, 35),
    (6, 1004, 3, 3, 20),
    (7, 1004, 5, 1, 50),
    (8, 1005, 3, 2, 20),
    (9, 1005, 6, 2, 15),
    (10, 1006, 8, 1, 60),
    (11, 1006, 3, 1, 20),
    (12, 1007, 1, 2, 45),
    (13, 1007, 4, 2, 30),
    (14, 1008, 2, 1, 35),
    (15, 1008, 6, 3, 15);
