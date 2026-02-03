import express from "express";
import { registerPatient } from "../controllers/patientController.js";
import { getAllNgos, registerDonor } from "../controllers/donorController.js";

const Regrouter = express.Router();

Regrouter.post("/register/patient", registerPatient);
Regrouter.post("/register/donor", registerDonor);
Regrouter.get("/ngos",getAllNgos)

export default Regrouter;
