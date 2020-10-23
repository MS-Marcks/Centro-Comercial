import express from 'express'
import cors from 'cors'
import bodyparser from 'body-parser'
import helmet from 'helmet'
import bodyParser from 'body-parser';
import Routeadmin from './Config/router.admin'
import RouteUsuario from './Config/router.usuario'
import RotueCliente from './Config/router.cliente'
import RouteSistema from './Config/router.sistema'
import auth from './Tools/Middleware/auth';
import morgan from 'morgan';

const AUTHOptions = {
    UrlStart: "/session",
    ActiveTime: "5h",
    KEY_TOKEN: (typeof process.env.KEY_TOKEN_ADMIN !== 'undefined') ? process.env.KEY_TOKEN_ADMIN : 'wbuekAFw(zQg(jyh9z@3lcURZfx7Be*pHFb)8tIcY$%YzKQ_OcehLR*%CC$9jbu9aJ7%q9pQ1ddb&$yUEm!F@J+Yux(rkWnrdtBf34S8Xi)fF2v5Rr*3kE3wV9i$hb_A',
    NameToken: "access-token",
    EncryptionMethod: "HS256"
}

const UserAUTHOptions = {
    UrlStart: "/session",
    ActiveTime: "5h",
    KEY_TOKEN: (typeof process.env.KEY_TOKEN_USER !== 'undefined') ? process.env.KEY_TOKEN_USER : 'smJYEKn0Bh!KGrL8e8O96QSJtmpMR)i6wiWBonee4R&0Jw&Xdj5ISkFknyCpT!ln56N0J#tuWNKtAXRXm0st)kYpQeMUf%aTHJU)P3mXCGiyk#xg763DslWgMZQ%28is',
    NameToken: "access-token-user",
    EncryptionMethod: "HS256"
}


const app = express();
app.use(morgan('combined'))
app.use(cors({ origin: "*" }))
app.use(helmet());
app.use(bodyparser.urlencoded({ extended: false }))
app.use(bodyParser.json())

app.get('/files/:img', function (req, res) {
    res.sendFile(`${__dirname.split('\\src')[0]}/files/${req.params.img}`);
});
app.use('/api/admin', auth(AUTHOptions), Routeadmin)
app.use('/api/usuario', auth(UserAUTHOptions), RouteUsuario)
app.use('/api/cliente', RotueCliente)
app.use('/api/sistema', RouteSistema)

const server = app.listen(process.env.PORT || 3000, () => {
    console.log(`http:localhost:${server.address().port}`)
})
