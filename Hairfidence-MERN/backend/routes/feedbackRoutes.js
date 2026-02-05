import express from "express";
import {
  sendFeedback,
  getAllFeedbacks,
} from "../controllers/feedbackController.js";

const feedbackRoutes = express.Router();

/* SEND FEEDBACK */
feedbackRoutes.post("/", sendFeedback);

/* ADMIN VIEW */
feedbackRoutes.get("/", getAllFeedbacks);

export default feedbackRoutes;
