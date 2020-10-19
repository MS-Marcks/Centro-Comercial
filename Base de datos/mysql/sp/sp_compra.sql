DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_compra`(in pid_proveedor INTEGER(11),in pid_articulo INTEGER(11),in pcantidad INTEGER(11),in pprecio FLOAT(10,2))
BEGIN
	INSERT INTO compras (id_proveedor,id_articulo,cantidad,precio) VALUES (pid_proveedor,pid_articulo,pcantidad,pprecio);
	SET @pstock= (SELECT stock FROM inventario WHERE id_articulo = pid_articulo);
	SET @pstock = @pstock+pcantidad;
	UPDATE inventario SET stock=@pstock WHERE id_articulo = pid_articulo;
END $


DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_compra`()
BEGIN
	SELECT c.id_compra,c.id_proveedor,p.razonsocial AS proveedor,c.id_articulo,i.articulo,c.cantidad,c.precio,(c.cantidad*c.precio) AS total FROM compras AS c 
	INNER JOIN proveedor AS p ON c.id_proveedor=p.id_proveedor
	INNER JOIN inventario AS i ON i.id_articulo=c.id_articulo;
END $