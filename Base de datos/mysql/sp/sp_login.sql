
DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_session`(in pusuario VARCHAR(128),in pid_rol INTEGER(11))
BEGIN
	SELECT * FROM usuario WHERE usuario=pusuario AND id_rol = pid_rol;
END $

