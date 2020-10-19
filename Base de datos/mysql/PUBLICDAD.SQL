/*
Created: 23/07/2020
Modified: 18/10/2020
Model: MySQL 5.7
Database: MySQL 5.7
*/


-- Create tables section -------------------------------------------------

-- Table factura

CREATE TABLE `factura`
(
  `id_factura` Int NOT NULL AUTO_INCREMENT,
  `uuid` Varchar(32) NOT NULL,
  `id_cliente` Int NOT NULL,
  `nit` Varchar(10) NOT NULL,
  `direccion` Varchar(256) NOT NULL,
  `fecha` Date NOT NULL,
  `estado` Enum('CREADA','PROCESO','CANCELADA','ANULADA') NOT NULL,
  PRIMARY KEY (`id_factura`)
)
;

CREATE INDEX `IX_Relationship26` ON `factura` (`uuid`)
;

CREATE INDEX `IX_Relationship31` ON `factura` (`id_cliente`)
;

-- Table cliente

CREATE TABLE `cliente`
(
  `id_cliente` Int NOT NULL,
  `usuario` Varchar(16) NOT NULL,
  `clave` Varchar(128) NOT NULL
)
;

ALTER TABLE `cliente` ADD PRIMARY KEY (`id_cliente`)
;

-- Table inventario

CREATE TABLE `inventario`
(
  `id_articulo` Int NOT NULL AUTO_INCREMENT,
  `id_tienda` Int,
  `id_tipo` Int,
  `articulo` Varchar(128) NOT NULL,
  `descripcion` Varchar(128) NOT NULL,
  `precio` Float(10,2) NOT NULL,
  `stock` Int NOT NULL,
  `imagen` Varchar(128) NOT NULL,
  PRIMARY KEY (`id_articulo`)
)
;

CREATE INDEX `IX_Relationship12` ON `inventario` (`id_tipo`)
;

CREATE INDEX `IX_Relationship28` ON `inventario` (`id_tienda`)
;

-- Table proveedor

CREATE TABLE `proveedor`
(
  `id_proveedor` Int NOT NULL AUTO_INCREMENT,
  `razonsocial` Varchar(128) NOT NULL,
  PRIMARY KEY (`id_proveedor`)
)
;

-- Table inventario111

CREATE TABLE `inventario111`
(
  `id_inventario` Int NOT NULL AUTO_INCREMENT,
  `stock` Char(20) NOT NULL,
  PRIMARY KEY (`id_inventario`)
)
;

-- Table detallefactura

CREATE TABLE `detallefactura`
(
  `id_factura` Int NOT NULL,
  `id_articulo` Int NOT NULL,
  `precio` Float(10,2) NOT NULL,
  `cantidad` Int NOT NULL
)
;

ALTER TABLE `detallefactura` ADD PRIMARY KEY (`id_factura`,`id_articulo`)
;

-- Table tipo

CREATE TABLE `tipo`
(
  `id_tipo` Int NOT NULL AUTO_INCREMENT,
  `tipo` Varchar(128) NOT NULL,
  PRIMARY KEY (`id_tipo`)
)
;

-- Table compras

CREATE TABLE `compras`
(
  `id_compra` Int NOT NULL AUTO_INCREMENT,
  `id_proveedor` Int NOT NULL,
  `id_articulo` Int,
  `cantidad` Int NOT NULL,
  `precio` Float(10,2) NOT NULL,
  PRIMARY KEY (`id_compra`)
)
;

CREATE INDEX `IX_Relationship1` ON `compras` (`id_proveedor`)
;

CREATE INDEX `IX_Relationship14` ON `compras` (`id_articulo`)
;

-- Table descripcion

CREATE TABLE `descripcion`
(
  `id_descripcion` Int NOT NULL AUTO_INCREMENT,
  `id_articulo` Int,
  `descripcion` Varchar(256) NOT NULL,
  PRIMARY KEY (`id_descripcion`)
)
;

CREATE INDEX `IX_Relationship11` ON `descripcion` (`id_articulo`)
;

-- Table ibeacoins

CREATE TABLE `ibeacoins`
(
  `identifier` Varchar(128) NOT NULL,
  `uuid` Varchar(128) NOT NULL,
  `major` Int NOT NULL,
  `minor` Int NOT NULL
)
;

ALTER TABLE `ibeacoins` ADD PRIMARY KEY (`identifier`)
;

-- Table display

CREATE TABLE `display`
(
  `identifier` Varchar(128) NOT NULL,
  `id_tipo` Int NOT NULL
)
;

ALTER TABLE `display` ADD PRIMARY KEY (`id_tipo`,`identifier`)
;

-- Table usuario

CREATE TABLE `usuario`
(
  `uuid` Varchar(32) NOT NULL,
  `id_persona` Int,
  `id_rol` Int(11),
  `usuario` Varchar(128) NOT NULL,
  `pass` Varchar(128) NOT NULL
)
;

