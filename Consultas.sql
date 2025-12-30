--- Consultas de la base de datos TecnoHogarCenter
USE TecnoHogarCenter;

SELECT * FROM cliente;
SELECT * FROM producto;

# Cantidad de registros por tabla
SELECT COUNT(*) FROM cliente;
SELECT COUNT(*) FROM producto;
SELECT COUNT(*) FROM productos_frecuentes;

---- Consultar datos de un cliente por cédula
SELECT *
FROM cliente
WHERE id_cliente = 1752004956;

--- Proyección: correo de un cliente por cédula
SELECT correo
FROM cliente
WHERE id_cliente = 1752004956;

--- Nombre y correo del cliente por cédula
SELECT nombre, correo
FROM cliente
WHERE id_cliente = 1752004956;

--- Consultar nombre y precio del producto por ID
SELECT nombre, precio
FROM producto
WHERE id_producto = 8;

--- Clientes cuyo nombre inicia con A
SELECT id_cliente, nombre
FROM cliente
WHERE nombre LIKE 'A%';

--- Productos que inician con #
SELECT id_producto, nombre
FROM producto
WHERE nombre LIKE 'C%';

--- Clientes cuyo nombre contiene Lopez
SELECT id_cliente, nombre
FROM cliente
WHERE nombre LIKE '%Lopez%';

--- Productos de categoría Linea Blanca
SELECT id_producto, nombre, categoria
FROM producto
WHERE categoria = 'Linea Blanca';

--- Productos cuyo nombre inicia con T
SELECT id_producto, nombre, precio
FROM producto
WHERE nombre LIKE 'T%';

--- ===============================
--- CLIENTES CON PRODUCTOS FRECUENTES
--- ===============================
SELECT
    pf.cedula_cliente AS cedula,
    c.nombre AS nombre_cliente,
    p.nombre AS producto,
    pf.frecuencia,
    pf.cantidad,
    pf.descuento
FROM productos_frecuentes pf
JOIN cliente c ON c.id_cliente = pf.cedula_cliente
JOIN producto p ON p.id_producto = pf.id_producto;

--- Clientes con descuento mayor al de otro cliente (ejemplo)
SELECT
    pf.cedula_cliente,
    c.nombre,
    pf.descuento
FROM productos_frecuentes pf
JOIN cliente c ON c.id_cliente = pf.cedula_cliente
WHERE pf.id_producto = 2
AND pf.descuento > (
    SELECT descuento
    FROM productos_frecuentes
    WHERE cedula_cliente = 1701245741
      AND id_producto = 2
);

--- Precio final con descuento
SELECT
    pf.cedula_cliente AS cedula,
    c.nombre AS cliente,
    p.nombre AS producto,
    p.precio AS precio_normal,
    pf.descuento,
    ROUND(p.precio - (p.precio * pf.descuento / 100), 2) AS precio_final
FROM productos_frecuentes pf
JOIN cliente c ON c.id_cliente = pf.cedula_cliente
JOIN producto p ON p.id_producto = pf.id_producto;

--- Productos que pueden ser reemplazados
SELECT
    p1.nombre AS producto_original,
    p2.nombre AS producto_alternativo
FROM productos_alternativos pa
JOIN producto p1 ON p1.id_producto = pa.producto_id
JOIN producto p2 ON p2.id_producto = pa.alternativa;

--- ===============================
--- PRODUCTO CARTESIANO
--- ===============================
SELECT *
FROM cliente, productos_frecuentes
WHERE cliente.id_cliente = productos_frecuentes.cedula_cliente;

--- Producto cartesiano con JOIN
SELECT
    c.id_cliente,
    c.nombre,
    p.nombre AS producto,
    pf.descuento
FROM cliente c
LEFT JOIN productos_frecuentes pf
    ON c.id_cliente = pf.cedula_cliente
LEFT JOIN producto p
    ON p.id_producto = pf.id_producto;


--- ===============================
--- FACTURAS
--- ===============================
USE TecnoHogarCenter;

-- =====================================
-- 1. CARGA DE DATOS (CABECERA)
-- Cliente: Maritza Alvaro (1701245741)
-- =====================================
INSERT INTO facturas
VALUES ('0000000100', '2025-12-19', 1701245741, 0);

-- =====================================
-- 1. CARGA DE DATOS (DETALLE – 3 PRODUCTOS)
-- =====================================
INSERT INTO facturadetalle VALUES
('0000000100', 2, 1, 450),   -- Refrigeradora Indurama
('0000000100', 5, 1, 350),   -- Microondas Indurama
('0000000100', 15, 1, 250);  -- Barra de sonido LG

