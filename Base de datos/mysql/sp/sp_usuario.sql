DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_usuario`(in puuid VARCHAR(32),in pid_persona INTEGER(11),in pid_rol INTEGER(11),in pusuario VARCHAR(128),in ppass VARCHAR(128))
BEGIN
    INSERT INTO usuario (uuid,id_persona,id_rol,usuario,pass) VALUES (puuid,pid_persona,pid_rol,pusuario,ppass);
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_usuario`()
BEGIN
	SELECT r.rol,u.uuid,p.id_persona,p.primernombre,p.segundonombre,p.primerapellido,p.segundoapellido,p.direccion,p.nit,p.telefono,u.usuario FROM persona AS p INNER JOIN usuario AS u ON p.id_persona =u.id_persona INNER JOIN rol AS r.id_rol=u.id_rol;
END $
