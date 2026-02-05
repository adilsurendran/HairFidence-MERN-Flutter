import express from "express";
import { getAllDonors, getAllPatients, toggleDonorStatus, togglePatientStatus } from "../controllers/adminController.js";


const adminRouter = express.Router();

adminRouter.get("/donors/", getAllDonors);
adminRouter.put("/donors/status/:donorId", toggleDonorStatus);

adminRouter.get("/patients/", getAllPatients);
adminRouter.put("/patients/status/:patientId", togglePatientStatus);

export default adminRouter;
