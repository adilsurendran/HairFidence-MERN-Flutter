import express from "express";
import {
  createHairPost,
  getNgoHairPosts,
  updateHairPost,
  deleteHairPost,
} from "../controllers/hairPostController.js";

const hairPostRoutes = express.Router();

hairPostRoutes.post("/", createHairPost);
hairPostRoutes.get("/:profileId", getNgoHairPosts);
hairPostRoutes.put("/:id", updateHairPost);
hairPostRoutes.delete("/:id", deleteHairPost);

export default hairPostRoutes;
