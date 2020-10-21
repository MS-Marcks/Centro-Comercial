import { Router } from 'express'
import Controller from '../Controller'

const router = Router();

router.post("/:usuario/:pass", Controller.Login)

export default router;