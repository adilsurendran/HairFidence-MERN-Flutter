import express from "express";
import {
  createHairPost,
  getNgoHairPosts,
  updateHairPost,
  deleteHairPost,
  getNgoHairRequests,
  approveHairRequest,
  rejectHairRequest,
} from "../controllers/hairPostController.js";

const hairPostRoutes = express.Router();

hairPostRoutes.post("/", createHairPost);
hairPostRoutes.get("/:profileId", getNgoHairPosts);
hairPostRoutes.put("/:id", updateHairPost);
hairPostRoutes.delete("/:id", deleteHairPost);

hairPostRoutes.get("/ngo/:ngoId", getNgoHairRequests);
hairPostRoutes.put("/approve/:requestId", approveHairRequest);
hairPostRoutes.put("/reject/:requestId", rejectHairRequest);

export default hairPostRoutes;
