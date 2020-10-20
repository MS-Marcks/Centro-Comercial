DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_detalle`(in pid_factura INTEGER(11),in pid_articulo INTEGER(11),in pprecio FLOAT(10,2),pcantidad INTEGER(11))
BEGIN
	INSERT INTO detallefactura (id_factura,id_articulo,precio,cantidad) VALUES (pid_factura,pid_articulo,pprecio,pcantidad);
	SET @pstock= (SELECT stock FROM inventario WHERE id_articulo = pid_articulo);
	SET @pstock = @pstock-pcantidad;
	UPDATE inventario SET stock=@pstock WHERE id_articulo = pid_articulo;
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_detalle`(in pid_factura INTEGER(11))
BEGIN
	SELECT dt.*,i.articulo FROM detallefactura AS dt
	INNER JOIN factura AS f ON dt.id_factura=f.id_factura
	INNER JOIN inventario AS i ON dt.id_articulo=i.id_articulo
	WHERE f.id_factura=pid_factura;
END $


DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_detalle`(in pid_factura INTEGER(11),in pid_articulo INTEGER(11))
BEGIN
	SET @pcantidad= (SELECT cantidad FROM detallefactura WHERE id_factura=pid_factura AND id_articulo=pid_articulo);
	SET @pstock= (SELECT stock FROM inventario WHERE id_articulo = pid_articulo);
	SET @pstock = @pstock+@pcantidad;
	UPDATE inventario SET stock=@pstock WHERE id_articulo = pid_articulo;
	DELETE FROM detallefactura WHERE id_factura=pid_factura AND id_articulo=pid_articulo;
END $






