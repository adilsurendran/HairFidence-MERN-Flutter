import Donor from "../models/Donor.js";
import login from "../models/login.js";
import ngo from "../models/ngo.js";
import Patient from "../models/Patient.js";
import Complaint from "../models/complaint.js";


export const getAllDonors = async (req, res) => {
  try {
    const donors = await Donor.find()
      .populate("loginId", "verified")
      .populate("ngoId", "name")
      .sort({ createdAt: -1 });

    res.status(200).json(donors);
  } catch (error) {
    res.status(500).json({
      message: "Failed to fetch donors",
    });
  }
};

/* ===============================
   BLOCK / UNBLOCK DONOR
================================ */
export const toggleDonorStatus = async (req, res) => {
  try {
    const { donorId } = req.params;
    const { status } = req.body; // true | false

    const donor = await Donor.findById(donorId);
    if (!donor) {
      return res.status(404).json({ message: "Donor not found" });
    }

    await login.findByIdAndUpdate(donor.loginId, {
      verified: status,
    });

    res.status(200).json({
      message: status ? "Donor unblocked" : "Donor blocked",
    });
  } catch (error) {
    console.log(error);
    
    res.status(500).json({
      message: "Status update failed",
    });
  }
};

export const getAllPatients = async (req, res) => {
  try {
    const patients = await Patient.find()
      .populate("loginId", "verified")
      .sort({ createdAt: -1 });

    res.status(200).json(patients);
  } catch (error) {
    res.status(500).json({
      message: "Failed to fetch patients",
    });
  }
};

/* ===============================
   BLOCK / UNBLOCK PATIENT
================================ */
export const togglePatientStatus = async (req, res) => {
  try {
    const { patientId } = req.params;
    const { status } = req.body; // true | false

    const patient = await Patient.findById(patientId);
    if (!patient) {
      return res.status(404).json({ message: "Patient not found" });
    }

    await login.findByIdAndUpdate(patient.loginId, {
      verified: status,
    });

    res.status(200).json({
      message: status ? "Patient unblocked" : "Patient blocked",
    });
  } catch (error) {
    res.status(500).json({
      message: "Status update failed",
    });
  }
};


export const getAdminDashboardCounts = async (req, res) => {
  try {
    const [
      ngoCount,
      donorCount,
      patientCount,
      pendingComplaints,
    ] = await Promise.all([
      ngo.countDocuments(),
      Donor.countDocuments(),
      Patient.countDocuments(),
      Complaint.countDocuments({ status: "pending" }),
    ]);

    res.status(200).json({
      ngos: ngoCount,
      donors: donorCount,
      patients: patientCount,
      pendingComplaints,
    });
  } catch (err) {
    console.error("Admin dashboard error:", err);
    res.status(500).json({ message: "Dashboard load failed" });
  }
};