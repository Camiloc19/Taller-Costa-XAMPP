-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-04-2026 a las 14:38:54
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `taller el costa`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `atencion_vehiculo`
--

CREATE TABLE `atencion_vehiculo` (
  `idAtencion` int(11) NOT NULL,
  `id_Vehiculo_fk` int(11) NOT NULL,
  `id_Usuario_fk` int(11) NOT NULL,
  `id_Rol_fk` int(11) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_final` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `atencion_vehiculo`
--

INSERT INTO `atencion_vehiculo` (`idAtencion`, `id_Vehiculo_fk`, `id_Usuario_fk`, `id_Rol_fk`, `fecha_inicio`, `fecha_final`) VALUES
(1, 1, 2, 4, '2026-03-23', '2026-03-25'),
(2, 2, 3, 4, '2026-02-18', '2026-03-24'),
(3, 3, 2, 4, '2026-01-04', '2026-01-06'),
(4, 4, 3, 4, '2026-01-15', '2026-01-17'),
(5, 5, 4, 4, '2026-01-30', '2026-02-05');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `atencion_vehiculo`
--
ALTER TABLE `atencion_vehiculo`
  ADD PRIMARY KEY (`idAtencion`),
  ADD KEY `fk_atencion_vehiculo` (`id_Vehiculo_fk`),
  ADD KEY `fk_atencion_usuario` (`id_Usuario_fk`),
  ADD KEY `fk_atencion_rol` (`id_Rol_fk`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `atencion_vehiculo`
--
ALTER TABLE `atencion_vehiculo`
  MODIFY `idAtencion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `atencion_vehiculo`
--
ALTER TABLE `atencion_vehiculo`
  ADD CONSTRAINT `fk_atencion_rol` FOREIGN KEY (`id_Rol_fk`) REFERENCES `roles` (`idRol`),
  ADD CONSTRAINT `fk_atencion_usuario` FOREIGN KEY (`id_Usuario_fk`) REFERENCES `usuarios` (`idUsuario`),
  ADD CONSTRAINT `fk_atencion_vehiculo` FOREIGN KEY (`id_Vehiculo_fk`) REFERENCES `vehiculos` (`IDvehiculos`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
