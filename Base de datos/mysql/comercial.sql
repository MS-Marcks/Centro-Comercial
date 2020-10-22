-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 21-10-2020 a las 20:34:46
-- Versión del servidor: 5.7.24
-- Versión de PHP: 5.6.40

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `comercial`
--

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `sp_change_status_factura`$$
CREATE   PROCEDURE `sp_change_status_factura` (IN `id` INTEGER(11), IN `pestado` VARCHAR(32))  BEGIN
	UPDATE factura set estado=pestado WHERE id_factura=id;
END$$

DROP PROCEDURE IF EXISTS `sp_create_asigancion_tienda`$$
CREATE   PROCEDURE `sp_create_asigancion_tienda` (IN `pid_tipo` INTEGER(11), IN `puuid` VARCHAR(32))  BEGIN
	INSERT INTO asigancion_tienda (id_tienda,uuid) VALUES (pid_tipo,puuid);
END$$

DROP PROCEDURE IF EXISTS `sp_create_bitacora`$$
CREATE   PROCEDURE `sp_create_bitacora` (IN `puuid` VARCHAR(32), IN `pestado` VARCHAR(32), IN `pdescripcion` VARCHAR(32))  BEGIN
	INSERT INTO bitacora (uuid,hora,estado,descripcion) VALUES (puuid,NOW(),pestado,pdescripcion);
END$$

DROP PROCEDURE IF EXISTS `sp_create_cliente`$$
CREATE   PROCEDURE `sp_create_cliente` (IN `pprimernombre` VARCHAR(128), IN `psegundonombre` VARCHAR(128), IN `pprimerapellido` VARCHAR(128), IN `psegundoapellido` VARCHAR(128), IN `pdireccion` VARCHAR(256), IN `pnit` VARCHAR(16), IN `ptelefono` VARCHAR(16))  BEGIN
	INSERT INTO persona (primernombre,segundonombre,primerapellido,segundoapellido,direccion,nit,telefono) VALUES (pprimernombre,psegundonombre,pprimerapellido,psegundoapellido,pdireccion,pnit,ptelefono);
    SET @id_cliente = (SELECT id_persona FROM persona ORDER BY id_persona DESC LIMIT 1);
    INSERT INTO cliente (id_cliente,usuario,clave) VALUES (@id_cliente,pnit,pnit);
END$$

DROP PROCEDURE IF EXISTS `sp_create_compra`$$
CREATE   PROCEDURE `sp_create_compra` (IN `pid_proveedor` INT(11), IN `pid_articulo` INT(11), IN `pcantidad` INT(11), IN `pprecio` FLOAT(10,2))  BEGIN
	INSERT INTO compras (id_proveedor,id_articulo,cantidad,precio) VALUES (pid_proveedor,pid_articulo,pcantidad,pprecio);
	SET @pstock= (SELECT stock FROM inventario WHERE id_articulo = pid_articulo);
	SET @pstock = @pstock+pcantidad;
	UPDATE inventario SET stock=@pstock WHERE id_articulo = pid_articulo;
END$$

DROP PROCEDURE IF EXISTS `sp_create_descripcion`$$
CREATE   PROCEDURE `sp_create_descripcion` (IN `pid_articulo` INTEGER(11), IN `pdescripcion` VARCHAR(128))  BEGIN
	INSERT INTO descripcion (id_articulo,descripcion) VALUES (pid_articulo,pdescripcion);
END$$

DROP PROCEDURE IF EXISTS `sp_create_detalle`$$
CREATE   PROCEDURE `sp_create_detalle` (IN `pid_factura` INTEGER(11), IN `pid_articulo` INTEGER(11), IN `pprecio` FLOAT(10,2), `pcantidad` INTEGER(11))  BEGIN
	INSERT INTO detallefactura (id_factura,id_articulo,precio,cantidad) VALUES (pid_factura,pid_articulo,pprecio,pcantidad);
	SET @pstock= (SELECT stock FROM inventario WHERE id_articulo = pid_articulo);
	SET @pstock = @pstock-pcantidad;
	UPDATE inventario SET stock=@pstock WHERE id_articulo = pid_articulo;
END$$

DROP PROCEDURE IF EXISTS `sp_create_display`$$
CREATE   PROCEDURE `sp_create_display` (IN `pidentifier` VARCHAR(128), IN `pid_tipo` INTEGER(11))  BEGIN
	INSERT INTO display (identifier,id_tipo) VALUES (pidentifier,pid_tipo);
END$$

DROP PROCEDURE IF EXISTS `sp_create_factura`$$
CREATE   PROCEDURE `sp_create_factura` (IN `puuid` VARCHAR(32), IN `pid_cliente` INT(11), IN `pnit` VARCHAR(10), IN `pdireccion` VARCHAR(256))  BEGIN
	INSERT INTO factura (uuid,id_cliente,nit,direccion,fecha,estado) VALUES (puuid,pid_cliente,pnit,pdireccion,CURDATE(),'CREADA');
END$$

DROP PROCEDURE IF EXISTS `sp_create_horario`$$
CREATE   PROCEDURE `sp_create_horario` (IN `puuid` VARCHAR(32), IN `phora_entrada` VARCHAR(20), IN `phora_salida` VARCHAR(20))  BEGIN
	INSERT INTO horario (uuid,hora_entrada,hora_salida) VALUES (puuid,phora_entrada,phora_salida);
    
