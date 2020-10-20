import { Router } from 'express'
import ControllerCliente from '../Controller/admin/ControllerCliente/route'

var route = Router();
route.use('/cliente', ControllerCliente)

export default route;