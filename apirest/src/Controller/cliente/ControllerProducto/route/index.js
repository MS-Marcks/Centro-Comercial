import { Router } from 'express'
import Controller from '../Controller'

const router = Router();

router.get("/:id", Controller.Search)

export default router;