END$$

DROP PROCEDURE IF EXISTS `sp_create_ibeacoins`$$
CREATE   PROCEDURE `sp_create_ibeacoins` (IN `pidentifier` VARCHAR(128), IN `puuid` VARCHAR(128), IN `pmajor` INTEGER(11), IN `pminor` INTEGER(11))  BEGIN
	INSERT INTO ibeacoins (identifier,uuid,major,minor) VALUES (pidentifier,puuid,pmajor,pminor);
END$$

DROP PROCEDURE IF EXISTS `sp_create_inventario`$$
CREATE   PROCEDURE `sp_create_inventario` (IN `pid_tienda` INTEGER(11), IN `pid_tipo` INTEGER(11), IN `particulo` VARCHAR(128), IN `pdescripcion` VARCHAR(128), IN `pprecio` FLOAT(10,2), IN `pimagen` VARCHAR(128))  BEGIN
	INSERT INTO inventario (id_tienda,id_tipo,articulo,descripcion,precio,stock,imagen) VALUES (pid_tienda,pid_tipo,particulo,pdescripcion,pprecio,0,pimagen);
END$$

DROP PROCEDURE IF EXISTS `sp_create_persona`$$
CREATE   PROCEDURE `sp_create_persona` (IN `pprimernombre` VARCHAR(128), IN `psegundonombre` VARCHAR(128), IN `pprimerapellido` VARCHAR(128), IN `psegundoapellido` VARCHAR(128), IN `pdireccion` VARCHAR(256), IN `pnit` VARCHAR(16), IN `ptelefono` VARCHAR(16))  BEGIN
	INSERT INTO persona (primernombre,segundonombre,primerapellido,segundoapellido,direccion,nit,telefono) VALUES (pprimernombre,psegundonombre,pprimerapellido,psegundoapellido,pdireccion,pnit,ptelefono);
END$$

DROP PROCEDURE IF EXISTS `sp_create_proveedor`$$
CREATE   PROCEDURE `sp_create_proveedor` (IN `pproveedor` VARCHAR(128))  BEGIN
	INSERT INTO proveedor (razonsocial) VALUES (pproveedor);
END$$

DROP PROCEDURE IF EXISTS `sp_create_rol`$$
CREATE   PROCEDURE `sp_create_rol` (IN `prol` VARCHAR(128))  BEGIN
	INSERT INTO rol (rol) VALUES (prol);
END$$

DROP PROCEDURE IF EXISTS `sp_create_tienda`$$
CREATE   PROCEDURE `sp_create_tienda` (IN `ptienda` VARCHAR(128))  BEGIN
	INSERT INTO tienda (tienda) VALUES (ptienda);
END$$

DROP PROCEDURE IF EXISTS `sp_create_tipo`$$
CREATE   PROCEDURE `sp_create_tipo` (IN `ptipo` VARCHAR(128))  BEGIN
	INSERT INTO tipo (tipo) VALUES (ptipo);
END$$

DROP PROCEDURE IF EXISTS `sp_create_usuario`$$
CREATE   PROCEDURE `sp_create_usuario` (IN `puuid` VARCHAR(32), IN `pid_persona` INTEGER(11), IN `pid_rol` INTEGER(11), IN `pusuario` VARCHAR(128), IN `ppass` VARCHAR(128))  BEGIN
    INSERT INTO usuario (uuid,id_persona,id_rol,usuario,pass) VALUES (puuid,pid_persona,pid_rol,pusuario,ppass);
END$$

DROP PROCEDURE IF EXISTS `sp_delete_asigancion_tienda`$$
CREATE   PROCEDURE `sp_delete_asigancion_tienda` (IN `id` INT(11), IN `id1` VARCHAR(11))  BEGIN
	DELETE FROM asigancion_tienda WHERE id_tienda=id AND uuid=id1;
END$$

DROP PROCEDURE IF EXISTS `sp_delete_descripcion`$$
CREATE   PROCEDURE `sp_delete_descripcion` (IN `id` INTEGER(11))  BEGIN
	DELETE FROM descripcion WHERE id_descripcion=id;
END$$

DROP PROCEDURE IF EXISTS `sp_delete_detalle`$$
CREATE   PROCEDURE `sp_delete_detalle` (IN `pid_factura` INTEGER(11), IN `pid_articulo` INTEGER(11))  BEGIN
	SET @pcantidad= (SELECT cantidad FROM detallefactura WHERE id_factura=pid_factura AND id_articulo=pid_articulo);
	SET @pstock= (SELECT stock FROM inventario WHERE id_articulo = pid_articulo);
	SET @pstock = @pstock+@pcantidad;
	UPDATE inventario SET stock=@pstock WHERE id_articulo = pid_articulo;
	DELETE FROM detallefactura WHERE id_factura=pid_factura AND id_articulo=pid_articulo;
END$$

DROP PROCEDURE IF EXISTS `sp_delete_display`$$
CREATE   PROCEDURE `sp_delete_display` (IN `id` VARCHAR(128), IN `id1` INTEGER(11))  BEGIN
	DELETE FROM display WHERE identifier=id AND id_tipo=id1;
