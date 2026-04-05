-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 06-04-2026 a las 00:48:39
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

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
  `fecha_final` date DEFAULT NULL,
  `observaciones` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `atencion_vehiculo`
--

INSERT INTO `atencion_vehiculo` (`idAtencion`, `id_Vehiculo_fk`, `id_Usuario_fk`, `id_Rol_fk`, `fecha_inicio`, `fecha_final`, `observaciones`) VALUES
(1, 1, 5, 4, '2026-03-01', '2026-03-01', 'Cambio de aceite sin novedades'),
(2, 2, 5, 4, '2026-03-05', '2026-03-06', 'Revisión completa de frenos'),
(3, 3, 6, 4, '2026-03-10', NULL, 'Pendiente revisión eléctrica');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria_producto`
--

CREATE TABLE `categoria_producto` (
  `idCategoria` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categoria_producto`
--

INSERT INTO `categoria_producto` (`idCategoria`, `Nombre`, `descripcion`) VALUES
(1, 'Aceites', 'Aceites y lubricantes para motor'),
(2, 'Filtros', 'Filtros de aceite, aire y combustible'),
(3, 'Frenos', 'Pastillas, discos y líquido de frenos'),
(4, 'Eléctricos', 'Baterías, bujías y componentes eléctricos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_movimiento`
--

CREATE TABLE `detalle_movimiento` (
  `idMovimiento` int(11) NOT NULL,
  `id_TipoMovimiento_fk` int(11) NOT NULL,
  `id_Factura_fk` int(11) NOT NULL,
  `id_ProductoProveedor_fk` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_movimiento`
--

INSERT INTO `detalle_movimiento` (`idMovimiento`, `id_TipoMovimiento_fk`, `id_Factura_fk`, `id_ProductoProveedor_fk`, `cantidad`) VALUES
(1, 2, 1, 1, 1),
(2, 2, 1, 3, 1),
(3, 2, 2, 5, 1),
(4, 2, 2, 6, 2),
(5, 1, 3, 8, 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_orden`
--

CREATE TABLE `detalle_orden` (
  `idDetalleServicio` int(11) NOT NULL,
  `id_Orden_fk` int(11) NOT NULL,
  `id_TipoServicio_fk` int(11) NOT NULL,
  `id_Producto_fk` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_orden`
--

INSERT INTO `detalle_orden` (`idDetalleServicio`, `id_Orden_fk`, `id_TipoServicio_fk`, `id_Producto_fk`, `cantidad`, `precio_unitario`) VALUES
(1, 1, 1, 1, 1, 45000.00),
(2, 1, 1, 3, 1, 22000.00),
(3, 2, 3, 5, 1, 75000.00),
(4, 2, 3, 6, 2, 28000.00),
(5, 5, 4, 8, 4, 18000.00),
(6, 5, 2, 1, 2, 45000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_orden`
--

CREATE TABLE `estado_orden` (
  `idEstado` int(11) NOT NULL,
  `Nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estado_orden`
--

INSERT INTO `estado_orden` (`idEstado`, `Nombre`) VALUES
(1, 'Abierta'),
(2, 'En proceso'),
(3, 'Completada'),
(4, 'Cancelada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `idFactura` int(11) NOT NULL,
  `id_Orden_fk` int(11) NOT NULL,
  `id_MetodoPago_fk` int(11) NOT NULL,
  `numero_factura` varchar(20) NOT NULL,
  `fecha` date NOT NULL,
  `total` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `factura`
--

INSERT INTO `factura` (`idFactura`, `id_Orden_fk`, `id_MetodoPago_fk`, `numero_factura`, `fecha`, `total`) VALUES
(1, 1, 1, 'FAC-001', '2026-03-01', 95000.00),
(2, 2, 2, 'FAC-002', '2026-03-06', 185000.00),
(3, 5, 3, 'FAC-003', '2026-04-03', 316000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marca_vehiculo`
--

CREATE TABLE `marca_vehiculo` (
  `idMarca` int(11) NOT NULL,
  `Nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `marca_vehiculo`
--

INSERT INTO `marca_vehiculo` (`idMarca`, `Nombre`) VALUES
(1, 'Chevrolet'),
(2, 'Renault'),
(3, 'Mazda'),
(4, 'Toyota'),
(5, 'Kia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `metodo_pago`
--

CREATE TABLE `metodo_pago` (
  `idMetodoPago` int(11) NOT NULL,
  `Nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `metodo_pago`
--

INSERT INTO `metodo_pago` (`idMetodoPago`, `Nombre`) VALUES
(1, 'Efectivo'),
(2, 'Tarjeta de crédito'),
(3, 'Tarjeta de débito'),
(4, 'Transferencia bancaria');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orden_servicio`
--

CREATE TABLE `orden_servicio` (
  `Id_orden` int(11) NOT NULL,
  `id_Vehiculo_fk` int(11) NOT NULL,
  `id_Usuario_fk` int(11) NOT NULL,
  `id_Estado_fk` int(11) NOT NULL,
  `numero_orden` varchar(50) NOT NULL,
  `fecha_apertura` date NOT NULL,
  `fecha_cierre` date DEFAULT NULL,
  `total` decimal(12,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `orden_servicio`
--

INSERT INTO `orden_servicio` (`Id_orden`, `id_Vehiculo_fk`, `id_Usuario_fk`, `id_Estado_fk`, `numero_orden`, `fecha_apertura`, `fecha_cierre`, `total`) VALUES
(1, 1, 5, 3, 'ORD-001', '2026-03-01', '2026-03-01', 95000.00),
(2, 2, 5, 3, 'ORD-002', '2026-03-05', '2026-03-06', 185000.00),
(3, 3, 6, 2, 'ORD-003', '2026-03-10', NULL, NULL),
(4, 4, 5, 1, 'ORD-004', '2026-04-01', NULL, NULL),
(5, 5, 6, 3, 'ORD-005', '2026-04-02', '2026-04-03', 316000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `idProducto` int(11) NOT NULL,
  `id_Categoria_fk` int(11) NOT NULL,
  `nombre_producto` varchar(150) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `stock_minimo` int(11) NOT NULL DEFAULT 0,
  `precio_compra` decimal(10,2) NOT NULL,
  `precio_venta` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`idProducto`, `id_Categoria_fk`, `nombre_producto`, `descripcion`, `stock`, `stock_minimo`, `precio_compra`, `precio_venta`) VALUES
(1, 1, 'Aceite Mobil 10W-40', 'Aceite sintético 1 litro', 25, 10, 28000.00, 45000.00),
(2, 1, 'Aceite Castrol 5W-30', 'Aceite sintético 1 litro', 18, 8, 32000.00, 52000.00),
(3, 2, 'Filtro de aceite universal', 'Filtro compatible múltiples marcas', 30, 15, 12000.00, 22000.00),
(4, 2, 'Filtro de aire Chevrolet', 'Filtro de aire para Spark/Aveo', 12, 5, 18000.00, 35000.00),
(5, 3, 'Pastillas de freno delanteras', 'Juego pastillas genéricas', 3, 5, 45000.00, 75000.00),
(6, 3, 'Líquido de frenos DOT4', 'Envase 500ml', 15, 10, 15000.00, 28000.00),
(7, 4, 'Batería 12V 60Ah', 'Batería estándar para auto', 5, 3, 180000.00, 280000.00),
(8, 4, 'Bujía NGK estándar', 'Bujía de encendido', 40, 20, 8000.00, 18000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto_proveedor`
--

CREATE TABLE `producto_proveedor` (
  `idProductoProveedor` int(11) NOT NULL,
  `id_Producto_fk` int(11) NOT NULL,
  `id_Proveedor_fk` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto_proveedor`
--

INSERT INTO `producto_proveedor` (`idProductoProveedor`, `id_Producto_fk`, `id_Proveedor_fk`) VALUES
(1, 1, 2),
(2, 2, 2),
(3, 3, 1),
(4, 4, 1),
(5, 5, 3),
(6, 6, 3),
(7, 7, 1),
(8, 8, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `idProveedor` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `nit` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`idProveedor`, `Nombre`, `nit`) VALUES
(1, 'AutoPartes Colombia', '900123456-1'),
(2, 'Lubricantes del Valle', '800987654-3'),
(3, 'Frenos y Más', '901234567-8');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `idRol` int(11) NOT NULL,
  `Nombre` varchar(25) NOT NULL,
  `descripcion` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`idRol`, `Nombre`, `descripcion`) VALUES
(1, 'Super administrador', 'Acceso total e ilimitado al sistema; puede crear, modificar y eliminar usuarios, roles, productos y servicios, configurar el sistema, ver y generar todos los reportes, supervisar órdenes de servicio y realizar cualquier cambio sin restricciones'),
(2, 'Administrador', 'Acceso casi total; puede crear, editar y eliminar usuarios, productos y órdenes de servicio y generar reportes'),
(3, 'Cliente', 'No tiene acceso alguno al programa'),
(4, 'Mecanico', 'Puede ver y gestionar órdenes de servicio asignadas, actualizar el estado del mantenimiento, registrar reparaciones realizadas, agregar observaciones técnicas, registrar repuestos utilizados y finalizar servicios');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_movimiento`
--

CREATE TABLE `tipo_movimiento` (
  `idTipoMovimiento` int(11) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_movimiento`
--

INSERT INTO `tipo_movimiento` (`idTipoMovimiento`, `tipo`, `descripcion`) VALUES
(1, 'Entrada', 'Ingreso de productos al inventario'),
(2, 'Salida', 'Uso de productos en servicios');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_servicio`
--

CREATE TABLE `tipo_servicio` (
  `idTipoServicio` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_servicio`
--

INSERT INTO `tipo_servicio` (`idTipoServicio`, `Nombre`) VALUES
(1, 'Cambio de aceite'),
(2, 'Alineación y balanceo'),
(3, 'Frenos'),
(4, 'Revisión general'),
(5, 'Electricidad');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `idUsuario` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `apellido` varchar(100) DEFAULT NULL,
  `contraseña` varchar(50) DEFAULT NULL,
  `correo` varchar(150) DEFAULT NULL,
  `id_Rol_fk` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`idUsuario`, `nombre`, `apellido`, `contraseña`, `correo`, `id_Rol_fk`) VALUES
(1, 'Carlos', 'Costa', 'admin123', 'carlos@tallerelcosta.com', 1),
(2, 'María', 'López', 'admin456', 'maria@tallerelcosta.com', 2),
(3, 'Luis', 'Torres', 'cli789', 'luis@correo.com', 3),
(4, 'Andrea', 'Díaz', 'cli101', 'andrea@correo.com', 3),
(5, 'Pedro', 'Ramírez', 'mec112', 'pedro@tallerelcosta.com', 4),
(6, 'Juan', 'García', 'mec131', 'juan@tallerelcosta.com', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculos`
--

CREATE TABLE `vehiculos` (
  `IDvehiculos` int(11) NOT NULL,
  `id_Usuario_fk` int(11) NOT NULL,
  `id_Marca_fk` int(11) NOT NULL,
  `placa` varchar(15) NOT NULL,
  `color` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `vehiculos`
--

INSERT INTO `vehiculos` (`IDvehiculos`, `id_Usuario_fk`, `id_Marca_fk`, `placa`, `color`) VALUES
(1, 3, 1, 'as105', 'rojo'),
(2, 3, 2, 'BCD456', 'gris'),
(3, 4, 3, 'EFG789', 'negro'),
(4, 4, 4, 'HIJ012', 'blanco'),
(5, 3, 5, 'KLM345', 'azul');

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
-- Indices de la tabla `categoria_producto`
--
ALTER TABLE `categoria_producto`
  ADD PRIMARY KEY (`idCategoria`);

--
-- Indices de la tabla `detalle_movimiento`
--
ALTER TABLE `detalle_movimiento`
  ADD PRIMARY KEY (`idMovimiento`),
  ADD KEY `fk_detmov_tipo` (`id_TipoMovimiento_fk`),
  ADD KEY `fk_detmov_factura` (`id_Factura_fk`),
  ADD KEY `fk_detmov_prodprov` (`id_ProductoProveedor_fk`);

--
-- Indices de la tabla `detalle_orden`
--
ALTER TABLE `detalle_orden`
  ADD PRIMARY KEY (`idDetalleServicio`),
  ADD KEY `fk_detalle_orden` (`id_Orden_fk`),
  ADD KEY `fk_detalle_tiposervicio` (`id_TipoServicio_fk`),
  ADD KEY `fk_detalle_producto` (`id_Producto_fk`);

--
-- Indices de la tabla `estado_orden`
--
ALTER TABLE `estado_orden`
  ADD PRIMARY KEY (`idEstado`);

--
-- Indices de la tabla `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`idFactura`),
  ADD KEY `fk_factura_orden` (`id_Orden_fk`),
  ADD KEY `fk_factura_metodo` (`id_MetodoPago_fk`);

--
-- Indices de la tabla `marca_vehiculo`
--
ALTER TABLE `marca_vehiculo`
  ADD PRIMARY KEY (`idMarca`);

--
-- Indices de la tabla `metodo_pago`
--
ALTER TABLE `metodo_pago`
  ADD PRIMARY KEY (`idMetodoPago`);

--
-- Indices de la tabla `orden_servicio`
--
ALTER TABLE `orden_servicio`
  ADD PRIMARY KEY (`Id_orden`),
  ADD KEY `fk_orden_vehiculo` (`id_Vehiculo_fk`),
  ADD KEY `fk_orden_usuario` (`id_Usuario_fk`),
  ADD KEY `fk_orden_estado` (`id_Estado_fk`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`idProducto`),
  ADD KEY `fk_producto_categoria` (`id_Categoria_fk`);

--
-- Indices de la tabla `producto_proveedor`
--
ALTER TABLE `producto_proveedor`
  ADD PRIMARY KEY (`idProductoProveedor`),
  ADD KEY `fk_pp_producto` (`id_Producto_fk`),
  ADD KEY `fk_pp_proveedor` (`id_Proveedor_fk`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`idProveedor`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`idRol`);

--
-- Indices de la tabla `tipo_movimiento`
--
ALTER TABLE `tipo_movimiento`
  ADD PRIMARY KEY (`idTipoMovimiento`);

--
-- Indices de la tabla `tipo_servicio`
--
ALTER TABLE `tipo_servicio`
  ADD PRIMARY KEY (`idTipoServicio`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`idUsuario`),
  ADD KEY `fk_usuario_rol` (`id_Rol_fk`);

--
-- Indices de la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  ADD PRIMARY KEY (`IDvehiculos`),
  ADD KEY `fk_vehiculo_usuario` (`id_Usuario_fk`),
  ADD KEY `fk_vehiculo_marca` (`id_Marca_fk`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `atencion_vehiculo`
--
ALTER TABLE `atencion_vehiculo`
  MODIFY `idAtencion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `categoria_producto`
--
ALTER TABLE `categoria_producto`
  MODIFY `idCategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `detalle_movimiento`
--
ALTER TABLE `detalle_movimiento`
  MODIFY `idMovimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `detalle_orden`
--
ALTER TABLE `detalle_orden`
  MODIFY `idDetalleServicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `estado_orden`
--
ALTER TABLE `estado_orden`
  MODIFY `idEstado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `factura`
--
ALTER TABLE `factura`
  MODIFY `idFactura` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `marca_vehiculo`
--
ALTER TABLE `marca_vehiculo`
  MODIFY `idMarca` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `metodo_pago`
--
ALTER TABLE `metodo_pago`
  MODIFY `idMetodoPago` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `orden_servicio`
--
ALTER TABLE `orden_servicio`
  MODIFY `Id_orden` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `idProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `producto_proveedor`
--
ALTER TABLE `producto_proveedor`
  MODIFY `idProductoProveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `idProveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `idRol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tipo_movimiento`
--
ALTER TABLE `tipo_movimiento`
  MODIFY `idTipoMovimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tipo_servicio`
--
ALTER TABLE `tipo_servicio`
  MODIFY `idTipoServicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  MODIFY `IDvehiculos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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

--
-- Filtros para la tabla `detalle_movimiento`
--
ALTER TABLE `detalle_movimiento`
  ADD CONSTRAINT `fk_detmov_factura` FOREIGN KEY (`id_Factura_fk`) REFERENCES `factura` (`idFactura`),
  ADD CONSTRAINT `fk_detmov_prodprov` FOREIGN KEY (`id_ProductoProveedor_fk`) REFERENCES `producto_proveedor` (`idProductoProveedor`),
  ADD CONSTRAINT `fk_detmov_tipo` FOREIGN KEY (`id_TipoMovimiento_fk`) REFERENCES `tipo_movimiento` (`idTipoMovimiento`);

--
-- Filtros para la tabla `detalle_orden`
--
ALTER TABLE `detalle_orden`
  ADD CONSTRAINT `fk_detalle_orden` FOREIGN KEY (`id_Orden_fk`) REFERENCES `orden_servicio` (`Id_orden`),
  ADD CONSTRAINT `fk_detalle_producto` FOREIGN KEY (`id_Producto_fk`) REFERENCES `producto` (`idProducto`),
  ADD CONSTRAINT `fk_detalle_tiposervicio` FOREIGN KEY (`id_TipoServicio_fk`) REFERENCES `tipo_servicio` (`idTipoServicio`);

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `fk_factura_metodo` FOREIGN KEY (`id_MetodoPago_fk`) REFERENCES `metodo_pago` (`idMetodoPago`),
  ADD CONSTRAINT `fk_factura_orden` FOREIGN KEY (`id_Orden_fk`) REFERENCES `orden_servicio` (`Id_orden`);

--
-- Filtros para la tabla `orden_servicio`
--
ALTER TABLE `orden_servicio`
  ADD CONSTRAINT `fk_orden_estado` FOREIGN KEY (`id_Estado_fk`) REFERENCES `estado_orden` (`idEstado`),
  ADD CONSTRAINT `fk_orden_usuario` FOREIGN KEY (`id_Usuario_fk`) REFERENCES `usuarios` (`idUsuario`),
  ADD CONSTRAINT `fk_orden_vehiculo` FOREIGN KEY (`id_Vehiculo_fk`) REFERENCES `vehiculos` (`IDvehiculos`);

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `fk_producto_categoria` FOREIGN KEY (`id_Categoria_fk`) REFERENCES `categoria_producto` (`idCategoria`);

--
-- Filtros para la tabla `producto_proveedor`
--
ALTER TABLE `producto_proveedor`
  ADD CONSTRAINT `fk_pp_producto` FOREIGN KEY (`id_Producto_fk`) REFERENCES `producto` (`idProducto`),
  ADD CONSTRAINT `fk_pp_proveedor` FOREIGN KEY (`id_Proveedor_fk`) REFERENCES `proveedores` (`idProveedor`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `fk_usuario_rol` FOREIGN KEY (`id_Rol_fk`) REFERENCES `roles` (`idRol`);

--
-- Filtros para la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  ADD CONSTRAINT `fk_vehiculo_marca` FOREIGN KEY (`id_Marca_fk`) REFERENCES `marca_vehiculo` (`idMarca`),
  ADD CONSTRAINT `fk_vehiculo_usuario` FOREIGN KEY (`id_Usuario_fk`) REFERENCES `usuarios` (`idUsuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
