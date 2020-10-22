DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_factura`(in puuid VARCHAR(32),in pid_cliente INTEGER(11),in pnit VARCHAR(10),in pdireccion VARCHAR(256))
BEGIN
	INSERT INTO factura (uuid,id_cliente,nit,direccion,fecha,estado) VALUES (puuid,pid_cliente,pnit,pdireccion,CURDATE(),'CREADA');
END $





DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_factura`(in pid_tienda INTEGER(11))
BEGIN
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
INNER JOIN persona AS p on p.id_cliente=p.id_persona 
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
END $


DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_factura_single`(in pid_tienda INTEGER(11), in pid_factura INTEGER(11))
BEGIN
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
END $


DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_change_status_factura`(in id INTEGER(11),in pestado VARCHAR(32))
BEGIN
	UPDATE factura set estado=pestado WHERE id_factura=id;
END $