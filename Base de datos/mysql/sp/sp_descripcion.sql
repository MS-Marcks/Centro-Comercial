DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_descripcion`(in pid_articulo INTEGER(11),in pdescripcion VARCHAR(128))
BEGIN
	INSERT INTO descripcion (id_articulo,descripcion) VALUES (pid_articulo,pdescripcion);
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_descripcion`()
BEGIN
	SELECT id_descripcion,i.id_articulo,i.articulo,descripcion FROM descripcion AS d INNER JOIN inventario AS i ON d.id_articulo=i.id_articulo;
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_descripcion`(in pid_articulo INTEGER(11),in id INTEGER(11),in pdescripcion VARCHAR(128))
BEGIN
	UPDATE descripcion SET id_articulo=pid_articulo, descripcion = pdescripcion WHERE id_descripcion= id;
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_descripcion`(in id INTEGER(11))
BEGIN
	DELETE FROM descripcion WHERE id_descripcion=id;
END $