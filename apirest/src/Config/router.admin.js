import { Router } from 'express'
import ControllerTipo from '../Controller/admin/ControllerTipo/route'
import ControllerTienda from '../Controller/admin/ControllerTienda/route'
import ControllerProveedor from '../Controller/admin/ControllerProveedor/route'
import ControllerRol from '../Controller/admin/ControllerRol/route'
import ControllerIbeacoins from '../Controller/admin/ControllerIbeacoins/route'
import ControllerDisplay from '../Controller/admin/ControllerDisplay/route'
import ControllerPersona from '../Controller/admin/ControllerPersona/route'
import ControllerCliente from '../Controller/admin/ControllerCliente/route'
import ControllerUsuario from '../Controller/admin/ControllerUsuario/route'
import ControllerHorario from '../Controller/admin/ControllerHorario/route'
import ControllerDescripcion from '../Controller/admin/ControllerDescripcion/route'
import ControllerInventario from '../Controller/admin/ControllerInventario/route'
var route = Router();

route.use('/tipoproducto', ControllerTipo)
route.use('/tienda', ControllerTienda)
route.use('/proveedor', ControllerProveedor)
route.use('/rol', ControllerRol)
route.use('/ibeacoins', ControllerIbeacoins)
route.use('/display', ControllerDisplay)
route.use('/persona', ControllerPersona)
route.use('/cliente', ControllerCliente)
route.use('/usuario', ControllerUsuario)
route.use('/horario', ControllerHorario)
route.use('/descripcion', ControllerDescripcion)
route.use('/inventario', ControllerInventario)

export default route;
