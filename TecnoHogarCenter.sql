create database TecnoHogarCenter

show DATABASES;

use TecnoHogarCenter;

#Creación de Tablas 
CREATE TABLE producto (
    id_producto INT PRIMARY KEY,
    nombre VARCHAR(50),
    marca VARCHAR(30),
    categoria VARCHAR(20),
    precio DECIMAL(10,2),
    stock INT,
    proveedor_id CHAR(13),
    FOREIGN KEY (proveedor_id) REFERENCES provedores(RUC)
);

CREATE Table cliente(
    id_cliente int PRIMARY key,
    nombre VARCHAR(50),
    telefono VARCHAR(13),
    correo VARCHAR (50),
    direccion VARCHAR(50)
);

CREATE TABLE provedores (
    RUC CHAR(13) PRIMARY KEY,
    nombre VARCHAR(50),
    telefono VARCHAR(15),
    correo VARCHAR(50)
);

CREATE TABLE empleado (
    id_empleado INT PRIMARY KEY,
    nombre VARCHAR(50),
    cargo VARCHAR(13),
    sueldo DECIMAL(10,2),
    hora_entrada TIME,
    hora_salida TIME
);

CREATE TABLE proveedor_productos (
    proveedor_ruc CHAR(13),
    producto_id INT,
    proveedor_precio DECIMAL(10,2),
    lote INT,
    plazo INT,

    PRIMARY KEY (proveedor_ruc, producto_id),

    CONSTRAINT pp_proveedor_fk
        FOREIGN KEY (proveedor_ruc)
        REFERENCES provedores(RUC),

    CONSTRAINT pp_producto_fk
        FOREIGN KEY (producto_id)
        REFERENCES producto(id_producto)
);


#Tabla Empresa Guarda los datos del negocio
CREATE TABLE empresa (
    ruc CHAR(13) PRIMARY KEY,
    nombre VARCHAR(100),
    direccion VARCHAR(100),
    telefono VARCHAR(15),
    correo VARCHAR(50)
);

#Tabla Facturas 
CREATE TABLE facturas (
    facturanumero CHAR(10) PRIMARY KEY,
    fecha DATE,
    cliente_id INT,
    total DECIMAL(10,2)
);

ALTER TABLE facturas
ADD CONSTRAINT factura_cliente_fk
FOREIGN KEY (cliente_id) REFERENCES cliente(id_cliente);

#Tabla Factuardetalle Guarda los productos que se venden en cada factura
CREATE TABLE facturadetalle (
    facturanumero CHAR(10),
    producto_id INT,
    cantidad INT,
    precio DECIMAL(10,2),
    PRIMARY KEY (facturanumero, producto_id)
);

ALTER TABLE facturadetalle
ADD CONSTRAINT fd_factura_fk
FOREIGN KEY (facturanumero) REFERENCES facturas(facturanumero);

ALTER TABLE facturadetalle
ADD CONSTRAINT fd_producto_fk
FOREIGN KEY (producto_id) REFERENCES producto(id_producto);

# Validar que la cantidad sea mayor a 0
ALTER TABLE facturadetalle
ADD CONSTRAINT cantidad_ck
CHECK (cantidad > 0);
#Validar que el precio sea mayor a 0
ALTER TABLE facturadetalle
ADD CONSTRAINT precio_ck
CHECK (precio > 0);

CREATE TABLE productos_alternativos (
    producto_id INT,
    alternativa INT,
    PRIMARY KEY (producto_id, alternativa),
    FOREIGN KEY (producto_id) REFERENCES producto(id_producto),
    FOREIGN KEY (alternativa) REFERENCES producto(id_producto)
);

#Tabla de Clinetes frecuentes 
CREATE TABLE clientes_frecuentes (
    cliente_id INT,
    producto_id INT,
    frecuencia CHAR(3),        -- Ej: SEM (semanal), MEN (mensual)
    paquete CHAR(2),           -- Ej: SI/NO, si aplica paquete promocional
    cantidad INT,
    descuento DECIMAL(5,2),
    PRIMARY KEY (cliente_id, producto_id),
    FOREIGN KEY (cliente_id) REFERENCES cliente(id_cliente),
    FOREIGN KEY (producto_id) REFERENCES producto(id_producto)
);

