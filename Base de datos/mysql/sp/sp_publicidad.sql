DELIMITER $$
--
-- Procedimientos
--


DELIMITER $
CREATE  PROCEDURE `sp_seach_articulos` (IN `id` INTEGER(11))  BEGIN
    SELECT i.imagen,de.descripcion,t.id_tipo,t.tipo FROM cliente AS c JOIN factura AS f ON c.id_cliente = f.id_cliente
    INNER JOIN detallefactura as ds ON ds.id_factura = f.id_factura
    INNER JOIN inventario AS i ON i.id_articulo = ds.id_articulo
    INNER JOIN tipo AS t ON t.id_tipo=i.id_tipo
    INNER JOIN descripcion AS de ON de.id_articulo= i.id_articulo
    WHERE c.id_cliente = id ORDER BY ds.cantidad DESC LIMIT 1;
END$


DELIMITER $
CREATE  PROCEDURE `sp_search_ibeacoins_cliente` () 
BEGIN
	SELECT * FROM ibeacoins;
END$

DELIMITER $ 
CREATE  PROCEDURE `sp_search_tipo_cliente` ()  BEGIN
	SELECT distinct  ib.identifier,t.id_tipo FROM ibeacoins AS ib INNER JOIN display AS di ON ib.identifier=di.identifier
	INNER JOIN tipo AS t ON t.id_tipo=di.id_tipo;
END$