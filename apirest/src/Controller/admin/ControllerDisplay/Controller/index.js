import Connect from '../../../../Config/Connect'
import mysql from 'mysql'

class ControllerDisplay {
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
            connection.query(`CALL sp_create_display(?,?)`, [body.identifier, body.id_tipo], function (error, results, fields) {
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
            connection.query("CALL sp_search_display", function (error, results, fields) {
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
            connection.query("CALL sp_delete_display (?,?) ", [req.params.identifier,req.params.id_tipo], function (error, results, fields) {
                if (error) { res.json(error) };
                connection.end();
                res.json("DELETE SUCCESFULY");
            });
        } catch (error) {
            res.json(error);
        }

    }
}
export default ControllerDisplay;