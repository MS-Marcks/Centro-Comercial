DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_rol`(in prol VARCHAR(128))
BEGIN
	INSERT INTO rol (rol) VALUES (prol);
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_rol`()
BEGIN
	SELECT id_rol,rol FROM rol;
END $


DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_rol_single`(in id INTEGER(11))
BEGIN
	SELECT id_rol,rol FROM rol WHERE id_rol=id;
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_rol`(in pid_rol INTEGER(11),in prol VARCHAR(128))
BEGIN
	UPDATE rol SET rol = prol WHERE id_rol= pid_rol;
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_rol`(in id INTEGER(11))
BEGIN
	DELETE FROM rol WHERE id_rol=id;
END $