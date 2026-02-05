import express from "express";
import {
  sendComplaint,
  getUserComplaints,
  getAllComplaints,
  replyComplaint,
} from "../controllers/complaintController.js";

const complaintRoutes = express.Router();

/* USER */
complaintRoutes.post("/", sendComplaint);
complaintRoutes.get("/user/:senderId", getUserComplaints);

/* ADMIN */
complaintRoutes.get("/", getAllComplaints);
complaintRoutes.put("/reply/:complaintId", replyComplaint);

export default complaintRoutes;
