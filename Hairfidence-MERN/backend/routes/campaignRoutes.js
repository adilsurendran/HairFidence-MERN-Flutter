import express from "express";

import { uploadCampaignImage } from "../middleware/multer.js";
import { addCampaign, deleteCampaign, getNgoCampaigns, updateCampaign } from "../controllers/campaignController.js";

const campaignRouter = express.Router();

campaignRouter.post("/", uploadCampaignImage.single("image"), addCampaign);
campaignRouter.get("/:ngoId", getNgoCampaigns);
campaignRouter.delete("/:id", deleteCampaign);
campaignRouter.put("/:id", uploadCampaignImage.single("image"), updateCampaign);

export default campaignRouter;
