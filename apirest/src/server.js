import express from 'express'
import cors from 'cors'
import bodyparser from 'body-parser'
import helmet from 'helmet'
import bodyParser from 'body-parser';
import Routeadmin from './Config/router.admin'
const app = express();
app.use(cors({ origin: "*" }))
app.use(helmet());
app.use(bodyparser.urlencoded({ extended: false }))
app.use(bodyParser.json())

app.use('/api/admin', Routeadmin)

/*app.use('api/usuario',Routeadmin)
app.use('api/cliente',Routeadmin)
app.use('api/sistema',Routeadmin)*/
const server = app.listen(process.env.PORT || 3000, () => {
    console.log(`http:localhost:${server.address().port}`)
})
