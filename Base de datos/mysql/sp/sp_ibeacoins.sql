DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_ibeacoins`(in pidentifier VARCHAR(128), in puuid VARCHAR(128),in pmajor INTEGER(11),in pminor INTEGER(11))
BEGIN
	INSERT INTO ibeacoins (identifier,uuid,major,minor) VALUES (pidentifier,puuid,pmajor,pminor);
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_ibeacoins`()
BEGIN
	SELECT identifier,uuid,major,minor FROM ibeacoins;
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_ibeacoins_single`(in id VARCHAR(128))
BEGIN
	SELECT identifier,uuid,major,minor FROM ibeacoins WHERE identifier= id;
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_ibeacoins`(in id VARCHAR(128), in puuid VARCHAR(128),in pmajor INTEGER(11),in pminor INTEGER(11))
BEGIN
	UPDATE ibeacoins SET uuid=puuid,major=pmajor,minor=pminor WHERE identifier= id;
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_ibeacoins`(in id VARCHAR(128))
BEGIN
	DELETE FROM ibeacoins WHERE identifier=id;
END $