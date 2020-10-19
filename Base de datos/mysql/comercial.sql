-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 19-10-2020 a las 18:01:46
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
DROP PROCEDURE IF EXISTS `sp_create_asigancion_tienda`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_asigancion_tienda` (IN `pid_tipo` INTEGER(11), IN `puuid` VARCHAR(32))  BEGIN
	INSERT INTO asigancion_tienda (id_tienda,uuid) VALUES (pid_tipo,puuid);
END$$

DROP PROCEDURE IF EXISTS `sp_create_cliente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_cliente` (IN `pprimernombre` VARCHAR(128), IN `psegundonombre` VARCHAR(128), IN `pprimerapellido` VARCHAR(128), IN `psegundoapellido` VARCHAR(128), IN `pdireccion` VARCHAR(256), IN `pnit` VARCHAR(16), IN `ptelefono` VARCHAR(16))  BEGIN
	INSERT INTO persona (primernombre,segundonombre,primerapellido,segundoapellido,direccion,nit,telefono) VALUES (pprimernombre,psegundonombre,pprimerapellido,psegundoapellido,pdireccion,pnit,ptelefono);
    SET @id_cliente = (SELECT id_persona FROM persona ORDER BY id_persona DESC LIMIT 1);
    INSERT INTO cliente (id_cliente,usuario,clave) VALUES (@id_cliente,pnit,pnit);
END$$

DROP PROCEDURE IF EXISTS `sp_create_compra`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_compra` (IN `pid_proveedor` INT(11), IN `pid_articulo` INT(11), IN `pcantidad` INT(11), IN `pprecio` FLOAT(10,2))  BEGIN
	INSERT INTO compras (id_proveedor,id_articulo,cantidad,precio) VALUES (pid_proveedor,pid_articulo,pcantidad,pprecio);
	SET @pstock= (SELECT stock FROM inventario WHERE id_articulo = pid_articulo);
	SET @pstock = @pstock+pcantidad;
	UPDATE inventario SET stock=@pstock WHERE id_articulo = pid_articulo;
END$$

DROP PROCEDURE IF EXISTS `sp_create_descripcion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_descripcion` (IN `pid_articulo` INTEGER(11), IN `pdescripcion` VARCHAR(128))  BEGIN
	INSERT INTO descripcion (id_articulo,descripcion) VALUES (pid_articulo,pdescripcion);
END$$

DROP PROCEDURE IF EXISTS `sp_create_display`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_display` (IN `pidentifier` VARCHAR(128), IN `pid_tipo` INTEGER(11))  BEGIN
	INSERT INTO display (identifier,id_tipo) VALUES (pidentifier,pid_tipo);
END$$

DROP PROCEDURE IF EXISTS `sp_create_horario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_horario` (IN `puuid` VARCHAR(32), IN `phora_entrada` VARCHAR(20), IN `phora_salida` VARCHAR(20))  BEGIN
	INSERT INTO horario (uuid,hora_entrada,hora_salida) VALUES (puuid,phora_entrada,phora_salida);
    
END$$

DROP PROCEDURE IF EXISTS `sp_create_ibeacoins`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_ibeacoins` (IN `pidentifier` VARCHAR(128), IN `puuid` VARCHAR(128), IN `pmajor` INTEGER(11), IN `pminor` INTEGER(11))  BEGIN
	INSERT INTO ibeacoins (identifier,uuid,major,minor) VALUES (pidentifier,puuid,pmajor,pminor);
END$$

DROP PROCEDURE IF EXISTS `sp_create_inventario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_inventario` (IN `pid_tienda` INTEGER(11), IN `pid_tipo` INTEGER(11), IN `particulo` VARCHAR(128), IN `pdescripcion` VARCHAR(128), IN `pprecio` FLOAT(10,2), IN `pimagen` VARCHAR(128))  BEGIN
	INSERT INTO inventario (id_tienda,id_tipo,articulo,descripcion,precio,stock,imagen) VALUES (pid_tienda,pid_tipo,particulo,pdescripcion,pprecio,0,pimagen);
END$$