END$$

DROP PROCEDURE IF EXISTS `sp_delete_horario`$$
CREATE   PROCEDURE `sp_delete_horario` (IN `id` INTEGER(11))  BEGIN
	DELETE FROM horario WHERE id_horario=id;
END$$

DROP PROCEDURE IF EXISTS `sp_delete_ibeacoins`$$
CREATE   PROCEDURE `sp_delete_ibeacoins` (IN `id` VARCHAR(128))  BEGIN
	DELETE FROM ibeacoins WHERE identifier=id;
END$$

DROP PROCEDURE IF EXISTS `sp_delete_proveedor`$$
CREATE   PROCEDURE `sp_delete_proveedor` (IN `id` INTEGER(11))  BEGIN
	DELETE FROM proveedor WHERE id_proveedor=id;
END$$

DROP PROCEDURE IF EXISTS `sp_delete_rol`$$
CREATE   PROCEDURE `sp_delete_rol` (IN `id` INTEGER(11))  BEGIN
	DELETE FROM rol WHERE id_rol=id;
END$$

DROP PROCEDURE IF EXISTS `sp_delete_tienda`$$
CREATE   PROCEDURE `sp_delete_tienda` (IN `id` INTEGER(11))  BEGIN
	DELETE FROM tienda WHERE id_tienda=id;
END$$

DROP PROCEDURE IF EXISTS `sp_delete_tipo`$$
CREATE   PROCEDURE `sp_delete_tipo` (IN `id` INTEGER(11))  BEGIN
	DELETE FROM tipo WHERE id_tipo=id;
END$$

DROP PROCEDURE IF EXISTS `sp_horario_usuario`$$
CREATE   PROCEDURE `sp_horario_usuario` (IN `puuid` VARCHAR(32))  BEGIN
	SELECT p.*,h.*,u.usuario FROM horario AS h INNER JOIN usuario AS u ON h.uuid=u.uuid
	INNER JOIN persona AS p ON p.id_persona=u.id_persona WHERE u.uuid=puuid;
END$$

DROP PROCEDURE IF EXISTS `sp_seach_articulos`$$
CREATE   PROCEDURE `sp_seach_articulos` (IN `id` INTEGER(11))  BEGIN
    SELECT i.imagen,de.descripcion,t.id_tipo,t.tipo FROM cliente AS c JOIN factura AS f ON c.id_cliente = f.id_cliente
    INNER JOIN detallefactura as ds ON ds.id_factura = f.id_factura
    INNER JOIN inventario AS i ON i.id_articulo = ds.id_articulo
    INNER JOIN tipo AS t ON t.id_tipo=i.id_tipo
    INNER JOIN descripcion AS de ON de.id_articulo= i.id_articulo
    WHERE c.id_cliente = id ORDER BY ds.cantidad DESC LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS `sp_search_asigancion_tienda`$$
CREATE   PROCEDURE `sp_search_asigancion_tienda` ()  BEGIN
SELECT ast.id_tienda,ast.uuid,u.usuario,t.tienda FROM asigancion_tienda AS ast INNER JOIN tienda AS t ON ast.id_tienda=t.id_tienda
    INNER JOIN usuario AS u ON ast.uuid=u.uuid;
END$$

DROP PROCEDURE IF EXISTS `sp_search_cliente`$$
CREATE   PROCEDURE `sp_search_cliente` ()  BEGIN
	SELECT p.id_persona,p.primernombre,p.segundonombre,p.primerapellido,p.segundoapellido,p.direccion,p.nit,p.telefono,c.usuario FROM persona AS p INNER JOIN cliente AS c ON p.id_persona =c.id_cliente;
END$$

DROP PROCEDURE IF EXISTS `sp_search_cliente_single`$$
CREATE   PROCEDURE `sp_search_cliente_single` (IN `pid_cliente` VARCHAR(32))  BEGIN
	SELECT p.id_persona,p.primernombre,p.segundonombre,p.primerapellido,p.segundoapellido,p.direccion,p.nit,p.telefono,c.usuario FROM persona AS p INNER JOIN cliente AS c ON p.id_persona =c.id_cliente WHERE p.nit=pid_cliente;
END$$

DROP PROCEDURE IF EXISTS `sp_search_compra`$$
CREATE   PROCEDURE `sp_search_compra` ()  BEGIN
	SELECT c.id_compra,c.id_proveedor,p.razonsocial AS proveedor,c.id_articulo,i.articulo,c.cantidad,c.precio,(c.cantidad*c.precio) AS total FROM compras AS c 
	INNER JOIN proveedor AS p ON c.id_proveedor=p.id_proveedor
	INNER JOIN inventario AS i ON i.id_articulo=c.id_articulo;
END$$

DROP PROCEDURE IF EXISTS `sp_search_descripcion`$$
CREATE   PROCEDURE `sp_search_descripcion` ()  BEGIN
	SELECT d.id_descripcion,i.id_articulo,i.articulo,d.descripcion FROM descripcion AS d INNER JOIN inventario AS i ON d.id_articulo=i.id_articulo;
END$$

