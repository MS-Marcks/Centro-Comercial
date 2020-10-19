DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_tipo`(in ptipo VARCHAR(128))
BEGIN
	INSERT INTO tipo (tipo) VALUES (ptipo);
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_tipo`()
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