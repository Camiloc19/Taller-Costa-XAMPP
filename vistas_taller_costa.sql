-- =======================================================
--  VISTAS (VIEWS) - BASE DE DATOS: taller el costa
--  Basadas en el diagrama Entidad-Relación del proyecto
-- =======================================================

-- ¿QUÉ ES UNA VISTA?
-- Una vista es como una "consulta guardada con nombre".
-- En vez de escribir un SELECT largo cada vez,
-- lo guardas una vez y lo usas como si fuera una tabla.
-- Las vistas NO guardan datos, solo muestran datos ya existentes.

-- =======================================================
-- VISTA 1: Usuarios con su Rol asignado
-- =======================================================
-- ¿Para qué sirve?
-- Muestra todos los usuarios junto con el nombre de su rol
-- y la descripción de lo que puede hacer en el sistema.
-- Sin esta vista tendrías que hacer un JOIN manualmente cada vez.
-- =======================================================

CREATE OR REPLACE VIEW vista_usuarios_con_rol AS
SELECT
    u.idUsuario       AS id_usuario,
    u.nombre          AS nombre_usuario,
    u.apellido        AS apellido_usuario,
    u.correo          AS correo,
    u.documento       AS documento,
    r.idRol           AS id_rol,
    r.Nombre          AS nombre_rol,
    r.descripcion     AS descripcion_rol
FROM usuarios u
INNER JOIN roles r ON u.id_Rol_fk = r.idRol;

-- ¿Cómo se usa?
-- SELECT * FROM vista_usuarios_con_rol;
-- SELECT * FROM vista_usuarios_con_rol WHERE nombre_rol = 'Mecanico';


-- =======================================================
-- VISTA 2: Órdenes de Servicio con Vehículo y Mecánico
-- =======================================================
-- ¿Para qué sirve?
-- Muestra cada orden de servicio junto con:
-- - La placa, marca y color del vehículo
-- - El mecánico asignado (nombre y apellido)
-- - El estado actual de la orden
-- Es la vista más útil para el taller en el día a día.
-- =======================================================

CREATE OR REPLACE VIEW vista_ordenes_servicio AS
SELECT
    os.Id_orden           AS id_orden,
    os.numero_orden       AS numero_orden,
    os.estado             AS estado,
    os.fecha_apertura     AS fecha_apertura,
    os.fecha_cierrre      AS fecha_cierre,
    os.hora_apertura      AS hora_apertura,
    v.placa               AS placa_vehiculo,
    v.marca               AS marca_vehiculo,
    v.color               AS color_vehiculo,
    u.nombre              AS nombre_mecanico,
    u.apellido            AS apellido_mecanico
FROM orden_servicio os
LEFT JOIN vehiculos v  ON os.id_vehiculo_fk = v.IDvehiculos
LEFT JOIN usuarios u   ON os.id_usuario_fk  = u.idUsuario;

-- ¿Cómo se usa?
-- Ver todas las órdenes abiertas:
-- SELECT * FROM vista_ordenes_servicio WHERE estado = 'Abierta';
-- Ver órdenes de un mecánico específico:
-- SELECT * FROM vista_ordenes_servicio WHERE nombre_mecanico = 'Juan';


-- =======================================================
-- VISTA 3: Facturas con el Usuario que las generó
-- =======================================================
-- ¿Para qué sirve?
-- Muestra cada factura junto con quién la emitió,
-- la fecha, el total y el método de pago.
-- Útil para reportes de ventas y contabilidad.
-- =======================================================

CREATE OR REPLACE VIEW vista_facturas AS
SELECT
    f.id_factura          AS id_factura,
    f.numero_de_factura   AS numero_factura,
    f.fecha               AS fecha_emision,
    f.total               AS total,
    f.metodo_pago         AS metodo_pago,
    u.nombre              AS nombre_usuario,
    u.apellido            AS apellido_usuario,
    r.Nombre              AS rol_usuario
FROM factura f
INNER JOIN usuarios u ON f.id_usuario = u.idUsuario
INNER JOIN roles    r ON u.id_Rol_fk  = r.idRol
WHERE r.Nombre IN ('Super administrador', 'Administrador');

-- ¿Cómo se usa?
-- SELECT * FROM vista_facturas;
-- SELECT * FROM vista_facturas WHERE metodo_pago = 'Efectivo';
-- SELECT SUM(total) AS total_ventas FROM vista_facturas WHERE fecha_emision = CURDATE();


-- =======================================================
-- VISTA 4: Movimientos de Inventario (Entradas y Salidas)
-- =======================================================
-- ¿Para qué sirve?
-- Muestra cada movimiento de inventario con:
-- - El tipo (entrada o salida)
-- - El producto involucrado
-- - El usuario que lo registró
-- - La factura relacionada
-- Útil para auditar el stock del almacén.
-- =======================================================

