import { Router } from 'express'
import Controller from '../Controller'
import multer from 'multer';
import mimeType from 'mime-types'
const router = Router();

const storage = multer.diskStorage({
    destination:'files/',
    filename: function(req,file,cb){
        cb("",Date.now()+file.originalname+"."+mimeType.extension(file.mimetype))
    }
})
const upload = multer({
    storage:storage
})

router.post("/",upload.single('articulo'), Controller.Create)
router.get("/", Controller.Search)

export default router;