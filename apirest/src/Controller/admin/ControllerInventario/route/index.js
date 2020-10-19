import { Router } from 'express'
import Controller from '../Controller'
import multer from 'multer';
import mimeType from 'mime-types'
const router = Router();

//const upload = (req,res,next)=>{}
const storage = multer.diskStorage({
    destination:'files/',
    filename: function(req,file,cb){
        const fil = Date.now()+file.originalname+"."+mimeType.extension(file.mimetype);
        console.log(req.body);
        cb("",fil)
    }
})
const upload = multer({
    storage:storage
})

router.post("/",upload.single('articulo'), Controller.Create)
router.get("/", Controller.Search)
router.get("/:id", Controller.SearchSingle)

export default router;