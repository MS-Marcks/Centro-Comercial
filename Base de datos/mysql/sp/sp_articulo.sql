DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_inventario`(in pid_tienda INTEGER(11),in pid_tipo INTEGER(11),in particulo VARCHAR(128),in pdescripcion VARCHAR(128),in pprecio FLOAT(10,2), in pimagen VARCHAR(128))
BEGIN
	INSERT INTO inventario (id_tienda,id_tipo,articulo,descripcion,precio,stock,imagen) VALUES (pid_tienda,pid_tipo,particulo,pdescripcion,pprecio,0,pimagen);
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_inventario`()
BEGIN
	SELECT i.id_articulo,i.id_tienda,t.tienda,i.id_tipo,tp.tipo,i.articulo,i.descripcion,i.precio,i.stock,i.imagen FROM inventario AS i
	INNER JOIN tienda AS t ON t.id_tienda=i.id_tienda
	INNER JOIN tipo AS tp ON tp.id_tipo=i.id_tipo;
END $



DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_inventario_single`(in id INTEGER(11))
BEGIN
	SELECT i.id_articulo,i.id_tienda,t.tienda,i.id_tipo,tp.tipo,i.articulo,i.descripcion,i.precio,i.stock,i.imagen FROM inventario AS i
	INNER JOIN tienda AS t ON t.id_tienda=i.id_tienda
	INNER JOIN tipo AS tp ON tp.id_tipo=i.id_tipo WHERE i.id_articulo=id;
END $