DROP PROCEDURE IF EXISTS `sp_search_detalle`$$
CREATE   PROCEDURE `sp_search_detalle` (IN `pid_factura` INTEGER(11))  BEGIN
	SELECT dt.*,i.articulo FROM detallefactura AS dt
	INNER JOIN factura AS f ON dt.id_factura=f.id_factura
	INNER JOIN inventario AS i ON dt.id_articulo=i.id_articulo
	WHERE f.id_factura=pid_factura;
END$$

DROP PROCEDURE IF EXISTS `sp_search_display`$$
CREATE   PROCEDURE `sp_search_display` ()  BEGIN
	SELECT i.identifier,t.id_tipo,t.tipo FROM display AS d INNER JOIN tipo AS t ON d.id_tipo=t.id_tipo
    INNER JOIN ibeacoins AS i ON d.identifier=i.identifier;
END$$

DROP PROCEDURE IF EXISTS `sp_search_factura`$$
CREATE   PROCEDURE `sp_search_factura` (IN `pid_tienda` INT(11))  BEGIN
		SELECT 
f.id_factura,
f.id_cliente,
f.nit,
f.direccion,
f.estado,
CONCAT(p1.primernombre,' ',p1.primerapellido) AS empleado,
CONCAT(p.primernombre,' ',p.primerapellido) AS cliente,
SUM(df.precio*df.cantidad) AS total
FROM factura AS f 
INNER JOIN cliente AS c ON f.id_cliente=c.id_cliente 
INNER JOIN persona AS p on c.id_cliente=p.id_persona 
INNER JOIN usuario AS u ON f.uuid=u.uuid 
INNER JOIN persona AS p1 ON u.id_persona=p1.id_persona 
INNER JOIN asigancion_tienda AS ast ON ast.uuid=u.uuid 
LEFT JOIN detallefactura AS df ON f.id_factura=df.id_factura
WHERE ast.id_tienda = pid_tienda
GROUP by f.id_factura,
f.id_cliente,
f.nit,
f.direccion,
f.estado,
CONCAT(p1.primernombre,' ',p1.primerapellido),
CONCAT(p.primernombre,' ',p.primerapellido);
END$$

DROP PROCEDURE IF EXISTS `sp_search_factura_single`$$
CREATE   PROCEDURE `sp_search_factura_single` (IN `pid_tienda` INTEGER(11), IN `pid_factura` INTEGER(11))  BEGIN
SELECT 
f.id_factura,
f.id_cliente,
f.nit,
f.direccion,
f.estado,
CONCAT(p1.primernombre,' ',p1.primerapellido) AS empleado,
CONCAT(p.primernombre,' ',p.primerapellido) AS cliente,
SUM(df.precio*df.cantidad) AS total
FROM factura AS f 
INNER JOIN cliente AS c ON f.id_cliente=c.id_cliente 
INNER JOIN persona AS p on C.id_cliente=P.id_persona 
INNER JOIN usuario AS u ON f.uuid=u.uuid 
INNER JOIN persona AS p1 ON u.id_persona=p1.id_persona 
INNER JOIN asigancion_tienda AS ast ON ast.uuid=u.uuid 
LEFT JOIN detallefactura AS df ON f.id_factura=df.id_factura
WHERE ast.id_tienda = pid_tienda AND f.id_factura = pid_factura
GROUP by f.id_factura,
f.id_cliente,
f.nit,
f.direccion,
f.estado,
CONCAT(p1.primernombre,' ',p1.primerapellido),
CONCAT(p.primernombre,' ',p.primerapellido);
END$$

DROP PROCEDURE IF EXISTS `sp_search_horario`$$
CREATE   PROCEDURE `sp_search_horario` ()  BEGIN
	SELECT h.*,u.usuario FROM horario AS h INNER JOIN usuario AS u ON h.uuid=u.uuid;
END$$

DROP PROCEDURE IF EXISTS `sp_search_ibeacoins`$$
CREATE   PROCEDURE `sp_search_ibeacoins` ()  BEGIN
	SELECT identifier,uuid,major,minor FROM ibeacoins;
END$$

DROP PROCEDURE IF EXISTS `sp_search_ibeacoins_cliente`$$
CREATE   PROCEDURE `sp_search_ibeacoins_cliente` ()  BEGIN
	SELECT * FROM ibeacoins;
END$$

DROP PROCEDURE IF EXISTS `sp_search_ibeacoins_single`$$
CREATE   PROCEDURE `sp_search_ibeacoins_single` (IN `id` VARCHAR(128))  BEGIN
	SELECT identifier,uuid,major,minor FROM ibeacoins WHERE identifier= id;
END$$

DROP PROCEDURE IF EXISTS `sp_search_inventario`$$
CREATE   PROCEDURE `sp_search_inventario` ()  BEGIN
		SELECT i.id_articulo,i.id_tienda,t.tienda,i.id_tipo,tp.tipo,i.articulo,i.descripcion,i.precio,i.stock,i.imagen FROM inventario AS i
	INNER JOIN tienda AS t ON t.id_tienda=i.id_tienda
	INNER JOIN tipo AS tp ON tp.id_tipo=i.id_tipo;
END$$

