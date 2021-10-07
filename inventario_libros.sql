-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-09-2021 a las 18:48:27
-- Versión del servidor: 10.4.21-MariaDB
-- Versión de PHP: 8.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `inventario_libros`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `autores`
--

CREATE TABLE `autores` (
  `codigoAutor` varchar(10) NOT NULL,
  `nombreAutor` varchar(150) NOT NULL,
  `nacionalidad` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `autores`
--

INSERT INTO `autores` (`codigoAutor`, `nombreAutor`, `nacionalidad`) VALUES
('CBLACK', 'JMRZ', 'España'),
('COTA', 'Jonh3', 'El Salvador');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `editoriales`
--

CREATE TABLE `editoriales` (
  `codigoEditorial` varchar(10) NOT NULL,
  `nombreEditorial` varchar(150) NOT NULL,
  `contacto` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `editoriales`
--

INSERT INTO `editoriales` (`codigoEditorial`, `nombreEditorial`, `contacto`, `telefono`) VALUES
('1', 'Centillana', 'Carlos', '12345678'),
('2', 'MIND', 'Julio', '70709090');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estados`
--

CREATE TABLE `estados` (
  `idEstado` int(11) NOT NULL,
  `estado` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `estados`
--

INSERT INTO `estados` (`idEstado`, `estado`) VALUES
(1, 'ingreso'),
(2, 'salida');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `generos`
--

CREATE TABLE `generos` (
  `idGenero` int(11) NOT NULL,
  `nombreGenero` varchar(50) NOT NULL,
  `descripcion` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `generos`
--

INSERT INTO `generos` (`idGenero`, `nombreGenero`, `descripcion`) VALUES
(1, 'Novela', 'Relatos dramaticos xD'),
(2, 'Fantasía', 'Cosas irreales');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `idInventario` int(11) NOT NULL,
  `codigoLibro` varchar(10) NOT NULL,
  `existencias` int(11) NOT NULL,
  `idEstado` int(11) NOT NULL,
  `fecha_movimiento` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`idInventario`, `codigoLibro`, `existencias`, `idEstado`, `fecha_movimiento`) VALUES
(1, '1', 30, 1, '2021-09-25 11:56:28'),
(2, '1', 8, 1, '2021-09-25 12:19:12'),
(32, '1', 6, 1, '2021-09-25 15:42:34'),
(33, '1', 76, 1, '2021-09-25 15:43:55'),
(34, '1', 252, 2, '2021-09-25 15:44:11'),
(35, '1', 5, 1, '2021-09-25 15:44:38');

--
-- Disparadores `inventario`
--
DELIMITER $$
CREATE TRIGGER `libros_after_insert` BEFORE INSERT ON `inventario` FOR EACH ROW BEGIN
declare new_stock int;
set new_stock= (select libros.existencias from libros where new.codigoLibro = libros.codigoLibro)- new.existencias;

if (new.idEstado = 1)THEN 
	UPDATE libros SET existencias = libros.existencias + new.existencias
    WHERE new.codigoLibro=codigoLibro;

ELSEIF (new.idEstado = 2 AND new_stock >= 0)THEN 
UPDATE libros SET existencias = libros.existencias - new.existencias
    WHERE new.codigoLibro=codigoLibro;
    
else 
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No tiene suficiente Stock';
    END IF;
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `libros`
--

CREATE TABLE `libros` (
  `codigoLibro` varchar(10) NOT NULL,
  `nombreLibro` varchar(100) NOT NULL,
  `existencias` int(11) NOT NULL,
  `precio` double(18,2) NOT NULL,
  `codigoAutor` varchar(10) DEFAULT NULL,
  `codigoEditorial` varchar(10) DEFAULT NULL,
  `idGenero` int(11) DEFAULT NULL,
  `descripcion` varchar(300) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `libros`
--

INSERT INTO `libros` (`codigoLibro`, `nombreLibro`, `existencias`, `precio`, `codigoAutor`, `codigoEditorial`, `idGenero`, `descripcion`) VALUES
('1', 'Las mil y una noche', 5, 5.00, 'CBLACK', '1', 2, 'Alguna'),
('2', 'Tarzan', 25, 25.00, 'COTA', '2', 2, 'asas'),
('3', 'Aladin', 45, 20.00, 'COTA', '1', 2, 'ASSA');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `autores`
--
ALTER TABLE `autores`
  ADD PRIMARY KEY (`codigoAutor`);

--
-- Indices de la tabla `editoriales`
--
ALTER TABLE `editoriales`
  ADD PRIMARY KEY (`codigoEditorial`);

--
-- Indices de la tabla `estados`
--
ALTER TABLE `estados`
  ADD PRIMARY KEY (`idEstado`);

--
-- Indices de la tabla `generos`
--
ALTER TABLE `generos`
  ADD PRIMARY KEY (`idGenero`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`idInventario`),
  ADD KEY `FK_codigoLibro` (`codigoLibro`),
  ADD KEY `FK_estado` (`idEstado`);

--
-- Indices de la tabla `libros`
--
ALTER TABLE `libros`
  ADD PRIMARY KEY (`codigoLibro`),
  ADD KEY `FK_codigoAutor` (`codigoAutor`),
  ADD KEY `FK_codigoEditorial` (`codigoEditorial`),
  ADD KEY `FK_idGenero` (`idGenero`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `estados`
--
ALTER TABLE `estados`
  MODIFY `idEstado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `generos`
--
ALTER TABLE `generos`
  MODIFY `idGenero` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `inventario`
--
ALTER TABLE `inventario`
  MODIFY `idInventario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `FK_codigoLibro` FOREIGN KEY (`codigoLibro`) REFERENCES `libros` (`codigoLibro`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_estado` FOREIGN KEY (`idEstado`) REFERENCES `estados` (`idEstado`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `libros`
--
ALTER TABLE `libros`
  ADD CONSTRAINT `FK_codigoAutor` FOREIGN KEY (`codigoAutor`) REFERENCES `autores` (`codigoAutor`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_codigoEditorial` FOREIGN KEY (`codigoEditorial`) REFERENCES `editoriales` (`codigoEditorial`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_idGenero` FOREIGN KEY (`idGenero`) REFERENCES `generos` (`idGenero`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
