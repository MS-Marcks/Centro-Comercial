import { Router } from 'express'
import Controller from '../Controller'

const router = Router();

router.post("/", Controller.Create)
router.get("/:id", Controller.Search)
router.get("/:id_tienda/:id_factura", Controller.SearchSingle)
router.patch("/estado/:id_factura/:estado", Controller.Update)
router.delete("/:id", Controller.Delete)
/*router.get("/", Controller.Search)
router.put("/", Controller.Update)
*/

export default router;