import { Router } from 'express'
import Controller from '../Controller'

const router = Router();

router.get("/:id_articulo/:id_tienda", Controller.SearchSingle)

export default router;