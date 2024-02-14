import express,{Request,Response} from "express"
import { router } from "./routes";
import { mongoDBConnection } from "./database/data";


const app = express();
app.use(express.urlencoded({ extended: false}));
app.use(express.json());
mongoDBConnection();
app.use("/", router);


app.listen(8080,() => {
    console.log("Server is rocking at 8080");
})