DROP PROCEDURE IF EXISTS `sp_create_persona`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_persona` (IN `pprimernombre` VARCHAR(128), IN `psegundonombre` VARCHAR(128), IN `pprimerapellido` VARCHAR(128), IN `psegundoapellido` VARCHAR(128), IN `pdireccion` VARCHAR(256), IN `pnit` VARCHAR(16), IN `ptelefono` VARCHAR(16))  BEGIN
	INSERT INTO persona (primernombre,segundonombre,primerapellido,segundoapellido,direccion,nit,telefono) VALUES (pprimernombre,psegundonombre,pprimerapellido,psegundoapellido,pdireccion,pnit,ptelefono);
END$$

DROP PROCEDURE IF EXISTS `sp_create_proveedor`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_proveedor` (IN `pproveedor` VARCHAR(128))  BEGIN
	INSERT INTO proveedor (razonsocial) VALUES (pproveedor);
END$$

DROP PROCEDURE IF EXISTS `sp_create_rol`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_rol` (IN `prol` VARCHAR(128))  BEGIN
	INSERT INTO rol (rol) VALUES (prol);
END$$

DROP PROCEDURE IF EXISTS `sp_create_tienda`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_tienda` (IN `ptienda` VARCHAR(128))  BEGIN
	INSERT INTO tienda (tienda) VALUES (ptienda);
END$$

DROP PROCEDURE IF EXISTS `sp_create_tipo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_tipo` (IN `ptipo` VARCHAR(128))  BEGIN
	INSERT INTO tipo (tipo) VALUES (ptipo);
END$$

DROP PROCEDURE IF EXISTS `sp_create_usuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_usuario` (IN `puuid` VARCHAR(32), IN `pid_persona` INTEGER(11), IN `pid_rol` INTEGER(11), IN `pusuario` VARCHAR(128), IN `ppass` VARCHAR(128))  BEGIN
    INSERT INTO usuario (uuid,id_persona,id_rol,usuario,pass) VALUES (puuid,pid_persona,pid_rol,pusuario,ppass);
END$$

DROP PROCEDURE IF EXISTS `sp_delete_asigancion_tienda`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_asigancion_tienda` (IN `id` INT(11), IN `id1` VARCHAR(11))  BEGIN
	DELETE FROM asigancion_tienda WHERE id_tienda=id AND uuid=id1;
END$$

DROP PROCEDURE IF EXISTS `sp_delete_descripcion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_descripcion` (IN `id` INTEGER(11))  BEGIN
	DELETE FROM descripcion WHERE id_descripcion=id;
END$$

DROP PROCEDURE IF EXISTS `sp_delete_display`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_display` (IN `id` VARCHAR(128), IN `id1` INTEGER(11))  BEGIN
	DELETE FROM display WHERE identifier=id AND id_tipo=id1;
END$$

DROP PROCEDURE IF EXISTS `sp_delete_horario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_horario` (IN `id` INTEGER(11))  BEGIN
	DELETE FROM horario WHERE id_horario=id;
END$$

DROP PROCEDURE IF EXISTS `sp_delete_ibeacoins`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_ibeacoins` (IN `id` VARCHAR(128))  BEGIN
	DELETE FROM ibeacoins WHERE identifier=id;
END$$

DROP PROCEDURE IF EXISTS `sp_delete_proveedor`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_proveedor` (IN `id` INTEGER(11))  BEGIN
	DELETE FROM proveedor WHERE id_proveedor=id;
END$$

DROP PROCEDURE IF EXISTS `sp_delete_rol`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_rol` (IN `id` INTEGER(11))  BEGIN
	DELETE FROM rol WHERE id_rol=id;
END$$

DROP PROCEDURE IF EXISTS `sp_delete_tienda`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_tienda` (IN `id` INTEGER(11))  BEGIN
	DELETE FROM tienda WHERE id_tienda=id;
END$$

DROP PROCEDURE IF EXISTS `sp_delete_tipo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_tipo` (IN `id` INTEGER(11))  BEGIN
	DELETE FROM tipo WHERE id_tipo=id;
END$$