CREATE OR REPLACE VIEW vista_movimientos_inventario AS
SELECT
    dm.id_movimiento          AS id_movimiento,
    tm.nombre                 AS tipo_movimiento,
    tm.descripcion            AS descripcion_tipo,
    dm.total_de_movimiento    AS cantidad,
    p.nombre_producto         AS producto,
    p.precio_compra           AS precio_compra,
    p.precio_venta            AS precio_venta,
    u.nombre                  AS usuario_responsable,
    f.numero_de_factura       AS factura_asociada,
    f.fecha                   AS fecha_movimiento
FROM detalles_movimientos dm
INNER JOIN tipo_movimientos tm ON dm.id_movimiento    = tm.id_tipomov
INNER JOIN productos        p  ON dm.id_producto      = p.id_producto
INNER JOIN usuarios         u  ON dm.id_usuario       = u.idUsuario
LEFT JOIN  factura          f  ON dm.id_factura       = f.id_factura;

-- ¿Cómo se usa?
-- Ver todas las entradas de productos:
-- SELECT * FROM vista_movimientos_inventario WHERE tipo_movimiento = 'Entrada';
-- Ver todos los movimientos de un producto:
-- SELECT * FROM vista_movimientos_inventario WHERE producto = 'Aceite 20W50';


-- =======================================================
-- VISTA 5: Productos con Stock Bajo (Alerta de Inventario)
-- =======================================================
-- ¿Para qué sirve?
-- Muestra solo los productos cuyo stock actual
-- es menor o igual al stock mínimo definido.
-- Es la vista de ALERTA para saber qué hay que reabastecer.
-- =======================================================

CREATE OR REPLACE VIEW vista_productos_stock_bajo AS
SELECT
    p.id_producto       AS id_producto,
    p.nombre_producto   AS producto,
    p.descripcion       AS descripcion,
    p.stock             AS stock_actual,
    p.stock_minimo      AS stock_minimo,
    (p.stock_minimo - p.stock) AS unidades_faltantes,
    p.precio_compra     AS precio_compra,
    p.precio_venta      AS precio_venta
FROM productos p
WHERE p.stock <= p.stock_minimo;

-- ¿Cómo se usa?
-- SELECT * FROM vista_productos_stock_bajo;
-- Te devuelve directamente los productos que necesitan reabastecimiento.


-- =======================================================
-- VISTA 6: Resumen General de Órdenes de Servicio
-- =======================================================
-- ¿Para qué sirve?
-- Da un resumen completo de cada orden: vehículo, mecánico,
-- factura asociada y total cobrado.
-- Es la vista de REPORTE GENERAL para el administrador.
-- =======================================================

CREATE OR REPLACE VIEW vista_reporte_ordenes AS
SELECT
    os.numero_orden       AS numero_orden,
    os.estado             AS estado,
    os.fecha_apertura     AS fecha_inicio,
    os.fecha_cierrre      AS fecha_fin,
    v.placa               AS vehiculo_placa,
    v.marca               AS vehiculo_marca,
    CONCAT(u.nombre, ' ', u.apellido) AS mecanico_asignado,
    f.numero_de_factura   AS numero_factura,
    f.total               AS total_cobrado,
    f.metodo_pago         AS forma_pago
FROM orden_servicio os
LEFT JOIN vehiculos v  ON os.id_vehiculo_fk = v.IDvehiculos
LEFT JOIN usuarios  u  ON os.id_usuario_fk  = u.idUsuario
LEFT JOIN factura   f  ON f.id_orden_fk     = os.Id_orden;

-- ¿Cómo se usa?
-- Ver el reporte de órdenes finalizadas:
-- SELECT * FROM vista_reporte_ordenes WHERE estado = 'Finalizada';
-- Ver ingresos del mes:
-- SELECT SUM(total_cobrado) FROM vista_reporte_ordenes WHERE MONTH(fecha_inicio) = MONTH(CURDATE());


-- =======================================================
-- VISTA 7: Proveedores con sus Productos
-- =======================================================
-- ¿Para qué sirve?
-- Muestra qué productos suministra cada proveedor.
-- Útil al momento de hacer pedidos de reabastecimiento.
-- =======================================================

CREATE OR REPLACE VIEW vista_proveedores_productos AS
SELECT
    pv.id_proveedor    AS id_proveedor,
    pv.nombre          AS proveedor,
    pv.nit             AS nit,
    pv.telefono        AS telefono,
    pv.direccion       AS direccion,
    p.nombre_producto  AS producto,
    p.stock            AS stock_actual,
    p.precio_compra    AS precio_compra
FROM proveedores pv
INNER JOIN productos p ON p.id_proveedor_fk = pv.id_proveedor;

-- ¿Cómo se usa?
-- SELECT * FROM vista_proveedores_productos;
-- Ver productos de un proveedor específico:
-- SELECT * FROM vista_proveedores_productos WHERE proveedor = 'Lubricantes S.A.';
