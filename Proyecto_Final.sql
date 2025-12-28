USE TecnoHogarCenter;
-- =====================================
-- 1. CONDICIÓN DE IGUALDAD (ENTERO)
-- =====================================
-- Mostrar un cliente usando igualdad sobre un atributo entero (id_cliente)
SELECT *
FROM cliente
WHERE id_cliente = 1752004956;

-- =====================================
-- 2. CONDICIÓN DE IGUALDAD (CADENA DE CARACTERES)
-- =====================================
-- Mostrar productos filtrando por un atributo de tipo texto
SELECT *
FROM producto
WHERE categoria = 'Linea Blanca';
SELECT *
FROM producto
WHERE categoria = 'Electro Menores';
SELECT *
FROM producto
WHERE categoria = 'Linea Gris';
SELECT *
FROM producto
WHERE categoria = 'Climatizacion';
SELECT *
FROM producto
WHERE categoria = 'Tecnologia';
SELECT *
FROM producto
WHERE categoria = 'Hogar';
SELECT *
FROM producto
WHERE categoria = 'Audio';
SELECT *
FROM producto
WHERE categoria = 'Smart Home';

-- =====================================
-- 3. CONDICIÓN MAYOR O IGUAL (DECIMAL)
-- =====================================
-- Mostrar productos cuyo precio sea mayor o igual a un valor decimal
SELECT
    id_producto,
    nombre,
    precio
FROM producto
WHERE precio >= 500.00;

-- =====================================
-- 4. CONDICIÓN DISTINTO (CADENA DE CARACTERES)
-- =====================================
-- Mostrar productos cuya categoría sea distinta a un valor específico
SELECT
    id_producto,
    nombre,
    categoria
FROM producto
WHERE categoria <> 'Electrónica';

-- =====================================
-- 5. CONDICIÓN IN (LISTA DE VALORES)
-- =====================================
-- Mostrar productos cuya categoría pertenezca a una lista de valores
SELECT
    id_producto,
    nombre,
    categoria
FROM producto
WHERE categoria IN ('Electrónica', 'Linea Blanca', 'Hogar');

-- =====================================
-- 6. DOS CONDICIONES UNIDAS CON AND
-- =====================================
-- Mostrar clientes cuyo nombre sea 'Carlos Mena' y su dirección sea 'Mena 2'
SELECT
    id_cliente,
    nombre,
    direccion
FROM cliente
WHERE nombre = 'Carlos Mena'
  AND direccion = 'Mena 2';

-- =====================================
-- 7. DOS CONDICIONES SIMILARES Y CREAR VISTA
-- =====================================
-- Crear vista con clientes cuyo nombre sea 'Miguel Andrade' y id_cliente 1710000005
CREATE VIEW vista_clientes_and AS
SELECT id_cliente, nombre, direccion
FROM cliente
WHERE nombre = 'Miguel Andrade'
  AND id_cliente = 1710000005;

SELECT * FROM vista_clientes_and;

-- =====================================
-- 8. DOS CONDICIONES UNIDAS CON OR
-- =====================================
-- Mostrar clientes cuyo nombre sea 'Paola Herrera' o dirección sea 'Turubamba'
SELECT
    id_cliente,
    nombre,
    direccion
FROM cliente
WHERE nombre = 'Paola Herrera'
   OR direccion = 'Turubamba';

-- =====================================
-- 9. CONDICIÓN Y EL OPERADOR NOT
-- =====================================
-- Mostrar clientes cuyo nombre NO sea 'Fernando Viteri'
SELECT
    id_cliente,
    nombre,
    direccion
FROM cliente
WHERE NOT nombre = 'Fernando Viteri';

-- =====================================
-- 10. JOIN ENTRE DOS TABLAS CON CLAVE FORÁNEA
-- =====================================
-- Mostrar facturas con los datos del cliente correspondiente
SELECT
    f.facturanumero,
    f.fecha,
    c.nombre AS cliente,
    f.total
FROM facturas f
JOIN cliente c ON c.id_cliente = f.cliente_id;


-- =====================================
-- 11. JOIN PROYECTANDO TRES COLUMNAS Y CREANDO VISTA
-- =====================================
-- Crear una vista con facturas, nombre del cliente y total
CREATE VIEW vista_facturas_clientes AS
SELECT
    f.facturanumero,
    c.nombre AS cliente,
    f.total
FROM facturas f
JOIN cliente c ON c.id_cliente = f.id_cliente;

-- Consultar la vista creada
SELECT * FROM vista_facturas_clientes;


-- =====================================
-- 12. LEFT JOIN ENTRE DOS TABLAS CON CLAVE FORÁNEA
-- =====================================
-- Mostrar todos los clientes y sus productos frecuentes si existen
SELECT
    c.id_cliente,
    c.nombre AS cliente,
    pf.id_producto,
    pf.frecuencia
FROM cliente c
LEFT JOIN productos_frecuentes pf ON c.id_cliente = pf.cedula_cliente;


-- =====================================
-- 13. RIGHT JOIN ENTRE DOS TABLAS CON CLAVE FORÁNEA
-- =====================================
-- Mostrar todos los productos frecuentes y los clientes asociados si existen
SELECT
    pf.id_producto,
    pf.cedula_cliente,
    c.nombre AS cliente
FROM productos_frecuentes pf
RIGHT JOIN cliente c ON c.id_cliente = pf.cedula_cliente;


-- =====================================
-- 14. LEFT JOIN SOBRE AUTO REFERENCIA (EMPLEADO-JEFE)
-- =====================================
ALTER TABLE empleado
ADD COLUMN id_jefe INT NULL;

