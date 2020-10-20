DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_cliente`(in pprimernombre VARCHAR(128),in psegundonombre VARCHAR(128),in pprimerapellido VARCHAR(128),in psegundoapellido VARCHAR(128),in pdireccion VARCHAR(256),in pnit VARCHAR(16),in ptelefono VARCHAR(16))
BEGIN
	INSERT INTO persona (primernombre,segundonombre,primerapellido,segundoapellido,direccion,nit,telefono) VALUES (pprimernombre,psegundonombre,pprimerapellido,psegundoapellido,pdireccion,pnit,ptelefono);
    SET @id_cliente = (SELECT id_persona FROM persona ORDER BY id_persona DESC LIMIT 1);
    INSERT INTO cliente (id_cliente,usuario,clave) VALUES (@id_cliente,pnit,pnit);
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_cliente`()
BEGIN
	SELECT p.id_persona,p.primernombre,p.segundonombre,p.primerapellido,p.segundoapellido,p.direccion,p.nit,p.telefono,c.usuario FROM persona AS p INNER JOIN cliente AS c ON p.id_persona =c.id_cliente;
END $


DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_cliente_single`(in pid_cliente VARCHAR(32))
BEGIN
	SELECT p.id_persona,p.primernombre,p.segundonombre,p.primerapellido,p.segundoapellido,p.direccion,p.nit,p.telefono,c.usuario FROM persona AS p INNER JOIN cliente AS c ON p.id_persona =c.id_cliente WHERE p.nit=pid_cliente;
END $
