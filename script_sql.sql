DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;


CREATE TABLE clientes (
    id_cliente  SERIAL PRIMARY KEY,
    nombre  VARCHAR(80)  NOT NULL,
    apellido  VARCHAR(80)  NOT NULL,
    email  VARCHAR(120) NOT NULL UNIQUE,
    edad  INT  NOT NULL CHECK (edad >= 18),
    fecha_registro DATE  NOT NULL DEFAULT CURRENT_DATE
);
--Los precios estan expresados en dolares (USD)
CREATE TABLE productos (
    id_producto  SERIAL PRIMARY KEY,
    nombre  VARCHAR(100)  NOT NULL,
    categoria  VARCHAR(50) NOT NULL,
    precio  DECIMAL(10,2) NOT NULL CHECK (precio > 0),
    stock   INT  NOT NULL CHECK (stock >= 0)
);

CREATE TABLE ventas (
    id_venta  SERIAL  PRIMARY KEY,
    id_cliente  INT  NOT NULL,
    id_producto  INT  NOT NULL,
    cantidad  INT  NOT NULL CHECK (cantidad > 0),
    precio_unitario  DECIMAL(10,2)  NOT NULL CHECK (precio_unitario > 0),
    fecha_venta  DATE   NOT NULL DEFAULT CURRENT_DATE, 
    CONSTRAINT fk_ventas_cliente  FOREIGN KEY (id_cliente)  REFERENCES clientes (id_cliente),
    CONSTRAINT fk_ventas_producto FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);



BEGIN; 

INSERT INTO clientes (nombre, apellido, email, edad, fecha_registro) VALUES
('Javier', 'Martinez', 'jmartinez10@gmail.com', 20, '2026-02-10'), 
('Matias', 'Gonzales', 'matias.gonzales@gmail.com', 28, '2026-02-14'), 
('Martina', 'Gomez', 'martigomez4@gmail.com', 25, '2026-03-02'), 
('Julieta', 'Garcia', 'juligarcia00@gmail.com', 26, '2026-03-07'), 
('Nicolas', 'Risso', 'nicolas.risso@gmail.com', 45, '2026-03-18');

INSERT INTO productos (nombre, categoria, precio, stock) VALUES
('Auriculares Bluetooth', 'Electrónica', 49.99, 40),
('Cargador USB-C', 'Electrónica', 35.00, 120),
('Licuadora', 'Hogar', 60.00, 25),
('Juego de sábanas', 'Hogar',  29.99, 60),
('Campera impermeable', 'Indumentaria', 89.99, 30),
('Remera algodón', 'Indumentaria',  25.00, 200);

INSERT INTO ventas (id_cliente, id_producto, cantidad, precio_unitario, fecha_venta) VALUES
(1, 1, 1, 49.99, '2026-06-01'),
(2, 3, 1, 60.00, '2026-06-03'),
(3, 6, 3, 25.00, '2026-06-05'),
(4, 2, 2, 35.00, '2026-06-10'),
(5, 5, 1, 89.99, '2026-06-12'),
(1, 4, 2, 29.99, '2026-06-15'),
(5, 6, 5, 25.00, '2026-06-20');

COMMIT;


--aumento del 10% a los productos de la categoría 'Electrónica'
SELECT id_producto, nombre, categoria, precio
FROM productos
WHERE categoria = 'Electrónica';

UPDATE productos
SET precio = ROUND(precio * 1.10, 2)
WHERE categoria = 'Electrónica';

--DELETE de venta 

SELECT * 
FROM ventas
WHERE id_venta = 7;


DELETE 
FROM ventas
WHERE id_venta = 7;

SELECT * FROM ventas ORDER BY id_venta;








