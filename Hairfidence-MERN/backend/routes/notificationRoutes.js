import express from "express";
import {
  sendNotification,
  getNotifications,
  getNgoNotifications,
} from "../controllers/notificationController.js";

const router = express.Router();

router.post("/", sendNotification);
router.get("/", getNotifications);
router.get("/ngo/:ngoId", getNgoNotifications);

export default router;