ALTER TABLE clientes_frecuentes
MODIFY descuento DECIMAL(5,2) DEFAULT 0;

#Registro de Productos
INSERT INTO producto
VALUES (1, 'Cocina de gas', 'Indurama', 'Linea Blanca', 300, 5, '17000000001');

INSERT INTO producto
VALUES (2, 'Refrigeradora', 'Indurama', 'Linea Blanca', 450, 4, '17000000001');

INSERT INTO producto
VALUES (3, 'Lavadora', 'Indurama', 'Linea Blanca', 520, 6, '17000000001');

INSERT INTO producto
VALUES (4, 'secadora', 'Indurama', 'Linea Blanca', 540, 5, '17000000001');

INSERT INTO producto
VALUES (5, 'Microondas', 'Indurama', 'Electro Menores', 350, 7, '17000000001');
 

INSERT INTO producto
VALUES (6, 'Refrigeradora', 'Mabe Ecuador', 'Linea Blanca', 320, 5, '17000000002');

INSERT INTO producto
VALUES (7, 'Lavadora Automática', 'Mabe Ecuador', 'Linea Blanca', 450, 6, '17000000002');

INSERT INTO producto
VALUES (8, 'Cocina Electrica', 'Mabe Ecuador', 'Linea Blanca', 530, 4, '17000000002');

INSERT INTO producto
VALUES (9, 'Microondas', 'Mabe Ecuador', 'Electro Menores', 440, 3, '17000000002');

INSERT INTO producto
VALUES (10, 'Licuadora', 'Mabe Ecuador', 'Electro Menores', 250, 7, '17000000002');
 

INSERT INTO producto
VALUES (11, 'Refrigeradora Smart', 'LG Ecuador', 'Linea Blanca', 520, 5, '17000000003');

INSERT INTO producto
VALUES (12, 'Lavadora Smart', 'LG Ecuador', 'Linea Blanca', 550, 5, '17000000003');

INSERT INTO producto
VALUES (13, 'Televisor LED', 'LG Ecuador', 'Electro menores', 430, 4, '17000000003');

INSERT INTO producto
VALUES (14, 'TelevisorSmart tv', 'LG Ecuador', 'Electro Menores', 440, 3, '17000000003');

INSERT INTO producto
VALUES (15, 'Barra de sonido', 'LG Ecuador', 'Linea Gris', 250, 7, '17000000003');


INSERT INTO producto
VALUES (16, 'TelevisorSmart tv', 'Samsung Ecuador', 'Linea Gris', 320, 4, '17000000004');

INSERT INTO producto
VALUES (17, 'Aire acondicionado', 'Samsung Ecuador', 'Climatizacion', 250, 6, '17000000004');

INSERT INTO producto
VALUES (18, 'Celular Samsung Galaxy', 'Samsung Ecuador', 'Tecnologia', 530, 9, '17000000004');

INSERT INTO producto
VALUES (19, 'Tablet', 'Samsung Ecuador', 'Tecnologia', 440, 8, '17000000004');

INSERT INTO producto
VALUES (20, 'Monitor', 'Samsung Ecuador', 'Linea Gris', 150, 10, '17000000004');

#Registrp de Cliente
INSERT INTO cliente
VALUES( 1752004956, 'Jorge Lopez', '0954123689', 'jorge12@gmail.com', 'Pintado');
INSERT INTO cliente
VALUES( 1726485103, 'Rosita Raza', '0925147852', 'rosa13@gmail.com', 'Mascota');
INSERT INTO cliente
VALUES( 1701245741, 'Maritza Alvaro', '0923145781', 'maritza14@gmail.com', 'Magdalena');

#Registro de Provedores
INSERT INTO provedores
VALUES ('17000000001', 'Indurama Ecuador', 'Jose Cortez', 'indurama@gmail.ec');