DROP PROCEDURE IF EXISTS `sp_search_inventario_single`$$
CREATE   PROCEDURE `sp_search_inventario_single` (IN `id` INT(11))  BEGIN
SELECT i.id_articulo,i.id_tienda,t.tienda,i.id_tipo,tp.tipo,i.articulo,i.descripcion,i.precio,i.stock,i.imagen FROM inventario AS i
	INNER JOIN tienda AS t ON t.id_tienda=i.id_tienda
	INNER JOIN tipo AS tp ON tp.id_tipo=i.id_tipo WHERE i.id_articulo=id;
END$$

DROP PROCEDURE IF EXISTS `sp_search_persona`$$
CREATE   PROCEDURE `sp_search_persona` ()  BEGIN
	SELECT id_persona,primernombre,segundonombre,primerapellido,segundoapellido,direccion,nit,telefono FROM persona;
END$$

DROP PROCEDURE IF EXISTS `sp_search_persona_single`$$
CREATE   PROCEDURE `sp_search_persona_single` (IN `id` INTEGER(11))  BEGIN
	SELECT id_persona,primernombre,segundonombre,primerapellido,segundoapellido,direccion,nit,telefono FROM persona WHERE id_persona=id;
END$$

DROP PROCEDURE IF EXISTS `sp_search_producto`$$
CREATE   PROCEDURE `sp_search_producto` (IN `pid_articulo` INT(11), IN `pid_tienda` INT(11))  BEGIN
SELECT i.id_articulo,i.id_tienda,t.tienda,i.id_tipo,tp.tipo,i.articulo,i.descripcion,i.precio,i.stock,i.imagen FROM inventario AS i
	INNER JOIN tienda AS t ON t.id_tienda=i.id_tienda
	INNER JOIN tipo AS tp ON tp.id_tipo=i.id_tipo 
	WHERE i.id_articulo=pid_articulo AND i.id_tienda= pid_tienda;
END$$

DROP PROCEDURE IF EXISTS `sp_search_proveedor`$$
CREATE   PROCEDURE `sp_search_proveedor` ()  BEGIN
	SELECT id_proveedor,razonsocial AS proveedor FROM proveedor;
END$$

DROP PROCEDURE IF EXISTS `sp_search_proveedor_single`$$
CREATE   PROCEDURE `sp_search_proveedor_single` (IN `id` INTEGER(11))  BEGIN
	SELECT id_proveedor,razonsocial AS proveedor FROM proveedor WHERE id_proveedor=id;
END$$

DROP PROCEDURE IF EXISTS `sp_search_rol`$$
CREATE   PROCEDURE `sp_search_rol` ()  BEGIN
	SELECT id_rol,rol FROM rol;
END$$

DROP PROCEDURE IF EXISTS `sp_search_rol_single`$$
CREATE   PROCEDURE `sp_search_rol_single` (IN `id` INTEGER(11))  BEGIN
	SELECT id_rol,rol FROM rol WHERE id_rol=id;
END$$

DROP PROCEDURE IF EXISTS `sp_search_tienda`$$
CREATE   PROCEDURE `sp_search_tienda` ()  BEGIN
	SELECT id_tienda,tienda FROM tienda;
END$$

DROP PROCEDURE IF EXISTS `sp_search_tienda_single`$$
CREATE   PROCEDURE `sp_search_tienda_single` (IN `id` INTEGER(11))  BEGIN
	SELECT id_tienda,tienda FROM tienda WHERE id_tienda=id;
END$$

DROP PROCEDURE IF EXISTS `sp_search_tipo`$$
CREATE   PROCEDURE `sp_search_tipo` ()  BEGIN
	SELECT id_tipo,tipo FROM tipo;
END$$

DROP PROCEDURE IF EXISTS `sp_search_tipo_cliente`$$
CREATE   PROCEDURE `sp_search_tipo_cliente` ()  BEGIN
	SELECT distinct  ib.identifier,t.id_tipo FROM ibeacoins AS ib INNER JOIN display AS di ON ib.identifier=di.identifier
	INNER JOIN tipo AS t ON t.id_tipo=di.id_tipo;
END$$

DROP PROCEDURE IF EXISTS `sp_search_tipo_single`$$
CREATE   PROCEDURE `sp_search_tipo_single` (IN `id` INTEGER(11))  BEGIN
	SELECT id_tipo,tipo FROM tipo WHERE id_tipo=id;
END$$

DROP PROCEDURE IF EXISTS `sp_search_usuario`$$
CREATE   PROCEDURE `sp_search_usuario` ()  BEGIN
	SELECT u.uuid,p.id_persona,p.primernombre,p.segundonombre,p.primerapellido,p.segundoapellido,p.direccion,p.nit,p.telefono,u.usuario,r.rol FROM persona AS p INNER JOIN usuario AS u ON p.id_persona =u.id_persona
    INNER JOIN rol AS r ON u.id_rol=r.id_rol;
END$$

DROP PROCEDURE IF EXISTS `sp_search_usuario_single`$$
CREATE   PROCEDURE `sp_search_usuario_single` (IN `id` VARCHAR(32))  BEGIN
	SELECT r.rol,u.uuid,p.id_persona,p.primernombre,p.segundonombre,p.primerapellido,p.segundoapellido,p.direccion,p.nit,p.telefono,u.usuario FROM persona AS p INNER JOIN usuario AS u ON p.id_persona =u.id_persona INNER JOIN rol AS r ON r.id_rol=u.id_rol WHERE u.uuid=id; 
