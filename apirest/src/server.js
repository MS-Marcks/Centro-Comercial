import express from 'express'
import cors from 'cors'
import bodyparser from 'body-parser'
import helmet from 'helmet'
import bodyParser from 'body-parser';
import Routeadmin from './Config/router.admin'
import RouteUsuario from './Config/router.usuario'
import auth from './Tools/Middleware/auth';

const AUTHOptions = {
    UrlStart: "/session",
    ActiveTime: "5h",
    KEY_TOKEN: process.env.KEY_TOKEN_ADMIN,
    NameToken: "access-token",
    EncryptionMethod: "HS256"
}

const UserAUTHOptions = {
    UrlStart: "/session",
    ActiveTime: "5h",
    KEY_TOKEN: process.env.KEY_TOKEN_USER,
    NameToken: "access-token-user",
    EncryptionMethod: "HS256"
}


const app = express();

//app.use();
app.use(cors({ origin: "*" }))
app.use(helmet());
app.use(bodyparser.urlencoded({ extended: false }))
app.use(bodyParser.json())

app.get('/files/:img', function (req, res) {
    res.sendFile(`${__dirname.split('\\src')[0]}/files/${req.params.img}`);
});
app.use('/api/admin',auth(AUTHOptions), Routeadmin)
app.use('/api/usuario',auth(UserAUTHOptions), RouteUsuario)
/*app.use('api/cliente',Routeadmin)
app.use('api/sistema',Routeadmin)*/
const server = app.listen(process.env.PORT || 3000, () => {
    console.log(`http:localhost:${server.address().port}`)
})