CREATE INDEX `IX_Relationship32` ON `usuario` (`id_persona`)
;

CREATE INDEX `IX_Relationship33` ON `usuario` (`id_rol`)
;

ALTER TABLE `usuario` ADD PRIMARY KEY (`uuid`)
;

-- Table horario

CREATE TABLE `horario`
(
  `id_horario` Int NOT NULL AUTO_INCREMENT,
  `uuid` Varchar(32),
  `hora_entrada` Varchar(20) NOT NULL,
  `hora_salida` Varchar(20) NOT NULL,
  PRIMARY KEY (`id_horario`)
)
;

CREATE INDEX `IX_Relationship25` ON `horario` (`uuid`)
;

-- Table bitacora

CREATE TABLE `bitacora`
(
  `id_bitacora` Int NOT NULL AUTO_INCREMENT,
  `uuid` Varchar(32),
  `hora` Varchar(20) NOT NULL,
  `estado` Varchar(32) NOT NULL,
  `descripcion` Varchar(32) NOT NULL,
  PRIMARY KEY (`id_bitacora`)
)
;

CREATE INDEX `IX_Relationship27` ON `bitacora` (`uuid`)
;

-- Table tienda

CREATE TABLE `tienda`
(
  `id_tienda` Int NOT NULL AUTO_INCREMENT,
  `tienda` Varchar(128) NOT NULL,
  PRIMARY KEY (`id_tienda`)
)
;

-- Table asigancion_tienda

CREATE TABLE `asigancion_tienda`
(
  `id_tienda` Int NOT NULL,
  `uuid` Varchar(32) NOT NULL
)
;

ALTER TABLE `asigancion_tienda` ADD PRIMARY KEY (`id_tienda`,`uuid`)
;

-- Table persona

CREATE TABLE `persona`
(
  `id_persona` Int NOT NULL AUTO_INCREMENT,
  `primernombre` Varchar(128) NOT NULL,
  `segundonombre` Varchar(128) NOT NULL,
  `primerapellido` Varchar(128) NOT NULL,
  `segundoapellido` Char(128) NOT NULL,
  `direccion` Varchar(256) NOT NULL,
  `nit` Varchar(16) NOT NULL,
  `telefono` Varchar(16) NOT NULL,
  PRIMARY KEY (`id_persona`)
)
;

-- Table rol

CREATE TABLE `rol`
(
  `id_rol` Int(11) NOT NULL AUTO_INCREMENT,
  `rol` Varchar(128) NOT NULL,
  PRIMARY KEY (`id_rol`)
)
;

-- Create foreign keys (relationships) section ------------------------------------------------- 


ALTER TABLE `compras` ADD CONSTRAINT `Relationship1` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `detallefactura` ADD CONSTRAINT `Relationship9` FOREIGN KEY (`id_factura`) REFERENCES `factura` (`id_factura`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `descripcion` ADD CONSTRAINT `Relationship11` FOREIGN KEY (`id_articulo`) REFERENCES `inventario` (`id_articulo`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `inventario` ADD CONSTRAINT `Relationship12` FOREIGN KEY (`id_tipo`) REFERENCES `tipo` (`id_tipo`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `detallefactura` ADD CONSTRAINT `Relationship13` FOREIGN KEY (`id_articulo`) REFERENCES `inventario` (`id_articulo`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `compras` ADD CONSTRAINT `Relationship14` FOREIGN KEY (`id_articulo`) REFERENCES `inventario` (`id_articulo`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `display` ADD CONSTRAINT `Relationship15` FOREIGN KEY (`identifier`) REFERENCES `ibeacoins` (`identifier`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `display` ADD CONSTRAINT `Relationship16` FOREIGN KEY (`id_tipo`) REFERENCES `tipo` (`id_tipo`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `asigancion_tienda` ADD CONSTRAINT `Relationship23` FOREIGN KEY (`id_tienda`) REFERENCES `tienda` (`id_tienda`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `asigancion_tienda` ADD CONSTRAINT `Relationship24` FOREIGN KEY (`uuid`) REFERENCES `usuario` (`uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `horario` ADD CONSTRAINT `Relationship25` FOREIGN KEY (`uuid`) REFERENCES `usuario` (`uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `factura` ADD CONSTRAINT `Relationship26` FOREIGN KEY (`uuid`) REFERENCES `usuario` (`uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `bitacora` ADD CONSTRAINT `Relationship27` FOREIGN KEY (`uuid`) REFERENCES `usuario` (`uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `inventario` ADD CONSTRAINT `Relationship28` FOREIGN KEY (`id_tienda`) REFERENCES `tienda` (`id_tienda`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `cliente` ADD CONSTRAINT `Relationship29` FOREIGN KEY (`id_cliente`) REFERENCES `persona` (`id_persona`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `factura` ADD CONSTRAINT `Relationship31` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `usuario` ADD CONSTRAINT `Relationship32` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id_persona`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `usuario` ADD CONSTRAINT `Relationship33` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


