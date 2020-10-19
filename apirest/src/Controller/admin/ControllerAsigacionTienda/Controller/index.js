import Connect from '../../../../Config/Connect'
import mysql from 'mysql'

class ControllerPersona {
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
            connection.query(`CALL sp_create_asigancion_tienda(?,?)`, [body.id_tienda, body.uuid], function (error, results, fields) {
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
            connection.query("CALL sp_search_asigancion_tienda", function (error, results, fields) {
                if (error) { res.json(error) };
                connection.end();
                res.json(results[0])
            });
        } catch (error) {
            res.json(error);
        }
    }

    static Delete(req, res) {
        try {
            var connection = mysql.createConnection(Connect);
            connection.connect((err) => {
                if (err) {
                    res.json({ mensaje: err.stack });
                    return;
                }
                console.log('connected as id ' + connection.threadId);
            });
            console.log(req.params)
            connection.query("CALL sp_delete_asigancion_tienda (?,?)", [req.params.id_tienda, req.params.uuid], function (error, results, fields) {
                if (error) { console.log(error); res.json(error) };
                connection.end();
                res.json("DELETED SUCCESFULY");
            });
        } catch (error) {
            res.json(error);
        }
    }
}
export default ControllerPersona;