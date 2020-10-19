DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_persona`(in pprimernombre VARCHAR(128),in psegundonombre VARCHAR(128),in pprimerapellido VARCHAR(128),in psegundoapellido VARCHAR(128),in pdireccion VARCHAR(256),in pnit VARCHAR(16),in ptelefono VARCHAR(16))
BEGIN
	INSERT INTO persona (primernombre,segundonombre,primerapellido,segundoapellido,direccion,nit,telefono) VALUES (pprimernombre,psegundonombre,pprimerapellido,psegundoapellido,pdireccion,pnit,ptelefono);
END $

DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_persona`()
BEGIN
	SELECT id_persona,primernombre,segundonombre,primerapellido,segundoapellido,direccion,nit,telefono FROM persona;
END $


DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_persona_single`(in id INTEGER(11))
BEGIN
	SELECT id_persona,primernombre,segundonombre,primerapellido,segundoapellido,direccion,nit,telefono FROM persona WHERE id_persona=id;
END $
