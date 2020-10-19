DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_inventario`(in pid_tienda INTEGER(11),in pid_tipo INTEGER(11),in particulo VARCHAR(128),in pdescripcion VARCHAR(128),in pprecio FLOAT(10,2), in pimagen VARCHAR(128))
BEGIN
	INSERT INTO inventario (id_tienda,id_tipo,articulo,descripcion,precio,stock,imagen) VALUES (pid_tienda,pid_tipo,particulo,pdescripcion,pprecio,0,pimagen);
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_inventario`()
BEGIN
	SELECT id_tienda,id_tipo,articulo,descripcion,precio,stock,imagen FROM inventario;
END $
