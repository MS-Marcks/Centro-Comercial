DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_tienda`(in ptienda VARCHAR(128))
BEGIN
	INSERT INTO tienda (tienda) VALUES (ptienda);
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_tienda`()
BEGIN
	SELECT id_tienda,tienda FROM tienda;
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_tienda_single`(in id INTEGER(11))
BEGIN
	SELECT id_tienda,tienda FROM tienda WHERE id_tienda=id;
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_tienda`(in pid_tienda INTEGER(11),in ptienda VARCHAR(128))
BEGIN
	UPDATE tienda SET tienda = ptienda WHERE id_tienda= pid_tienda;
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_tienda`(in id INTEGER(11))
BEGIN
	DELETE FROM tienda WHERE id_tienda=id;
END $