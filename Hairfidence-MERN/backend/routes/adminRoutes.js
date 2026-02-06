import express from "express";
import { getAllDonors, getAllPatients, toggleDonorStatus, togglePatientStatus } from "../controllers/adminController.js";
import { getAllPostsReport } from "../controllers/adminPostReport.controller.js";
import { downloadPostsPdf } from "../controllers/adminPostPdf.controller.js";


const adminRouter = express.Router();

adminRouter.get("/donors/", getAllDonors);
adminRouter.put("/donors/status/:donorId", toggleDonorStatus);

adminRouter.get("/patients/", getAllPatients);
adminRouter.put("/patients/status/:patientId", togglePatientStatus);

adminRouter.get("/posts-report", getAllPostsReport);
adminRouter.get("/posts-report/pdf", downloadPostsPdf);

export default adminRouter;
