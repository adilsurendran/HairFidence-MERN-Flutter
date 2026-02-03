import express from "express";
import { addNgo, deleteNgo, getAllNgos, getNgoById, updateNgo } from "../controllers/ngoController.js";

const ngoRouter = express.Router();

ngoRouter.post("/", addNgo);
ngoRouter.get("/", getAllNgos);
ngoRouter.get("/:id", getNgoById);
ngoRouter.put("/:id", updateNgo);
ngoRouter.delete("/:id", deleteNgo);

export default ngoRouter;
