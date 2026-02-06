import express from "express";
import { getAllPostsReport } from "../controllers/adminPostReport.controller.js";
import { downloadPostsPdf } from "../controllers/adminPostPdf.controller.js";

const adminPostRoutes = express.Router();

adminPostRoutes.get("/posts-report", getAllPostsReport);
adminPostRoutes.get("/posts-report/pdf", downloadPostsPdf);

export default adminPostRoutes;
