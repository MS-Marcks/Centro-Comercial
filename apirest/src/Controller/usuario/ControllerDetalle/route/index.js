import { Router } from 'express'
import Controller from '../Controller'

const router = Router();

router.post("/", Controller.Create)
router.get("/:id", Controller.Search)
router.delete("/:id_factura/:id_articulo", Controller.Delete)

export default router;