-- Asignar jefes
-- Vendedores y Cajeros reportan a Isaac Lema (Administrador)
UPDATE empleado SET id_jefe = 1520013690 WHERE id_empleado IN (1720245698, 1752004879, 1752003610, 1720364851);

-- Isaac Lema (Administrador) reporta a Nathaly Vizcaino (Encargado)
UPDATE empleado SET id_jefe = 1120336047 WHERE id_empleado = 1520013690;

-- Nathaly Vizcaino (Encargado) reporta al Dueño Roger Tallana
UPDATE empleado SET id_jefe = 1752004828 WHERE id_empleado = 1120336047;

-- El Dueño no tiene jefe (NULL)
UPDATE empleado SET id_jefe = NULL WHERE id_empleado = 1752004828;

SELECT
    e.id_empleado,
    e.nombre AS empleado,
    e.cargo AS cargo_empleado,
    j.nombre AS jefe,
    j.cargo AS cargo_jefe
FROM empleado e
LEFT JOIN empleado j ON e.id_jefe = j.id_empleado;


-- =====================================
-- 15. ORDENAMIENTO DESCENDENTE
-- =====================================
-- Mostrar clientes ordenados por id_cliente descendente
SELECT *
FROM cliente
ORDER BY id_cliente DESC;


-- =====================================
-- 16. ORDENAMIENTO POR DOS ATRIBUTOS
-- =====================================
-- Mostrar productos ordenados por categoria ascendente y precio descendente
SELECT *
FROM producto
ORDER BY categoria ASC, precio DESC;


-- =====================================
-- 17. AGRUPAMIENTO Y CONTEO
-- =====================================
-- Contar cuántos clientes hay por ciudad (atributo no único)
SELECT direccion, COUNT(*) AS cantidad_clientes
FROM cliente
GROUP BY direccion;


-- =====================================
-- 18. PROYECCIÓN CON TRES COLUMNAS Y CÁLCULO MATEMÁTICO
-- =====================================
-- Mostrar cliente, total de sus facturas y 10% de descuento aplicado
SELECT
    c.nombre AS cliente,
    f.total AS total_factura,
    ROUND(f.total * 0.10, 2) AS descuento_10
FROM facturas f
JOIN cliente c ON c.id_cliente = f.cliente_id;

-- =====================================
-- 19. CONCAT
-- =====================================
-- Mostrar cliente con información concatenada de nombre y correo
SELECT
    id_cliente,
    CONCAT('Cliente: ', nombre, ' - Correo: ', correo) AS info_cliente,
    direccion
FROM cliente;


-- =====================================
-- 20. CONCAT + VISTA
-- =====================================
-- Crear una vista con nombre y correo concatenados y mostrarla
CREATE VIEW vista_clientes_info AS
SELECT
    id_cliente,
    CONCAT(nombre, ' (', correo, ')') AS info_cliente,
    direccion
FROM cliente;

SELECT * FROM vista_clientes_info;


-- =====================================
-- 21. SUBCONSULTA (CLAVE FORÁNEA)
-- =====================================
-- Mostrar facturas cuyo total es igual a la suma de sus detalles
SELECT *
FROM facturas f
WHERE total = (
    SELECT SUM(fd.precio * fd.cantidad)
    FROM facturadetalle fd
    WHERE fd.facturanumero = f.facturanumero
);


-- =====================================
-- 22. FECHA + CURDATE
-- =====================================
-- Mostrar facturas registradas en la fecha actual del sistema
SELECT facturanumero, fecha, cliente_id, total
FROM facturas
WHERE fecha = '2025-05-13';

-- =====================================
-- 23. BETWEEN (FECHA)
-- =====================================
-- Mostrar facturas emitidas entre dos fechas
SELECT facturanumero, fecha, cliente_id, total
FROM facturas
WHERE fecha BETWEEN '2025-01-01' AND '2025-03-31';


-- =====================================
-- 24. IS NULL / IS NOT NULL
-- =====================================
-- Mostrar empleados sin jefe y con jefe
SELECT nombre, cargo, id_jefe
FROM empleado
WHERE id_jefe IS NULL;  -- Empleados sin jefe (ej. Dueño)

SELECT nombre, cargo, id_jefe
FROM empleado
WHERE id_jefe IS NOT NULL;  -- Empleados con jefe

-- =====================================
-- 25. DISTINCT
-- =====================================
-- Mostrar todos los cargos únicos en la tabla empleado
SELECT DISTINCT cargo
FROM empleado;


-- =====================================
-- 26. CASE WHEN
-- =====================================
-- Crear columna descriptiva según el sueldo del empleado
SELECT
    nombre,
    cargo,
    sueldo,
    CASE
        WHEN sueldo < 300 THEN 'Sueldo Bajo'
        WHEN sueldo BETWEEN 300 AND 599 THEN 'Sueldo Medio'
        ELSE 'Sueldo Alto'
    END AS descripcion_sueldo
FROM empleado;


-- =====================================
-- 27. UNION
-- =====================================
-- Unir clientes frecuentes con productos frecuentes (simulación de datos compatibles)
SELECT id_cliente AS id, nombre AS descripcion
FROM cliente
UNION
SELECT id_producto AS id, nombre AS descripcion
FROM producto;


-- =====================================
-- 28. EXISTS
-- =====================================
-- Mostrar clientes que tienen al menos una factura registrada
SELECT *
FROM cliente c
WHERE EXISTS (
    SELECT 1
    FROM facturas f
    WHERE f.cliente_id = c.id_cliente
);