END$$

DROP PROCEDURE IF EXISTS `sp_session`$$
CREATE   PROCEDURE `sp_session` (IN `pusuario` VARCHAR(128), IN `pid_rol` INT(11))  BEGIN
	SELECT * FROM usuario WHERE usuario=pusuario AND id_rol = pid_rol;
END$$

DROP PROCEDURE IF EXISTS `sp_session_cliente`$$
CREATE   PROCEDURE `sp_session_cliente` (IN `pusuario` VARCHAR(32))  BEGIN
	SELECT * FROM cliente  WHERE usuario = pusuario;
END$$

DROP PROCEDURE IF EXISTS `sp_session_usuario`$$
CREATE   PROCEDURE `sp_session_usuario` (IN `pusuario` VARCHAR(128), IN `pid_rol` INT(11))  BEGIN
	SELECT u.*,t.* FROM usuario AS u INNER JOIN asigancion_tienda AS ast ON u.uuid=ast.uuid INNER JOIN tienda AS t ON t.id_tienda=ast.id_tienda WHERE u.usuario=pusuario AND u.id_rol = pid_rol;
END$$

DROP PROCEDURE IF EXISTS `sp_update_descripcion`$$
CREATE   PROCEDURE `sp_update_descripcion` (IN `id` INT(11), IN `pid_articulo` INT(11), IN `pdescripcion` VARCHAR(128))  BEGIN
	UPDATE descripcion SET id_articulo=pid_articulo, descripcion = pdescripcion WHERE id_descripcion= id;
END$$

DROP PROCEDURE IF EXISTS `sp_update_horario`$$
CREATE   PROCEDURE `sp_update_horario` (IN `pid_horario` INT(11), IN `phora_entrada` VARCHAR(20), IN `phora_salida` VARCHAR(20))  BEGIN
	UPDATE horario SET hora_entrada=phora_entrada,hora_salida=phora_salida WHERE id_horario= pid_horario;
END$$

DROP PROCEDURE IF EXISTS `sp_update_ibeacoins`$$
CREATE   PROCEDURE `sp_update_ibeacoins` (IN `id` VARCHAR(128), IN `puuid` VARCHAR(128), IN `pmajor` INTEGER(11), IN `pminor` INTEGER(11))  BEGIN
	UPDATE ibeacoins SET uuid=puuid,major=pmajor,minor=pminor WHERE identifier= id;
END$$

DROP PROCEDURE IF EXISTS `sp_update_proveedor`$$
CREATE   PROCEDURE `sp_update_proveedor` (IN `pid_proveedor` INTEGER(11), IN `pproveedor` VARCHAR(128))  BEGIN
	UPDATE proveedor SET razonsocial = pproveedor WHERE id_proveedor= pid_proveedor;
END$$

DROP PROCEDURE IF EXISTS `sp_update_rol`$$
CREATE   PROCEDURE `sp_update_rol` (IN `pid_rol` INTEGER(11), IN `prol` VARCHAR(128))  BEGIN
	UPDATE rol SET rol = prol WHERE id_rol= pid_rol;
END$$

DROP PROCEDURE IF EXISTS `sp_update_tienda`$$
CREATE   PROCEDURE `sp_update_tienda` (IN `pid_tienda` INTEGER(11), IN `ptienda` VARCHAR(128))  BEGIN
	UPDATE tienda SET tienda = ptienda WHERE id_tienda= pid_tienda;
END$$

DROP PROCEDURE IF EXISTS `sp_update_tipo`$$
CREATE   PROCEDURE `sp_update_tipo` (IN `pid_tipo` INTEGER(11), IN `ptipo` VARCHAR(128))  BEGIN
	UPDATE tipo SET tipo = ptipo WHERE id_tipo= pid_tipo;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asigancion_tienda`
--

DROP TABLE IF EXISTS `asigancion_tienda`;
CREATE TABLE IF NOT EXISTS `asigancion_tienda` (
  `id_tienda` int(11) NOT NULL,
  `uuid` varchar(32) NOT NULL,
  PRIMARY KEY (`id_tienda`,`uuid`),
  KEY `Relationship24` (`uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `asigancion_tienda`
--

INSERT INTO `asigancion_tienda` (`id_tienda`, `uuid`) VALUES
(1, '1825410'),
(1, '26262626');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bitacora`
--

DROP TABLE IF EXISTS `bitacora`;
CREATE TABLE IF NOT EXISTS `bitacora` (
  `id_bitacora` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(32) DEFAULT NULL,
  `hora` datetime NOT NULL,
  `estado` varchar(32) NOT NULL,
  `descripcion` varchar(32) NOT NULL,
  PRIMARY KEY (`id_bitacora`),
  KEY `IX_Relationship27` (`uuid`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `bitacora`
--

INSERT INTO `bitacora` (`id_bitacora`, `uuid`, `hora`, `estado`, `descripcion`) VALUES
(1, '1825410', '2020-10-21 00:00:00', '1', 'retraso'),
(2, '1825410', '2020-10-21 14:08:52', '1', 'retraso'),
(3, '1825410', '2020-10-21 14:10:20', '2', 'Regreso o regresara'),
(4, '1825410', '2020-10-21 14:11:44', '2', 'Regreso o regresara'),
(5, '1825410', '2020-10-21 14:17:43', '2', 'Regreso o regresara'),
(6, '1825410', '2020-10-21 14:19:17', '2', 'Regreso o regresara'),
(7, '1825410', '2020-10-21 14:25:05', '1', 'retraso');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

DROP TABLE IF EXISTS `cliente`;
CREATE TABLE IF NOT EXISTS `cliente` (
  `id_cliente` int(11) NOT NULL,
  `usuario` varchar(16) NOT NULL,
  `clave` varchar(128) NOT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id_cliente`, `usuario`, `clave`) VALUES
