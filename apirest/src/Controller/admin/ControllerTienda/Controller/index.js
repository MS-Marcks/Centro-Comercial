import Connect from '../../../../Config/Connect'
import mysql from 'mysql'

class ControllerTienda {
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
            connection.query(`CALL sp_create_tienda(?)`,[body.tienda], function (error, results, fields) {
                if (error) {res.json(error) };
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
            connection.query("CALL sp_search_tienda", function (error, results, fields) {
                if (error) { res.json(error) };
                connection.end();
                res.json(results[0])
            });
        } catch (error) {
            res.json(error);
        }


    }
    
    static Update(req, res) {
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
            connection.query("CALL sp_update_tienda (?,?) ", [body.id_tienda, body.tienda], function (error, results, fields) {
                if (error) { res.json(error) };
                connection.end();
                res.json("UPDATED SUCCESFULY")
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
            connection.query("CALL sp_delete_tienda (?) ", [id], function (error, results, fields) {
                if (error) { res.json(error) };
                connection.end();
                res.json("DELETE SUCCESFULY");
            });
        } catch (error) {
            res.json(error);
        }

    }
}
export default ControllerTienda;