import { Router } from 'express'
import Controller from '../Controller'

const router = Router();

router.post("/", Controller.Login)

export default router;