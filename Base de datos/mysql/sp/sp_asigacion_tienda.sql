DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_asigancion_tienda`(in pid_tipo INTEGER(11),in puuid VARCHAR(32))
BEGIN
	INSERT INTO asigancion_tienda (id_tienda,uuid) VALUES (pid_tipo,puuid);
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_asigancion_tienda`()
BEGIN
	SELECT ast.*,u.usuario,t.tienda FROM asigancion_tienda AS ast INNER JOIN tienda AS t ON ast.id_tienda=t.id_tienda
    INNER JOIN usuario AS u ON ast.uuid=u.uuid;
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_asigancion_tienda`(in id INTEGER(11), in id1 VARCHAR(11))
BEGIN
	DELETE FROM asigancion_tienda WHERE id_tienda=id AND puuid=id1;
END $