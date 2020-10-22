import { Router } from 'express'
import Controller from '../Controller'

const router = Router();

router.get("/:uuid/:estado", Controller.Search)


export default router;