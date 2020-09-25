/*
Created: 23/07/2020
Modified: 14/09/2020
Model: MySQL 5.7
Database: MySQL 5.7
*/


-- Create tables section -------------------------------------------------

-- Table factura

CREATE TABLE `factura`
(
  `id_factura` Int NOT NULL AUTO_INCREMENT,
  `id_cliente` Int NOT NULL,
  `id_usuario` Int,
  `nit` Varchar(10) NOT NULL,
  `direccion` Varchar(256) NOT NULL,
  `fecha` Date NOT NULL,
  PRIMARY KEY (`id_factura`)
)
;

CREATE INDEX `IX_Relationship5` ON `factura` (`id_cliente`)
;

CREATE INDEX `IX_Relationship17` ON `factura` (`id_usuario`)
;

-- Table cliente

CREATE TABLE `cliente`
(
  `id_cliente` Int NOT NULL AUTO_INCREMENT,
  `nit` Varchar(10) NOT NULL,
  `nombre` Varchar(256) NOT NULL,
  `direccion` Varchar(256) NOT NULL,
  `telefono` Varchar(10) NOT NULL,
  `clave` Varchar(32) NOT NULL,
  PRIMARY KEY (`id_cliente`)
)
;

-- Table inventario

CREATE TABLE `inventario`
(
  `id_articulo` Int NOT NULL AUTO_INCREMENT,
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
  `id_usuario` Int NOT NULL AUTO_INCREMENT,
  `usuario` Varchar(128) NOT NULL,
  `pass` Varchar(128) NOT NULL,
  PRIMARY KEY (`id_usuario`)
)
;

-- Table horario

CREATE TABLE `horario`
(
  `id_horario` Int NOT NULL AUTO_INCREMENT,
  `id_usuario` Int NOT NULL,
  `hora_entrada` Varchar(20) NOT NULL,
  `hora_salida` Varchar(20) NOT NULL,
  PRIMARY KEY (`id_horario`)
)
;

CREATE INDEX `IX_Relationship19` ON `horario` (`id_usuario`)
;

-- Table bitacora

CREATE TABLE `bitacora`
(
  `id_bitacora` Int NOT NULL AUTO_INCREMENT,
  `id_usuario` Int,
  `hora` Varchar(20) NOT NULL,
  `estado` Varchar(8) NOT NULL,
  `descripcion` Varchar(16) NOT NULL,
  PRIMARY KEY (`id_bitacora`)
)
;

CREATE INDEX `IX_Relationship20` ON `bitacora` (`id_usuario`)
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
  `id_usuario` Int NOT NULL,
  `id_tienda` Int NOT NULL
)
;

ALTER TABLE `asigancion_tienda` ADD PRIMARY KEY (`id_usuario`,`id_tienda`)
;

-- Create foreign keys (relationships) section ------------------------------------------------- 


ALTER TABLE `compras` ADD CONSTRAINT `Relationship1` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `factura` ADD CONSTRAINT `Relationship5` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE RESTRICT ON UPDATE RESTRICT
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


ALTER TABLE `factura` ADD CONSTRAINT `Relationship17` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `horario` ADD CONSTRAINT `Relationship19` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `bitacora` ADD CONSTRAINT `Relationship20` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `asigancion_tienda` ADD CONSTRAINT `Relationship22` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `asigancion_tienda` ADD CONSTRAINT `Relationship23` FOREIGN KEY (`id_tienda`) REFERENCES `tienda` (`id_tienda`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


