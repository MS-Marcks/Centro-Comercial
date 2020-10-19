DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_proveedor`(in pproveedor VARCHAR(128))
BEGIN
	INSERT INTO proveedor (razonsocial) VALUES (pproveedor);
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_proveedor`()
BEGIN
	SELECT id_proveedor,razonsocial AS proveedor FROM proveedor;
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_proveedor`(in pid_proveedor INTEGER(11),in pproveedor VARCHAR(128))
BEGIN
	UPDATE proveedor SET razonsocial = pproveedor WHERE id_proveedor= pid_proveedor;
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_proveedor`(in id INTEGER(11))
BEGIN
	DELETE FROM proveedor WHERE id_proveedor=id;
END $