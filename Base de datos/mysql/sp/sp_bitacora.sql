DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_bitacora`(in puuid VARCHAR(32),in pestado VARCHAR(32),in pdescripcion VARCHAR(32))
BEGIN
	INSERT INTO bitacora (uuid,hora,estado,descripcion) VALUES (puuid,CURDATE(),pestado,pdescripcion);
END $