-- =========================
-- CREACIÓN DE LA BASE DE DATOS
-- =========================
CREATE DATABASE TecnoHogarCenter;

-- =========================
-- MOSTRAR BASES DE DATOS
-- =========================
SHOW DATABASES;

-- =========================
-- SELECCIÓN DE BASE DE DATOS
-- =========================
USE TecnoHogarCenter;

-- =========================
-- TABLA DUEÑO
-- =========================
CREATE TABLE dueño (
    cedula INT PRIMARY KEY,
    nombre VARCHAR(50),
    cargo VARCHAR(20),
    telefono VARCHAR(15)
);

-- =========================
-- TABLA PROVEEDORES
-- =========================
CREATE TABLE proveedores (
    RUC CHAR(13) PRIMARY KEY,
    nombre VARCHAR(50),
    telefono VARCHAR(15),
    correo VARCHAR(50)
);

-- =========================
-- TABLA CLIENTE
-- =========================
CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(50),
    telefono VARCHAR(13),
    correo VARCHAR(50),
    direccion VARCHAR(50)
);

-- =========================
-- TABLA PRODUCTO
-- =========================
CREATE TABLE producto (
    id_producto INT PRIMARY KEY,
    nombre VARCHAR(50),
    marca VARCHAR(30),
    categoria VARCHAR(20),
    precio DECIMAL(10,2),
    stock INT,
    proveedor_id CHAR(13),
    FOREIGN KEY (proveedor_id) REFERENCES proveedores(RUC)
);

-- =========================
-- TABLA EMPLEADO
-- =========================
CREATE TABLE empleado (
    id_empleado INT PRIMARY KEY,
    nombre VARCHAR(50),
    cargo VARCHAR(13),
    sueldo DECIMAL(10,2),
    hora_entrada TIME,
    hora_salida TIME
);

-- =========================
-- TABLA PROVEEDOR_PRODUCTOS
-- =========================
CREATE TABLE proveedor_productos (
    proveedor_ruc CHAR(13),
    producto_id INT,
    proveedor_precio DECIMAL(10,2),
    lote INT,
    plazo INT,
    PRIMARY KEY (proveedor_ruc, producto_id),
    FOREIGN KEY (proveedor_ruc) REFERENCES proveedores(RUC),
    FOREIGN KEY (producto_id) REFERENCES producto(id_producto)
);

