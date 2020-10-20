import Connect from '../../../../Config/Connect'
import mysql from 'mysql'

class ControllerTipo {
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
            console.log(body);
            connection.query(`CALL sp_create_factura(?,?,?,?)`, [body.uuid, body.id_cliente, body.nit, body.direccion], function (error, results, fields) {
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
            connection.query("CALL sp_search_factura (?)", [req.params.id], function (error, results, fields) {
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
            connection.query("CALL sp_search_factura_single (?,?)", [req.params.id_tienda, req.params.id_factura], function (error, results, fields) {
                if (error) { res.json(error) };
                connection.end();
                res.json(results[0][0])
            });
        } catch (error) {
            res.json(error);
        }
    }
    static Update(req, res) {
        try {
            var connection = mysql.createConnection(Connect);
            connection.connect((err) => {
                if (err) {
                    res.json({ mensaje: err.stack });
                    return;
                }
                console.log('connected as id ' + connection.threadId);
            });
            connection.query("CALL sp_change_status_factura (?,?) ", [req.params.id_factura, req.params.estado], function (error, results, fields) {
                if (error) { res.json(error) };
                connection.end();
                res.json("UPDATED STATUS SUCCESFULY")
            });
        } catch (error) {
            res.json(error);
        }
    }
    static Delete(req, res) {
        try {
            var id = req.params.id
            var connection = mysql.createConnection(Connect);
            connection.connect((err) => {
                if (err) {
                    res.json({ mensaje: err.stack });
                    return;
                }
                console.log('connected as id ' + connection.threadId);
            });
            connection.query("CALL sp_change_status_factura (?,?) ", [id, 'ANULADA'], function (error, results, fields) {
                if (error) { res.json(error) };
                connection.end();
                res.json("DELETE SUCCESFULY");
            });
        } catch (error) {
            res.json(error);
        }

    }
}
export default ControllerTipo;