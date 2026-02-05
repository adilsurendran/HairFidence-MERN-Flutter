import express from "express";
import { addPatientReport, cancelRequest, createPatientPost, createPostRequest, deletePatientPost, deletePatientReport, getallNgoPost, getMyRequests, getPatientPosts, getPatientProfile, getPatientReports, getPatientRequests, getUpcomingCampaigns, sendHairRequest, updatePatientPost, updatePatientProfile, updateRequestStatus } from "../controllers/patientController.js";
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

patientRouter.get("/ngopost",getallNgoPost);

patientRouter.post("/request/send-request", sendHairRequest);

patientRouter.get("/request/my-requests/:profileId", getMyRequests);

patientRouter.put("/request/cancel/:requestId", cancelRequest);

patientRouter.post("/patient-posts", createPatientPost);
patientRouter.get("/patient-posts/:patientId", getPatientPosts);
patientRouter.put("/patient-posts/:id", updatePatientPost);
patientRouter.delete("/patient-posts/:id", deletePatientPost);

patientRouter.post("/patient-post-requests", createPostRequest);


patientRouter.get("/patient-post-requests/patient/:patientId", getPatientRequests);

// Accept / Reject request
patientRouter.put("/patient-post-requests/:requestId/status", updateRequestStatus);

patientRouter.get("/campaigns/upcoming/:today", getUpcomingCampaigns);


export default patientRouter;