-- =====================================
-- ACTUALIZAR TOTAL DE FACTURA
-- =====================================
UPDATE facturas
SET total = (
    SELECT SUM(cantidad * precio)
    FROM facturadetalle
    WHERE facturanumero = '0000000100'
)
WHERE facturanumero = '0000000100';

-- =====================================
-- 2. CABECERA DE FACTURA
-- =====================================
SELECT
    e.ruc,
    e.nombre AS empresa,
    e.direccion,
    e.telefono,
    f.facturanumero,
    f.fecha
FROM facturas f
CROSS JOIN empresa e
WHERE f.facturanumero = '0000000100';

-- =====================================
-- 3. DETALLE DE FACTURA
-- =====================================
SELECT
    p.id_producto,
    p.nombre AS producto,
    fd.cantidad,
    fd.precio,
    (fd.cantidad * fd.precio) AS subtotal
FROM facturadetalle fd
JOIN producto p ON p.id_producto = fd.producto_id
WHERE fd.facturanumero = '0000000100';

-- =====================================
-- 4. PIE DE FACTURA
-- =====================================
SELECT
    total,
    'EFECTIVO' AS forma_pago
FROM facturas
WHERE facturanumero = '0000000100';

-- Una condición de pertenencia a una lista de valores (IN) aplicada a un atributo de tipo cadena de caracteres ya dale el codigo con el titulo, ojo con mis datos que tengo y dime lo que hace con 1 ejemplo
SELECT *
FROM cliente
WHERE nombre IN ('Carlos Mena', 'Andrea Paredes', 'Lorena Sánchez');

-- Dos condiciones similares a la anterior, proyecta en tres columnas y crea una vista para contenerla
CREATE VIEW vista_clientes_condiciones_in AS
SELECT id_cliente, nombre, direccion
FROM cliente
WHERE nombre IN ('Carlos Mena')
  AND id_cliente IN (1710000005, 1710000001);

SELECT * FROM vista_clientes_condiciones_in;

#Valor monetario por producto vendido (detalle de factura)
 --Cuánto dinero genera cada producto vendido (cantidad × precio).
SELECT
    fd.producto_id,
    fd.cantidad,
    fd.precio,
    fd.cantidad * fd.precio AS subtotal
FROM facturadetalle fd;


#Total vendido por producto
 --Cuánto dinero total ha generado cada producto sumando todas las ventas.
SELECT
    p.id_producto,
    p.nombre,
    SUM(fd.cantidad * fd.precio) AS total_vendido
FROM facturadetalle fd
JOIN producto p ON p.id_producto = fd.producto_id
GROUP BY p.id_producto, p.nombre;


#Cliente que más compra (el que más dinero gasta)
  --Quién es el mejor cliente del almacén.
SELECT
    f.cliente_id,
    c.nombre,
    SUM(fd.cantidad * fd.precio) AS total_comprado
FROM facturadetalle fd
JOIN facturas f 
    ON f.facturanumero = fd.facturanumero
JOIN cliente c 
    ON c.id_cliente = f.cliente_id
GROUP BY f.cliente_id, c.nombre
ORDER BY total_comprado DESC
LIMIT 1;

    #Kardex de productos (entradas y salidas)
    --Movimiento del stock de un producto (ventas = salidas).
    CREATE OR REPLACE VIEW v_mov_ventas AS
    SELECT
        f.fecha,
        fd.producto_id,
        p.nombre AS producto,
        f.facturanumero,
        'VENTA' AS tipo_mov,
        fd.cantidad AS salida
    FROM facturadetalle fd
    LEFT JOIN facturas f 
        ON f.facturanumero = fd.facturanumero
    LEFT JOIN producto p 
        ON p.id_producto = fd.producto_id;

    SELECT * 
    FROM v_mov_ventas
    ORDER BY fecha;

    SELECT 
        fecha,
        producto,
        facturanumero,
        salida
    FROM v_mov_ventas;

#Saldo acumulado (stock lógico)
  --Cómo va bajando el stock con cada venta.
SELECT
    fecha,
    producto_id,
    producto,
    tipo_mov,
    salida,
    SUM(-salida) OVER (
        PARTITION BY producto_id
        ORDER BY fecha
    ) AS saldo
FROM v_mov_ventas;
