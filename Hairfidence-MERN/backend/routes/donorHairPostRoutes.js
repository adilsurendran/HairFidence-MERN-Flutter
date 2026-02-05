import express from "express";
import {
  addDonorHairPost,
  getDonorHairPosts,
  updateDonorHairPost,
  deleteDonorHairPost,
  getNgoDonorHairPosts,
  approveDonorHairPost,
  rejectDonorHairPost,
  collectDonorHairPost,
} from "../controllers/donorHairPostController.js";

const donorHairPostRoutes = express.Router();

donorHairPostRoutes.post("/", addDonorHairPost);
donorHairPostRoutes.get("/:donorId", getDonorHairPosts);
donorHairPostRoutes.put("/:postId", updateDonorHairPost);
donorHairPostRoutes.delete("/:postId", deleteDonorHairPost);
donorHairPostRoutes.get("/ngo/:ngoId", getNgoDonorHairPosts);
donorHairPostRoutes.put("/approve/:postId", approveDonorHairPost);
donorHairPostRoutes.put("/reject/:postId", rejectDonorHairPost);
donorHairPostRoutes.put("/collect/:postId", collectDonorHairPost);

export default donorHairPostRoutes;
