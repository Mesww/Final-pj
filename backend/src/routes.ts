import express, {Request, Response} from "express"

const router = express.Router()
 
router.get("/",(req: Request, res: Response) =>{
    res.json({
        message: "API IS Fucking kuy"
    });
});

router.post("/",(req: Request, res: Response) =>{
    const {name,email} = req.body;
    console.log(name);
    console.log(email);
    res.json({
        user: {
            name,email
        }
    });
});

router.get("/about",(req: Request, res: Response) =>{
    res.json({
        message: "This is About page"
    });
});

router.get("/profile",(req: Request, res: Response) =>{
    res.json({
        message: "This is Profile page"
    });
});

export { router }