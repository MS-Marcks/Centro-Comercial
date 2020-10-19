import { Router } from 'express'
import Controller from '../Controller'

const router = Router();

router.post("/", Controller.Create)
router.get("/", Controller.Search)
router.get("/:id", Controller.SearchSingle)

export default router;