import { Router } from 'express'
import Controller from '../Controller'

const router = Router();

router.post("/", Controller.Create)
router.get("/", Controller.Search)
router.put("/", Controller.Update)
router.delete("/:id", Controller.Delete)

export default router;