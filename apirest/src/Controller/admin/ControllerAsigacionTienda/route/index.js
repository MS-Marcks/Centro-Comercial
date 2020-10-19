import { Router } from 'express'
import Controller from '../Controller'

const router = Router();

router.post("/", Controller.Create)
router.get("/", Controller.Search)
router.delete("/:id_tienda/:uuid", Controller.Delete)

export default router;
