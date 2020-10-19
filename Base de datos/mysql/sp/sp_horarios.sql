DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_horario`(in puuid VARCHAR(32),in phora_entrada VARCHAR(20),in phora_salida  VARCHAR(20))
BEGIN
	INSERT INTO horario (uuid,hora_entrada,hora_salida) VALUES (puuid,phora_entrada,phora_salida);
    
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_horario`()
BEGIN
	SELECT h.*,u.usuario FROM horario AS h INNER JOIN usuario AS u ON h.uuid=u.uuid;
END $


DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_horario`(in pid_horario INTEGER(11),in phora_entrada VARCHAR(20),in phora_salida VARCHAR(20))
BEGIN
	UPDATE horario SET hora_entrada=hora_entrada,hora_salida=hora_salida WHERE id_horario= pid_horario;
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_horario`(in id INTEGER(11))
BEGIN
	DELETE FROM horario WHERE id_horario=id;
END $