-- =========================
-- TABLA PRODUCTOS_FRECUENTES
-- =========================
CREATE TABLE productos_frecuentes (
    cedula_cliente INT,
    id_producto INT,
    frecuencia ENUM('DIA','SEM','MES'),
    cantidad INT,
    descuento DECIMAL(5,2) DEFAULT 0,
    PRIMARY KEY (cedula_cliente, id_producto),
    FOREIGN KEY (cedula_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

-- =========================
-- TABLA EMPRESA
-- =========================
CREATE TABLE empresa (
    ruc CHAR(13) PRIMARY KEY,
    nombre VARCHAR(100),
    direccion VARCHAR(100),
    telefono VARCHAR(15),
    correo VARCHAR(50)
);

-- =========================
-- TABLA FACTURAS
-- =========================
CREATE TABLE facturas (
    facturanumero CHAR(10) PRIMARY KEY,
    fecha DATE,
    cliente_id INT,
    total DECIMAL(10,2),
    FOREIGN KEY (cliente_id) REFERENCES cliente(id_cliente)
);

-- =========================
-- TABLA FACTURADETALLE
-- =========================
CREATE TABLE facturadetalle (
    facturanumero CHAR(10),
    producto_id INT,
    cantidad INT CHECK (cantidad > 0),
    precio DECIMAL(10,2) CHECK (precio > 0),
    PRIMARY KEY (facturanumero, producto_id),
    FOREIGN KEY (facturanumero) REFERENCES facturas(facturanumero),
    FOREIGN KEY (producto_id) REFERENCES producto(id_producto)
);

-- =========================
-- TABLA PRODUCTOS_ALTERNATIVOS
-- =========================
CREATE TABLE productos_alternativos (
    producto_id INT,
    alternativa INT,
    PRIMARY KEY (producto_id, alternativa),
    FOREIGN KEY (producto_id) REFERENCES producto(id_producto),
    FOREIGN KEY (alternativa) REFERENCES producto(id_producto)
);

-- =========================
-- TABLA CLIENTES_FRECUENTES
-- =========================
CREATE TABLE clientes_frecuentes (
    cliente_id INT,
    producto_id INT,
    frecuencia CHAR(3),
    cantidad INT,
    descuento DECIMAL(5,2) DEFAULT 0,
    PRIMARY KEY (cliente_id, producto_id),
    FOREIGN KEY (cliente_id) REFERENCES cliente(id_cliente),
    FOREIGN KEY (producto_id) REFERENCES producto(id_producto)
);

-- =========================
-- DATOS DEL DUEÑO
-- =========================
INSERT INTO dueño
VALUES (1752004828, 'Roger Tallana', 'Dueño', '0998626028');

-- =========================
-- REGISTRO DE PROVEEDORES
-- =========================
INSERT INTO proveedores VALUES
('17000000001','Indurama Ecuador','Jose Cortez','indurama@gmail.ec'),
('17000000002','Mabe Ecuador','Armando Tapia','mabe@gmail.ec'),
('17000000003','LG Ecuador','Luis Caza','lgecuador@gmail.ec'),
('17000000004','Samsung Ecuador','Amelia Sanchez','samsung@gmail.ec');

-- =========================
-- REGISTRO DE PRODUCTOS
-- =========================
INSERT INTO producto VALUES
(1,'Cocina de gas','Indurama','Linea Blanca',300,5,'17000000001'),
(2,'Refrigeradora','Indurama','Linea Blanca',450,4,'17000000001'),
(3,'Lavadora','Indurama','Linea Blanca',520,6,'17000000001'),
(4,'Secadora','Indurama','Linea Blanca',540,5,'17000000001'),
(5,'Microondas','Indurama','Electro Menores',350,7,'17000000001'),
(6,'Refrigeradora','Mabe Ecuador','Linea Blanca',320,5,'17000000002'),
(7,'Lavadora Automática','Mabe Ecuador','Linea Blanca',450,6,'17000000002'),
(8,'Cocina Eléctrica','Mabe Ecuador','Linea Blanca',530,4,'17000000002'),
(9,'Microondas','Mabe Ecuador','Electro Menores',440,3,'17000000002'),
(10,'Licuadora','Mabe Ecuador','Electro Menores',250,7,'17000000002'),
(11,'Refrigeradora Smart','LG Ecuador','Linea Blanca',520,5,'17000000003'),
(12,'Lavadora Smart','LG Ecuador','Linea Blanca',550,5,'17000000003'),
(13,'Televisor LED','LG Ecuador','Electro Menores',430,4,'17000000003'),
(14,'Televisor Smart TV','LG Ecuador','Electro Menores',440,3,'17000000003'),
(15,'Barra de sonido','LG Ecuador','Linea Gris',250,7,'17000000003'),
(16,'Televisor Smart TV','Samsung Ecuador','Linea Gris',320,4,'17000000004'),
(17,'Aire acondicionado','Samsung Ecuador','Climatizacion',250,6,'17000000004'),
(18,'Celular Samsung Galaxy','Samsung Ecuador','Tecnologia',530,9,'17000000004'),
(19,'Tablet','Samsung Ecuador','Tecnologia',440,8,'17000000004'),
(20,'Monitor','Samsung Ecuador','Linea Gris',150,10,'17000000004');

-- =========================
-- REGISTRO DE CLIENTES
-- =========================
INSERT INTO cliente VALUES
(1752004956,'Jorge Lopez','0954123689','jorge12@gmail.com','Pintado'),
(1726485103,'Rosita Raza','0925147852','rosa13@gmail.com','Mascota'),
(1701245741,'Maritza Alvaro','0923145781','maritza14@gmail.com','Magdalena');

-- =========================
-- REGISTRO DE EMPLEADOS
-- =========================
INSERT INTO empleado VALUES
(1720245698,'Jeneffer Tallana','Vendedor',200,'07:00:00','14:00:00'),
(1752004879,'Isaac Lema','Vendedor',200,'02:00:00','19:00:00'),
(1752003610,'Amelia Vizcaino','Cajero',250,'07:00:00','14:00:00'),
(1720364851,'Paulo Taipe','Cajero',250,'02:00:00','19:00:00'),
(1120336047,'Nathaly Vizcaino','Encargado',500,'09:00:00','18:00:00'),
(1520013690,'Isaac Lema','Administrador',600,'10:00:00','19:00:00'),
(1752004828,'Roger Tallana','Dueño',0,'00:00:00','00:00:00');

-- =========================
-- REGISTRO DE EMPRESA
-- =========================
INSERT INTO empresa
VALUES ('17999999999','Tecno Hogar Center','Av. Amazonas y Patria','022345678','contacto@tecnohogar.ec');

-- =========================
-- REGISTRO DE FACTURAS
-- =========================
INSERT INTO facturas VALUES
('0000000001','2025-01-16',1752004956,600),
('0000000002','2025-12-05',1701245741,900),
('0000000003','2025-12-11',1726485103,440);

-- =========================
-- REGISTRO DE FACTURADETALLE
-- =========================
INSERT INTO facturadetalle VALUES
('0000000001',1,2,300),
('0000000002',2,2,900),
('0000000003',9,1,440);

-- =========================
-- REGISTRO DE PRODUCTOS ALTERNATIVOS
-- =========================
INSERT INTO productos_alternativos VALUES
(2,6),(13,16),(5,9);

-- =========================
-- REGISTRO DE CLIENTES FRECUENTES
-- =========================
INSERT INTO clientes_frecuentes VALUES
(1701245741,2,'MEN',2,5.00),
(1726485103,9,'SEM',1,10.00);

-- =========================
-- REGISTRO PROVEEDOR_PRODUCTOS
-- =========================
INSERT INTO proveedor_productos VALUES
('17000000001',1,250.00,5,60),
('17000000001',2,380.00,4,90),
('17000000002',6,290.00,5,98),
('17000000003',11,480.00,5,93),
('17000000004',16,300.00,4,100);

-- =========================
-- REGISTRO DE PRODUCTOS FRECUENTES
-- =========================
INSERT INTO productos_frecuentes VALUES
(1701245741,2,'MES',2,5.00),
(1726485103,9,'SEM',1,10.00);

-- =========================
-- CONSULTAS
-- =========================
SELECT * FROM dueño;
SELECT * FROM producto;
SELECT * FROM cliente;
SELECT * FROM proveedores;
SELECT * FROM empleado;
SELECT * FROM empresa;
SELECT * FROM facturas;
SELECT * FROM facturadetalle;
SELECT * FROM productos_alternativos;
SELECT * FROM clientes_frecuentes;
SELECT * FROM proveedor_productos;
SELECT * FROM productos_frecuentes;
