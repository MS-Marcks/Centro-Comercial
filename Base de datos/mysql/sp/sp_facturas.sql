DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_factura`(in puuid VARCHAR(32),in pid_cliente INTEGER(11),in pnit VARCHAR(10),in pdireccion VARCHAR(256))
BEGIN
	INSERT INTO tipo (uuid,id_cliente,nit,direccion,fecha,estado) VALUES (puuid,pid_cliente,pnit,pdireccion,GETDATE(),'CREADA');
END $





DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_factura`()
BEGIN
	SELECT id_tipo,tipo FROM tipo;
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_tipo_single`(in id INTEGER(11))
BEGIN
	SELECT id_tipo,tipo FROM tipo WHERE id_tipo=id;
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_tipo`(in pid_tipo INTEGER(11),in ptipo VARCHAR(128))
BEGIN
	UPDATE tipo SET tipo = ptipo WHERE id_tipo= pid_tipo;
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_tipo`(in id INTEGER(11))
BEGIN
	DELETE FROM tipo WHERE id_tipo=id;
END $