DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_display`(in pidentifier VARCHAR(128),in pid_tipo INTEGER(11))
BEGIN
	INSERT INTO display (identifier,id_tipo) VALUES (pidentifier,pid_tipo);
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_display`()
BEGIN
	SELECT i.identifier,t.id_tipo,t.tipo FROM display AS d INNER JOIN tipo AS t ON d.id_tipo=t.id_tipo
    INNER JOIN ibeacoins AS i ON d.identifier=i.identifier;
END $


DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_display`(in id VARCHAR(128), in id1 INTEGER(11))
BEGIN
	DELETE FROM display WHERE identifier=id AND id_tipo=id1;
END $