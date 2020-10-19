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
            connection.query(`CALL sp_create_proveedor(?)`,[body.proveedor], function (error, results, fields) {
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
            connection.query("CALL sp_search_proveedor", function (error, results, fields) {
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
            connection.query("CALL sp_search_proveedor_single (?)",[req.params.id], function (error, results, fields) {
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
            var body = req.body;
            var connection = mysql.createConnection(Connect);
             connection.connect((err) => {
              if (err) {
                 res.json({ mensaje: err.stack });
                return;
              }
              console.log('connected as id ' + connection.threadId);
            });
            connection.query("CALL sp_update_proveedor (?,?) ", [body.id_proveedor, body.proveedor], function (error, results, fields) {
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
            connection.query("CALL sp_delete_proveedor (?) ", [id], function (error, results, fields) {
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