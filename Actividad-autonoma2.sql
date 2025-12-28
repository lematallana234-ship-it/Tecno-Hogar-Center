-- ================================
-- BASE DE DATOS
-- ================================
CREATE DATABASE empresa;
USE empresa;

-- ================================
-- TABLA 1: Diseño inicial
-- ================================
CREATE TABLE empleados_inicial (
    cedula INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    departamento VARCHAR(50) NOT NULL
);

INSERT INTO empleados_inicial (cedula, nombre, departamento) VALUES
(1111111, 'Juan', 'Ventas'),
(2222222, 'Pedro', 'Almacenes'),
(3333333, 'María', 'Contabilidad'),
(4444444, 'Marco', 'Contabilidad'),
(5555555, 'Susana', 'Ventas'),
(6666666, 'Marcelo', 'Ventas'),
(7777777, 'Ana', 'Dirección General');

SELECT * From empleados_inicial;
-- ================================
-- TABLA 2 EMPLEADOS (CON JEFE)
-- ================================
CREATE TABLE empleados (
    cedula INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    departamento VARCHAR(50) NOT NULL,
    cedula_jefe INT,
    CONSTRAINT empleados_idfk_1
        FOREIGN KEY (cedula_jefe) REFERENCES empleados(cedula)
) ENGINE=InnoDB;

-- ================================
-- INSERCIÓN DE EMPLEADOS SIN JEFE
-- ================================
INSERT INTO empleados VALUES
(7777777, 'Ana', 'Dirección General', NULL),
(2222222, 'Pedro', 'Almacenes', NULL);

-- ================================
-- INSERCIÓN DE JEFES INTERMEDIOS
-- ================================
INSERT INTO empleados VALUES
(4444444, 'Marco', 'Contabilidad', 7777777),
(5555555, 'Susana', 'Ventas', 7777777);

-- ================================
-- INSERCIÓN DE EMPLEADOS CON JEFE
-- ================================
INSERT INTO empleados VALUES
(1111111, 'Juan', 'Ventas', 4444444),
(3333333, 'María', 'Contabilidad', 4444444),
(6666666, 'Marcelo', 'Ventas', 5555555);

-- ================================
-- CONSULTA: EMPLEADOS CON SU JEFE
-- ================================
SELECT 
    e.cedula,
    e.nombre AS empleado,
    e.departamento,
    j.nombre AS jefe
FROM empleados e
LEFT JOIN empleados j
    ON e.cedula_jefe = j.cedula
ORDER BY e.cedula;