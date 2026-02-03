import mongoose from "mongoose";
import express from "express";
import cors from "cors";
import ngoRouter from "./routes/ngoRoutes.js";
import loginRouter from "./routes/authRoutes.js";
import campaignRouter from "./routes/campaignRoutes.js";
import hairPostRoutes from "./routes/hairPostRoutes.js";
import router from "./routes/notificationRoutes.js";
import Regrouter from "./routes/registerRoutes.js";
import patientRouter from "./routes/patientRoutes.js";

mongoose
  .connect("mongodb://localhost:27017/Hairfidence")
  .then(() => console.log("Database Connected"))
  .catch((e) => console.log(e));

const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cors({ origin: "*" }));

app.use("/api/uploads", express.static("uploads"));
app.use("/api/ngos", ngoRouter);
app.use("/api/auth", loginRouter);
app.use("/api/campaigns", campaignRouter);
app.use("/api/hair-posts", hairPostRoutes);
app.use("/api/notifications", router);
app.use("/api",Regrouter)
app.use("/api", patientRouter);

app.listen(8000, () => {
  console.log("Server running on port 8000");
});