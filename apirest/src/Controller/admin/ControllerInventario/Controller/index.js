import Connect from '../../../../Config/Connect'
import mysql from 'mysql'

const server = 'http://localhost:3000/files/'
class ControllerInventario {
    static Create(req, res) {
        try {
            var body = JSON.parse(req.body.data);
            body.imagen = server + req.file.filename;
            var connection = mysql.createConnection(Connect);
            connection.connect((err) => {
                if (err) {
                    res.json({ mensaje: err.stack });
                    return;
                }
                console.log('connected as id ' + connection.threadId);
            });
            connection.query(`CALL sp_create_inventario(?,?,?,?,?,?)`, [body.id_tienda, body.id_tipo, body.articulo, body.descripcion, body.precio, body.imagen], function (error, results, fields) {
                if (error) { res.json(error) };
                connection.end();
                res.json("CREATED SUCCESFULY")
            });
        } catch (error) {
            res.json(error);
        }
    }
    static Search(req, res) {
        try {
            var connection = mysql.createConnection(Connect);
            connection.connect((err) => {
                if (err) {
                    res.json({ mensaje: err.stack });
                    return;
                }
                console.log('connected as id ' + connection.threadId);
            });
            connection.query("CALL sp_search_inventario", function (error, results, fields) {
                if (error) { res.json(error) };
                connection.end();
                res.json(results[0])
            });
        } catch (error) {
            res.json(error);
        }
    }

    static SearchSingle(req, res) {
        try {
            var connection = mysql.createConnection(Connect);
            connection.connect((err) => {
                if (err) {
                    res.json({ mensaje: err.stack });
                    return;
                }
                console.log('connected as id ' + connection.threadId);
            });
            connection.query("CALL sp_search_inventario_single (?)", [req.params.id], function (error, results, fields) {
                if (error) { res.json(error) };
                connection.end();
                res.json(results[0][0])
            });
        } catch (error) {
            res.json(error);
        }
    }
}
export default ControllerInventario;