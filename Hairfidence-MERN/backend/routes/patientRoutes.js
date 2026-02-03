import express from "express";
import { addPatientReport, deletePatientReport, getPatientProfile, getPatientReports, updatePatientProfile } from "../controllers/patientController.js";
import { uploadCampaignImage } from "../middleware/multer.js";


const patientRouter = express.Router();

/* ===========================
   PATIENT PROFILE ROUTES
=========================== */
patientRouter.get("/patient/:id", getPatientProfile);
patientRouter.put("/patient/:id", updatePatientProfile);

/* ADD REPORT */
patientRouter.post(
  "/patient-reports",
  uploadCampaignImage.single("image"),
  addPatientReport
);

/* GET REPORTS */
patientRouter.get(
  "/patient-reports/:patientId",
  getPatientReports
);

/* DELETE REPORT */
patientRouter.delete(
  "/patient-reports/:reportId",
  deletePatientReport
);

export default patientRouter;
