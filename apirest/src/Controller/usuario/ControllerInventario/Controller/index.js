import Connect from '../../../../Config/Connect'
import mysql from 'mysql'

class ControllerInventario {
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
            console.log('hollla');
            console.log(req.params);
            connection.query("CALL sp_search_producto (?,?)", [req.params.id_articulo,req.params.id_tienda], function (error, results, fields) {
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