DROP PROCEDURE IF EXISTS `sp_search_asigancion_tienda`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_asigancion_tienda` ()  BEGIN
SELECT ast.id_tienda,ast.uuid,u.usuario,t.tienda FROM asigancion_tienda AS ast INNER JOIN tienda AS t ON ast.id_tienda=t.id_tienda
    INNER JOIN usuario AS u ON ast.uuid=u.uuid;
END$$

DROP PROCEDURE IF EXISTS `sp_search_cliente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_cliente` ()  BEGIN
	SELECT p.id_persona,p.primernombre,p.segundonombre,p.primerapellido,p.segundoapellido,p.direccion,p.nit,p.telefono,c.usuario FROM persona AS p INNER JOIN cliente AS c ON p.id_persona =c.id_cliente;
END$$

DROP PROCEDURE IF EXISTS `sp_search_compra`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_compra` ()  BEGIN
	SELECT c.id_compra,c.id_proveedor,p.razonsocial AS proveedor,c.id_articulo,i.articulo,c.cantidad,c.precio,(c.cantidad*c.precio) AS total FROM compras AS c 
	INNER JOIN proveedor AS p ON c.id_proveedor=p.id_proveedor
	INNER JOIN inventario AS i ON i.id_articulo=c.id_articulo;
END$$

DROP PROCEDURE IF EXISTS `sp_search_descripcion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_descripcion` ()  BEGIN
	SELECT d.id_descripcion,i.id_articulo,i.articulo,d.descripcion FROM descripcion AS d INNER JOIN inventario AS i ON d.id_articulo=i.id_articulo;
END$$

DROP PROCEDURE IF EXISTS `sp_search_display`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_display` ()  BEGIN
	SELECT i.identifier,t.id_tipo,t.tipo FROM display AS d INNER JOIN tipo AS t ON d.id_tipo=t.id_tipo
    INNER JOIN ibeacoins AS i ON d.identifier=i.identifier;
END$$

DROP PROCEDURE IF EXISTS `sp_search_horario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_horario` ()  BEGIN
	SELECT h.*,u.usuario FROM horario AS h INNER JOIN usuario AS u ON h.uuid=u.uuid;
END$$

DROP PROCEDURE IF EXISTS `sp_search_ibeacoins`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_ibeacoins` ()  BEGIN
	SELECT identifier,uuid,major,minor FROM ibeacoins;
END$$

DROP PROCEDURE IF EXISTS `sp_search_ibeacoins_single`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_ibeacoins_single` (IN `id` VARCHAR(128))  BEGIN
	SELECT identifier,uuid,major,minor FROM ibeacoins WHERE identifier= id;
END$$

DROP PROCEDURE IF EXISTS `sp_search_inventario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_inventario` ()  BEGIN
		SELECT i.id_articulo,i.id_tienda,t.tienda,i.id_tipo,tp.tipo,i.articulo,i.descripcion,i.precio,i.stock,i.imagen FROM inventario AS i
	INNER JOIN tienda AS t ON t.id_tienda=i.id_tienda
	INNER JOIN tipo AS tp ON tp.id_tipo=i.id_tipo;
END$$

DROP PROCEDURE IF EXISTS `sp_search_persona`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_persona` ()  BEGIN
	SELECT id_persona,primernombre,segundonombre,primerapellido,segundoapellido,direccion,nit,telefono FROM persona;
END$$

DROP PROCEDURE IF EXISTS `sp_search_persona_single`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_persona_single` (IN `id` INTEGER(11))  BEGIN
	SELECT id_persona,primernombre,segundonombre,primerapellido,segundoapellido,direccion,nit,telefono FROM persona WHERE id_persona=id;
END$$

DROP PROCEDURE IF EXISTS `sp_search_proveedor`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_proveedor` ()  BEGIN
	SELECT id_proveedor,razonsocial AS proveedor FROM proveedor;
END$$

DROP PROCEDURE IF EXISTS `sp_search_rol`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_rol` ()  BEGIN
	SELECT id_rol,rol FROM rol;
END$$

DROP PROCEDURE IF EXISTS `sp_search_tienda`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_tienda` ()  BEGIN
	SELECT id_tienda,tienda FROM tienda;
END$$

DROP PROCEDURE IF EXISTS `sp_search_tienda_single`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_tienda_single` (IN `id` INTEGER(11))  BEGIN
	SELECT id_tienda,tienda FROM tienda WHERE id_tienda=id;
END$$

DROP PROCEDURE IF EXISTS `sp_search_tipo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_tipo` ()  BEGIN
	SELECT id_tipo,tipo FROM tipo;
END$$

DROP PROCEDURE IF EXISTS `sp_search_tipo_single`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_tipo_single` (IN `id` INTEGER(11))  BEGIN
	SELECT id_tipo,tipo FROM tipo WHERE id_tipo=id;
