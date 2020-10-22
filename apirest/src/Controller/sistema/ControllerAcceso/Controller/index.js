import Connect from '../../../../Config/Connect'
import mysql from 'mysql'
import firebase from 'firebase';


var firebaseConfig = {
    apiKey: "AIzaSyDBuDTXG7uvJ8H8pdyr1a17TicYARdPENI",
    authDomain: "centro-comercial-617c3.firebaseapp.com",
    databaseURL: "https://centro-comercial-617c3.firebaseio.com",
    projectId: "centro-comercial-617c3",
    storageBucket: "centro-comercial-617c3.appspot.com",
    messagingSenderId: "985241840863",
    appId: "1:985241840863:web:573ccb0d25faeace074d6a"
};
firebase.initializeApp(firebaseConfig);
class ControllerTipo {
    static Search(req, res) {
        try {
            var body = req.params;
            var connection = mysql.createConnection(Connect);
            connection.connect((err) => {
                if (err) {
                    res.json({ mensaje: err.stack });
                    return;
                }
                console.log('connected as id ' + connection.threadId);
            });
            connection.query("CALL sp_horario_usuario (?)", [body.uuid], function (error, results, fields) {
                if (error) { res.json(error) };
                try {
                    var f = new Date();
                    var datos = results[0][0];
                    let entrada = f.getFullYear() + "/" + (f.getMonth() + 1) + "/" + f.getDate() + ' ' + results[0][0].hora_entrada;
                    let salida = f.getFullYear() + "/" + (f.getMonth() + 1) + "/" + f.getDate() + ' ' + results[0][0].hora_salida;
                    let hora_actual = f.getFullYear() + "/" + (f.getMonth() + 1) + "/" + f.getDate() + ' ' + f.getHours() + ":" + f.getMinutes();
                    if (body.estado === "1") {
                        var fecha_horario_entrada = new Date(entrada);
                        var fecha_entrada = new Date(hora_actual);
                        var descripcion = "";
                        if (fecha_entrada <= fecha_horario_entrada) {
                            descripcion = "a tiempo";
                        } else {
                            descripcion = "retraso";
                        }

                    } else if (body.estado === "2") {
                        descripcion = "Regreso o regresara";
                    } else if (body.estado === "3") {
                        var fecha_horario_entrada = new Date(salida);
                        var fecha_entrada = new Date(hora_actual);
                        if (fecha_entrada >= fecha_horario_entrada) {
                            descripcion = "Salido a tiemdo";
                        } else {
                            descripcion = "Salio antes";
                        }
                    }
                    connection.query("CALL sp_create_bitacora (?,?,?)", [body.uuid, body.estado, descripcion], function (error, results, fields) {
                        if (error) { res.json(error) };
                        connection.end();
                        firebase.database().ref('usuario/' + body.uuid).push(
                            {
                                uuid: body.uuid,
                                estado: body.estado,
                                nombre: datos.primernombre,
                                apellido: datos.primerapellido,
                                hora: hora_actual,
                                descripcion: descripcion
                            }
                        )
                        res.json("CREATED SUCCESFULLY")

                    });
                } catch (error) {
                    res.json("no existe");
                }

            });
        } catch (error) {
            res.json(error);
        }
    }
}
export default ControllerTipo;