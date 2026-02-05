import express from "express"
import { getdetails, getDonorProfile, updateDonorProfile } from "../controllers/donorController.js"

const donorRoutes = express.Router()

donorRoutes.get("/:id",getdetails)

// Get donor profile
donorRoutes.get("/profile/:donorId", getDonorProfile);

// Update donor profile
donorRoutes.put("/:donorId", updateDonorProfile);

export default donorRoutes