INSERT INTO provedores
VALUES ('17000000002', 'Mabe Ecuador', 'Armando Tapia', 'mabe@gmail.ec');

INSERT INTO provedores
VALUES ('17000000003', 'LG Ecuador', 'Luis Caza', 'lgecuador@gmail.ec');

INSERT INTO provedores
VALUES ('17000000004', 'Samsung Ecuador', 'Amelia Sanchez', 'samsung@gmail.ec');

#Registo de Empleados
INSERT INTO empleado
VALUES( 1720245698, 'Jeneffer Tallana', 'Vendedor', 200, '07:00:00', '14:00:00');

INSERT INTO empleado
VALUES( 1752004879, 'Isaac Lema', 'Vendedor', 200, '02:00:00', '19:00:00');

INSERT INTO empleado
VALUES( 1752003610, 'Amelia Vizcaino', 'Cajero', 250, '07:00:00', '14:00:00');

INSERT INTO empleado
VALUES( 1720364851, 'Paulo Taipe', 'cajero', 250, '02:00:00', '19:00:00');

INSERT INTO empleado
VALUES( 1120336047, 'Nathaly Vizcaino', 'Encargado', 500, '09:00:00', '18:00:00');

INSERT INTO empleado
VALUES( 1520013690, 'Isaac Lema', 'Administrador', 600, '10:00:00', '19:00:00');

#Regintro de Empresa 
INSERT INTO empresa
VALUES ('17999999999', 'Tecno Hogar Center', 'Av. Amazonas y Patria', '022345678', 'contacto@tecnohogar.ec');

#Registro Relación cliente ↔ facturas (FOREIGN KEY)
INSERT INTO facturas
VALUES ('0000000001', '2025-01-16', 1752004956, 600);

INSERT INTO facturas
VALUES ('0000000002', '2025-12-05', 1701245741, 900);

INSERT INTO facturas
VALUES ('0000000003', '2025-12-11', 1726485103, 440);

#Registro Facturadetalle 
INSERT INTO facturadetalle
VALUES ('0000000001', 1, 2, 300);

INSERT INTO facturadetalle
VALUES ('0000000002', 2, 2, 900);

INSERT INTO facturadetalle
VALUES ('0000000003', 9, 1, 440);

#Registro maayor a 0 y menor a 0 
   #Refrigeradora Indurama puede ser sustituida por Refrigeradora Mabe
INSERT INTO productos_alternativos 
VALUES (2, 6);

   #Televisor LG puede ser sustituido por Televisor Samsung
INSERT INTO productos_alternativos 
VALUES (13, 16);

   #Microondas Indurama puede ser sustituido por Microondas Mabe
INSERT INTO productos_alternativos 
VALUES (5, 9);

#Registro de clientes frecuentes 
       -- Maritza Alvaro 2 Refrigeradoras Indurama cada mes con 5% de descuento
INSERT INTO clientes_frecuentes 
VALUES (1701245741, 2, 'MEN', 'NO', 2, 5.00);

       -- Rosita Raza 1 Microondas Mabe cada semana con 10% de descuento
INSERT INTO clientes_frecuentes 
VALUES (1726485103, 9, 'SEM', 'NO', 1, 10.00);

#Registro PROVEEDOR_PRODUCTOS
INSERT INTO proveedor_productos
VALUES ('17000000001', 1, 250.00, 5, 60);

INSERT INTO proveedor_productos
VALUES ('17000000001', 2, 380.00, 4, 90);

INSERT INTO proveedor_productos
VALUES ('17000000002', 6, 290.00, 5, 98);

INSERT INTO proveedor_productos
VALUES ('17000000003', 11, 480.00, 5, 93);

INSERT INTO proveedor_productos
VALUES ('17000000004', 16, 300.00, 4, 100);

#Comado para ejecutar tabla 
select * from producto;
select * from cliente;
select * from provedores;
select * from empleado;
SELECT * FROM empresa;
SELECT *  FROM facturas;
SELECT * FROM facturadetalle;
SELECT * FROM productos_alternativos;
SELECT * FROM clientes_frecuentes;
SELECT * FROM proveedor_productos

