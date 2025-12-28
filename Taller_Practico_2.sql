use TecnoHogarCenter;
#Una condición de igualdad aplicada a un atributo de tipo entero
 ---Mostrar el cliente con id_cliente = 1710000005
SELECT *
FROM cliente
WHERE id_cliente = 1710000005;

#Una condición de igualdad aplicada a un atributo de tipo cadena de caracteres
  ---Mostrar el cliente cuyo nombre sea 'Carlos Mena'
SELECT *
FROM cliente
WHERE nombre = 'Carlos Mena';

#Una condición de mayor igual que aplicada a un atributo de tipo decimal
   ---Mostrar productos cuyo precio sea mayor o igual a 200
SELECT *
FROM producto
WHERE precio >= 200.00;

#Una condición de distinto aplicada a un atributo de tipo cadena de caracteres
   ---Mostrar productos cuya categoría sea distinta a 'Hogar'
SELECT *
FROM producto
WHERE categoria <> 'Hogar';

#Una condición de pertenencia a una lista de valores (IN) aplicada a un atributo de tipo cadena de caracteres
   ------ Mostrar productos que pertenezcan a las categorías 'Hogar', 'Audio' o 'Electro Menores'
SELECT *
FROM producto
WHERE categoria IN ('Hogar', 'Audio', 'Electro Menores');

#Dos condiciones a su elección, unidas con el operador AND
   ---Productos de la categoría 'Hogar' con precio mayor o igual a 200
SELECT *
FROM producto
WHERE categoria = 'Hogar' 
AND precio >= 200;

#Doc condiciones similares a la anterior, proyecta en tres columnas y crea una vista para contenerla
   ---Crear vista con tres columnas y condiciones
CREATE OR REPLACE VIEW vista_productos_hogar_caros AS
SELECT nombre, categoria, precio
FROM producto
WHERE categoria = 'Hogar'
  AND precio >= 200;
   -- Consultar la vista
SELECT * FROM vista_productos_hogar_caros;

#Dos condiciones a su elección, unidas con el operador OR
SELECT nombre, categoria, precio
FROM producto
WHERE categoria = 'Electro Menores'
   OR precio > 300;

#Una condición a su elección y el operador NOT
SELECT nombre, categoria, precio
FROM producto
WHERE NOT categoria = 'Hogar';

#La operación JOIN en base de dos tablas que dispongan de la restricción de clave foránea
   ---Listado de facturas con información del cliente correspondiente
SELECT f.facturanumero, f.fecha, f.total,
       c.id_cliente, c.nombre, c.correo
FROM facturas f
JOIN cliente c ON f.cliente_id = c.id_cliente;

#La operación JOIN como la anterior, proyecta en tres columnas, y crea una vista para contenerla.
-- Crear vista con JOIN entre facturas y cliente, proyectando 3 columnas
CREATE OR REPLACE VIEW vista_facturas_clientes AS
SELECT 
    f.facturanumero,
    f.fecha,
    c.nombre AS nombre_cliente
FROM facturas f
JOIN cliente c 
    ON f.cliente_id = c.id_cliente;

SELECT * FROM vista_facturas_clientes;


#La operación LEFT JOIN en base de dos tablas que dispongan de la restricción de clave foránea
SELECT 
    c.id_cliente,
    c.nombre AS nombre_cliente,
    f.facturanumero,
    f.fecha,
    f.total
FROM cliente c
LEFT JOIN facturas f
    ON c.id_cliente = f.cliente_id ;

#La operación RIGHT JOIN en base de dos tablas que dispongan de la restricción de clave foránea
SELECT 
    p.id_producto,
    p.nombre AS nombre_producto,
    pr.nombre AS nombre_proveedor
FROM producto p
RIGHT JOIN proveedores pr
    ON p.proveedor_id = pr.RUC;

#La operación LEFT JOIN en base de una tabla que disponga de una auto referencia
SELECT 
    p.nombre AS producto,
    pa.alternativa AS id_alternativa,
    p2.nombre AS nombre_alternativa
FROM producto p
LEFT JOIN productos_alternativos pa
    ON p.id_producto = pa.producto_id
LEFT JOIN producto p2
    ON pa.alternativa = p2.id_producto;

#Un ordenamiento sobre un atributo de forma descendente
SELECT 
    id_producto,
    nombre,
    precio
FROM producto
ORDER BY precio DESC;

#Un ordenamiento sobre dos atributos, el primero ascendente y el segundo descendente
SELECT
    id_producto,
    nombre,
    categoria,
    precio
FROM producto
ORDER BY categoria ASC, precio DESC;

#Un agrupamiento sobre un atributo que no posee una restricción de unicidad y una operación de conteo
SELECT
    marca,
    COUNT(*) AS total_productos
FROM producto
GROUP BY marca;

#Una proyección con tres columnas, una de ellas calculada, con operadores matemáticos
SELECT
    facturanumero,
    producto_id,
    cantidad * precio AS total_linea
FROM facturadetalle;

#Una proyección con tres columnas, una de ellas calculada, con concatenación de caracteres
SELECT
    id_cliente,
    nombre,
    CONCAT(nombre, ' - ', direccion) AS nombre_direccion
FROM cliente;

#Una proyeccción con tres columnas similar a la anterior y crea una vista para contenerla
CREATE VIEW vista_cliente_direccion AS
SELECT
    id_cliente,
    nombre,
    CONCAT(nombre, ' - ', direccion) AS nombre_direccion
FROM cliente;

SELECT * FROM vista_cliente_direccion;

#Una subconsulta que retorne un valor, basada en una restricción de clave foránea
SELECT nombre,
       (SELECT COUNT(*)
        FROM facturas f
        WHERE f.cliente_id = c.id_cliente) AS total_facturas
FROM cliente c
WHERE id_cliente = 1710000001;


