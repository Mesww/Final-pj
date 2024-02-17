import { MongoClient } from "mongodb";
import dotenv from "dotenv";

dotenv.config();

// export async function mongoDBConnection() {
//   const url = process.env.MONGODB_URL as string;
//   try {
//     const client = await MongoClient.connect(url, {});
//     console.log("DB Connected!");
//     const database = client.db("PjDatabase"); // Specify your database name
//     const collection = database.collection("todos");
//     const dataFromMongo = await collection.find().toArray();
//     console.log(dataFromMongo);
//     // Additional database operations...

//     await client.close(); // Close the connection
//   } catch (error) {
//     console.error("Error connecting to MongoDB:", error);
//     // Handle other error scenarios as needed
//   }
// }

export async function mongoDBConnection() {
    const url = process.env.MONGODB_URL as string;
  
    try {
      const client = await MongoClient.connect(url, {});
      console.log("DB Connected!");
      const database = client.db("PjDatabase"); // Specify your database name
      const collection = database.collection("todos");
  
    //   const filter = { name: "3" };
    //   const updateData = {
    //       $set:{name:"3333333"}
    //   }
  
      let Result = await collection.find().toArray();
  
      if (Result) {
        console.log("Document Worked successfully:", Result);
      } else {
        console.error("Error document:", Result);
      }
  
      await client.close(); // Close the connection
    } catch (error) {
      console.error("Error connecting to MongoDB:", error);
      // Handle other error scenarios as needed
    }
  }
  