END$$

DROP PROCEDURE IF EXISTS `sp_search_usuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_usuario` ()  BEGIN
	SELECT u.uuid,p.id_persona,p.primernombre,p.segundonombre,p.primerapellido,p.segundoapellido,p.direccion,p.nit,p.telefono,u.usuario,r.rol FROM persona AS p INNER JOIN usuario AS u ON p.id_persona =u.id_persona
    INNER JOIN rol AS r ON u.id_rol=r.id_rol;
END$$

DROP PROCEDURE IF EXISTS `sp_update_descripcion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_descripcion` (IN `id` INT(11), IN `pid_articulo` INT(11), IN `pdescripcion` VARCHAR(128))  BEGIN
	UPDATE descripcion SET id_articulo=pid_articulo, descripcion = pdescripcion WHERE id_descripcion= id;
END$$

DROP PROCEDURE IF EXISTS `sp_update_horario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_horario` (IN `pid_horario` INT(11), IN `phora_entrada` VARCHAR(20), IN `phora_salida` VARCHAR(20))  BEGIN
	UPDATE horario SET hora_entrada=phora_entrada,hora_salida=phora_salida WHERE id_horario= pid_horario;
END$$

DROP PROCEDURE IF EXISTS `sp_update_ibeacoins`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_ibeacoins` (IN `id` VARCHAR(128), IN `puuid` VARCHAR(128), IN `pmajor` INTEGER(11), IN `pminor` INTEGER(11))  BEGIN
	UPDATE ibeacoins SET uuid=puuid,major=pmajor,minor=pminor WHERE identifier= id;
END$$

DROP PROCEDURE IF EXISTS `sp_update_proveedor`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_proveedor` (IN `pid_proveedor` INTEGER(11), IN `pproveedor` VARCHAR(128))  BEGIN
	UPDATE proveedor SET razonsocial = pproveedor WHERE id_proveedor= pid_proveedor;
END$$

DROP PROCEDURE IF EXISTS `sp_update_rol`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_rol` (IN `pid_rol` INTEGER(11), IN `prol` VARCHAR(128))  BEGIN
	UPDATE rol SET rol = prol WHERE id_rol= pid_rol;
END$$

DROP PROCEDURE IF EXISTS `sp_update_tienda`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_tienda` (IN `pid_tienda` INTEGER(11), IN `ptienda` VARCHAR(128))  BEGIN
	UPDATE tienda SET tienda = ptienda WHERE id_tienda= pid_tienda;
END$$

DROP PROCEDURE IF EXISTS `sp_update_tipo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_tipo` (IN `pid_tipo` INTEGER(11), IN `ptipo` VARCHAR(128))  BEGIN
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bitacora`
--

DROP TABLE IF EXISTS `bitacora`;
CREATE TABLE IF NOT EXISTS `bitacora` (
  `id_bitacora` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(32) DEFAULT NULL,
  `hora` varchar(20) NOT NULL,
  `estado` varchar(32) NOT NULL,
  `descripcion` varchar(32) NOT NULL,
  PRIMARY KEY (`id_bitacora`),
  KEY `IX_Relationship27` (`uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
CREATE TABLE IF NOT EXISTS `proveedor` (
  `id_proveedor` int(11) NOT NULL AUTO_INCREMENT,
  `razonsocial` varchar(128) NOT NULL,
  PRIMARY KEY (`id_proveedor`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

DROP TABLE IF EXISTS `rol`;
CREATE TABLE IF NOT EXISTS `rol` (
  `id_rol` int(11) NOT NULL AUTO_INCREMENT,
  `rol` varchar(128) NOT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tienda`
--

DROP TABLE IF EXISTS `tienda`;
CREATE TABLE IF NOT EXISTS `tienda` (
  `id_tienda` int(11) NOT NULL AUTO_INCREMENT,
  `tienda` varchar(128) NOT NULL,
  PRIMARY KEY (`id_tienda`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo`
--

DROP TABLE IF EXISTS `tipo`;
CREATE TABLE IF NOT EXISTS `tipo` (
  `id_tipo` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(128) NOT NULL,
  PRIMARY KEY (`id_tipo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
