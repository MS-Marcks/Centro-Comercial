import { Router } from 'express'
import ControllerCliente from '../Controller/usuario/ControllerCliente/route'
import ControllerLogin from '../Controller/usuario/ControllerLogin/route'
import ControllerFactura from '../Controller/usuario/ControllerFactura/route'
import ControllerInventario from '../Controller/usuario/ControllerInventario/route'
import ControllerDetalle from '../Controller/usuario/ControllerDetalle/route'

var route = Router();
route.use('/cliente', ControllerCliente)
route.use('/factura', ControllerFactura)
route.use('/producto', ControllerInventario)
route.use('/detalle', ControllerDetalle)
route.use('/session', ControllerLogin)

export default route;