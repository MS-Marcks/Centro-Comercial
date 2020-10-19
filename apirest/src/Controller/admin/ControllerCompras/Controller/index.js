import Connect from '../../../../Config/Connect'
import mysql from 'mysql'

class ControllerCompra {
    static Create(req, res) {
        try {
            var body = req.body;
            var connection = mysql.createConnection(Connect);
            connection.connect((err) => {
                if (err) {
                    res.json({ mensaje: err.stack });
                    return;
                }
                console.log('connected as id ' + connection.threadId);
            });
            connection.query(`CALL sp_create_compra(?,?,?,?)`, [body.id_proveedor, body.id_articulo, body.cantidad, body.precio], function (error, results, fields) {
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
            connection.query("CALL sp_search_compra", function (error, results, fields) {
                if (error) { res.json(error) };
                connection.end();
                res.json(results[0])
            });
        } catch (error) {
            res.json(error);
        }
    }
}
export default ControllerCompra;