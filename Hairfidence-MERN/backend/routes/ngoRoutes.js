import express from "express";
import { addNgo, deleteNgo, getActivePatientPosts, getAllNgos, getNgoById, getNgoRequests, sendRequestToPatientPost, updateNgo } from "../controllers/ngoController.js";

const ngoRouter = express.Router();

ngoRouter.post("/", addNgo);
ngoRouter.get("/", getAllNgos);
ngoRouter.get("/:id", getNgoById);
ngoRouter.put("/:id", updateNgo);
ngoRouter.delete("/:id", deleteNgo);

ngoRouter.get("/patient-posts/active", getActivePatientPosts);

ngoRouter.post("/patient-post-requests", sendRequestToPatientPost);
ngoRouter.get("/patient-post-requests/ngo/:ngoId", getNgoRequests);

export default ngoRouter;
