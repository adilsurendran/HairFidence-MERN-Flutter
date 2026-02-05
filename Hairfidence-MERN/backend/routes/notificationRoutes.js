import express from "express";
import {
  sendNotification,
  getNotifications,
  getNgoNotifications,
  getPatientNotifications,
  getDonorNotifications,
} from "../controllers/notificationController.js";

const router = express.Router();

router.post("/", sendNotification);
router.get("/", getNotifications);
router.get("/ngo/:ngoId", getNgoNotifications);
router.get("/patient/:patientId", getPatientNotifications);
router.get("/donor/:donorId", getDonorNotifications);

export default router;
