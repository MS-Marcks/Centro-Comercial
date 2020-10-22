import { Router } from 'express'
import ControllerAcceso from '../Controller/sistema/ControllerAcceso/route'


var route = Router();

route.use('/acceso', ControllerAcceso)

export default route;