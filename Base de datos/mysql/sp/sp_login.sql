
DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_session`(in pusuario VARCHAR(128),in pid_rol INTEGER(11))
BEGIN
	SELECT * FROM usuario WHERE usuario=pusuario AND id_rol = pid_rol;
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_session_usuario`(in pusuario VARCHAR(128),in pid_rol INTEGER(11))
BEGIN
	SELECT u.*,t.* FROM usuario AS u INNER JOIN asigancion_tienda AS ast ON u.uuid=ast.uuid INNER JOIN tienda AS t ON t.id_tienda=ast.id_tienda WHERE u.usuario=pusuario AND u.id_rol = pid_rol;
END $

