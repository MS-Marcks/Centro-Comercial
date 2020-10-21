import { Router } from 'express'

import ControllerIbeacoins from '../Controller/cliente/ControllerIbeacoins/route'
import ControllerLogin from '../Controller/cliente/ControllerLogin/route'
import ControllerTipo from '../Controller/cliente/ControllerTipo/route'
import ControllerProducto from '../Controller/cliente/ControllerProducto/route'


var route = Router();

route.use('/session', ControllerLogin)
route.use('/ibeacoins', ControllerIbeacoins)
route.use('/tipo', ControllerTipo)
route.use('/producto', ControllerProducto)

export default route;
