import Connect from '../../../../Config/Connect'
import mysql from 'mysql'

class ControllerLogin {
    static Login(req, res) {
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
            connection.query(`CALL sp_session(?,?)`, [body.usuario, 1], function (error, results, fields) {
                if (error) { res.json(error) };
                connection.end();                
                try {
                    if(results[0][0].pass === body.pass){
                        res.json({token: req.GenerateToken(results[0][0])});
                    }else{
                        res.json("ERROR SIN ACCESO");
                    }
                } catch (error) {
                    res.json("ERROR SIN ACCESO");
                }                
            });
        } catch (error) {
            res.json(error);
        }
    }
}
export default ControllerLogin;