(3, '26262626', '26262626'),
(4, '10101010', '10101010'),
(5, '252525', '252525');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

DROP TABLE IF EXISTS `compras`;
CREATE TABLE IF NOT EXISTS `compras` (
  `id_compra` int(11) NOT NULL AUTO_INCREMENT,
  `id_proveedor` int(11) NOT NULL,
  `id_articulo` int(11) DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` float(10,2) NOT NULL,
  PRIMARY KEY (`id_compra`),
  KEY `IX_Relationship1` (`id_proveedor`),
  KEY `IX_Relationship14` (`id_articulo`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `compras`
--

INSERT INTO `compras` (`id_compra`, `id_proveedor`, `id_articulo`, `cantidad`, `precio`) VALUES
(1, 1, 1, 50, 11.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `descripcion`
--

DROP TABLE IF EXISTS `descripcion`;
CREATE TABLE IF NOT EXISTS `descripcion` (
  `id_descripcion` int(11) NOT NULL AUTO_INCREMENT,
  `id_articulo` int(11) DEFAULT NULL,
  `descripcion` varchar(256) NOT NULL,
  PRIMARY KEY (`id_descripcion`),
  KEY `IX_Relationship11` (`id_articulo`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `descripcion`
--

INSERT INTO `descripcion` (`id_descripcion`, `id_articulo`, `descripcion`) VALUES
(1, 1, 'Leche deslactosada semidescremada 800 gramos ');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detallefactura`
--

DROP TABLE IF EXISTS `detallefactura`;
CREATE TABLE IF NOT EXISTS `detallefactura` (
  `id_factura` int(11) NOT NULL,
  `id_articulo` int(11) NOT NULL,
  `precio` float(10,2) NOT NULL,
  `cantidad` int(11) NOT NULL,
  PRIMARY KEY (`id_factura`,`id_articulo`),
  KEY `Relationship13` (`id_articulo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `detallefactura`
--

INSERT INTO `detallefactura` (`id_factura`, `id_articulo`, `precio`, `cantidad`) VALUES
(2, 1, 11.00, 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `display`
--

DROP TABLE IF EXISTS `display`;
CREATE TABLE IF NOT EXISTS `display` (
  `identifier` varchar(128) NOT NULL,
  `id_tipo` int(11) NOT NULL,
  PRIMARY KEY (`id_tipo`,`identifier`),
  KEY `Relationship15` (`identifier`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `display`
--

INSERT INTO `display` (`identifier`, `id_tipo`) VALUES
('53bdc464be5d94bd8a6c0ccc6382e809', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

DROP TABLE IF EXISTS `factura`;
CREATE TABLE IF NOT EXISTS `factura` (
  `id_factura` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(32) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `nit` varchar(10) NOT NULL,
  `direccion` varchar(256) NOT NULL,
  `fecha` date NOT NULL,
  `estado` enum('CREADA','PROCESO','CANCELADA','ANULADA') NOT NULL,
  PRIMARY KEY (`id_factura`),
  KEY `IX_Relationship26` (`uuid`),
  KEY `IX_Relationship31` (`id_cliente`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `factura`
--

INSERT INTO `factura` (`id_factura`, `uuid`, `id_cliente`, `nit`, `direccion`, `fecha`, `estado`) VALUES
(1, '26262626', 5, '252525', 'Jalapa', '2020-10-20', 'ANULADA'),
(2, '26262626', 5, '252525', 'Jalapa', '2020-10-20', 'CANCELADA'),
(3, '26262626', 5, '252525', 'Jalapa', '2020-10-20', 'ANULADA'),
(4, '26262626', 5, '252525', 'Jalapa', '2020-10-20', 'PROCESO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horario`
--

DROP TABLE IF EXISTS `horario`;
CREATE TABLE IF NOT EXISTS `horario` (
  `id_horario` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(32) DEFAULT NULL,
  `hora_entrada` varchar(20) NOT NULL,
  `hora_salida` varchar(20) NOT NULL,
  PRIMARY KEY (`id_horario`),
  KEY `IX_Relationship25` (`uuid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `horario`
--

INSERT INTO `horario` (`id_horario`, `uuid`, `hora_entrada`, `hora_salida`) VALUES
(1, '1825410', '12:00', '12:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ibeacoins`
--

DROP TABLE IF EXISTS `ibeacoins`;
CREATE TABLE IF NOT EXISTS `ibeacoins` (
  `identifier` varchar(128) NOT NULL,
  `uuid` varchar(128) NOT NULL,
  `major` int(11) NOT NULL,
  `minor` int(11) NOT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ibeacoins`
--

INSERT INTO `ibeacoins` (`identifier`, `uuid`, `major`, `minor`) VALUES
('275d18507618376553b8f2e11eab1939', 'B9407F30-F5F8-466E-AFF9-25556B57FE6D', 45979, 62055),
('53bdc464be5d94bd8a6c0ccc6382e809', 'B9407F30-F5F8-466E-AFF9-25556B57FE6D', 3991, 52849),
('93f246dd418c9bf39ff3790440db2820', 'B9407F30-F5F8-466E-AFF9-25556B57FE6D', 65151, 9841);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

DROP TABLE IF EXISTS `inventario`;
CREATE TABLE IF NOT EXISTS `inventario` (
  `id_articulo` int(11) NOT NULL AUTO_INCREMENT,
  `id_tienda` int(11) DEFAULT NULL,
  `id_tipo` int(11) DEFAULT NULL,
  `articulo` varchar(128) NOT NULL,
  `descripcion` varchar(128) NOT NULL,
  `precio` float(10,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `imagen` varchar(128) NOT NULL,
  PRIMARY KEY (`id_articulo`),
  KEY `IX_Relationship12` (`id_tipo`),
  KEY `IX_Relationship28` (`id_tienda`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`id_articulo`, `id_tienda`, `id_tipo`, `articulo`, `descripcion`, `precio`, `stock`, `imagen`) VALUES
(1, 1, 1, 'leche', 'es leche de vaca', 11.00, 30, 'http://192.168.43.7:3000/files/1603135575896Letras.png.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario111`
--

DROP TABLE IF EXISTS `inventario111`;
CREATE TABLE IF NOT EXISTS `inventario111` (
  `id_inventario` int(11) NOT NULL AUTO_INCREMENT,
  `stock` char(20) NOT NULL,
  PRIMARY KEY (`id_inventario`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

DROP TABLE IF EXISTS `persona`;
CREATE TABLE IF NOT EXISTS `persona` (
  `id_persona` int(11) NOT NULL AUTO_INCREMENT,
  `primernombre` varchar(128) NOT NULL,
  `segundonombre` varchar(128) NOT NULL,
  `primerapellido` varchar(128) NOT NULL,
  `segundoapellido` varchar(128) NOT NULL,
  `direccion` varchar(256) NOT NULL,
  `nit` varchar(16) NOT NULL,
  `telefono` varchar(16) NOT NULL,
  PRIMARY KEY (`id_persona`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`id_persona`, `primernombre`, `segundonombre`, `primerapellido`, `segundoapellido`, `direccion`, `nit`, `telefono`) VALUES
(1, 'Yocelin', 'Sarai', 'Bonilla', 'Bonilla', 'Jalapa', '252525', '51227590'),
(2, 'Victor', 'Isaias', 'Bonilla', 'Chalo', 'Jalapa', '181818', '41891552'),
(3, 'Gerson', 'Arisai', 'Ramos', 'Portillo', 'Jalapa', '26262626', '25478595'),
(4, 'Mayte', 'Loredana', 'Chalo', 'Martinez', 'Jalapa', '10101010', '54785253'),
(5, 'Arisai', 'Gerson', 'Portillo', 'Ramos', 'Jalapa', '252525', '12345678');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
CREATE TABLE IF NOT EXISTS `proveedor` (
  `id_proveedor` int(11) NOT NULL AUTO_INCREMENT,
  `razonsocial` varchar(128) NOT NULL,
  PRIMARY KEY (`id_proveedor`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`id_proveedor`, `razonsocial`) VALUES
(1, 'Dos pinos inc. S.A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

DROP TABLE IF EXISTS `rol`;
CREATE TABLE IF NOT EXISTS `rol` (
  `id_rol` int(11) NOT NULL AUTO_INCREMENT,
  `rol` varchar(128) NOT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`id_rol`, `rol`) VALUES
(1, 'Administrador'),
(2, 'Usuario');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tienda`
--

DROP TABLE IF EXISTS `tienda`;
CREATE TABLE IF NOT EXISTS `tienda` (
  `id_tienda` int(11) NOT NULL AUTO_INCREMENT,
  `tienda` varchar(128) NOT NULL,
  PRIMARY KEY (`id_tienda`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tienda`
--

INSERT INTO `tienda` (`id_tienda`, `tienda`) VALUES
(1, 'Mustore');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo`
--

DROP TABLE IF EXISTS `tipo`;
CREATE TABLE IF NOT EXISTS `tipo` (
  `id_tipo` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(128) NOT NULL,
  PRIMARY KEY (`id_tipo`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipo`
--

INSERT INTO `tipo` (`id_tipo`, `tipo`) VALUES
(1, 'lacteos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `uuid` varchar(32) NOT NULL,
  `id_persona` int(11) DEFAULT NULL,
  `id_rol` int(11) DEFAULT NULL,
  `usuario` varchar(128) NOT NULL,
  `pass` varchar(128) NOT NULL,
  PRIMARY KEY (`uuid`),
  KEY `IX_Relationship32` (`id_persona`),
  KEY `IX_Relationship33` (`id_rol`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`uuid`, `id_persona`, `id_rol`, `usuario`, `pass`) VALUES
('1825410', 1, 1, 'Yos', '1234'),
('26262626', 3, 2, 'Ger', '1234');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
