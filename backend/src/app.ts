import express,{Request,Response} from "express"
import { router } from "./routes/routes";
//import { mongoDBConnection } from "./database/data";
import mongoose from "mongoose";
import dotenv from "dotenv";

dotenv.config();


const app = express();
app.use(express.urlencoded({ extended: false}));
app.use(express.json());

try {
    if (!process.env.MONGODB_URL) {
      throw new Error("MONGODB_URL environment variable is not set!"); // Explicit error for clarity
    }
    mongoose.connect(process.env.MONGODB_URL as string);
    console.log("DB Connected!");

  } catch (err) {
    console.error(`Error details: ${err}`);
  }
  

app.use("/", router);
app.listen(8080,() => {
    console.log("Server is rocking at 8080");
})
