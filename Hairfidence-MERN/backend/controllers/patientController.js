import bcrypt from "bcryptjs";
import Login from "../models/login.js";
import Patient from "../models/Patient.js";
import PatientReport from "../models/PatientReport.js";


export const registerPatient = async (req, res) => {
  try {
    const {
      name,
      email,
      phone,
      address,
      pin,
      district,
      password,
      gender,
      dob,
    } = req.body;

    if (
      !name ||
      !email ||
      !phone ||
      !address ||
      !pin ||
      !district ||
      !password ||
      !gender ||
      !dob
    ) {
      return res.status(400).json({ message: "All fields are required" });
    }

    const existingLogin = await Login.findOne({ username: email });
    if (existingLogin) {
      return res.status(409).json({ message: "User already registered" });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const login = await Login.create({
      username: email,
      password: hashedPassword,
      role: "patient",
    });

    const patient = await Patient.create({
      loginId: login._id,
      name,
      email,
      phone,
      address,
      pin,
      district,
      gender,
      dob,
    });

    res.status(201).json({
      message: "Patient registered successfully",
      loginId: login._id,
      profileId: patient._id,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Patient registration failed" });
  }
};


export const getPatientProfile = async (req, res) => {
  try {
    const { id } = req.params;

    const patient = await Patient.findById(id).select(
      "name email phone address pin district gender dob"
    );

    if (!patient) {
      return res.status(404).json({ message: "Patient not found" });
    }

    res.status(200).json(patient);
  } catch (error) {
    res.status(500).json({
      message: "Failed to fetch profile",
      error: error.message,
    });
  }
};

/* ===========================
   UPDATE PATIENT PROFILE
=========================== */
export const updatePatientProfile = async (req, res) => {
  try {
    const { id } = req.params;

    const {
      name,
      phone,
      address,
      pin,
      district,
      gender,
      dob,
    } = req.body;

    const updatedPatient = await Patient.findByIdAndUpdate(
      id,
      {
        name,
        phone,
        address,
        pin,
        district,
        gender,
        dob,
      },
      { new: true, runValidators: true }
    ).select("name email phone address pin district gender dob");

    if (!updatedPatient) {
      return res.status(404).json({ message: "Patient not found" });
    }

    res.status(200).json({
      message: "Profile updated successfully",
      data: updatedPatient,
    });
  } catch (error) {
    res.status(500).json({
      message: "Profile update failed",
      error: error.message,
    });
  }
};


/* ===============================
   ADD REPORT
================================ */
export const addPatientReport = async (req, res) => {
  try {
    const {
      patientId,
      title,
      reportType,
      hospital,
      reportDate,
    } = req.body;

    if (
      !patientId ||
      !title ||
      !reportType ||
      !hospital ||
      !reportDate ||
      !req.file
    ) {
      return res
        .status(400)
        .json({ message: "All fields are required" });
    }

    const report = await PatientReport.create({
      patientId,
      title,
      reportType,
      hospital,
      reportDate,
      image: req.file.filename,
    });

    res.status(201).json({
      message: "Report added successfully",
      report,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: "Failed to add report",
    });
  }
};

/* ===============================
   GET REPORTS BY PATIENT
================================ */
export const getPatientReports = async (req, res) => {
  try {
    const { patientId } = req.params;

    const reports = await PatientReport.find({ patientId })
      .sort({ createdAt: -1 });

    res.status(200).json(reports);
  } catch (error) {
    res.status(500).json({
      message: "Failed to fetch reports",
    });
  }
};

/* ===============================
   DELETE REPORT
================================ */
export const deletePatientReport = async (req, res) => {
  try {
    const { reportId } = req.params;

    await PatientReport.findByIdAndDelete(reportId);

    res.status(200).json({
      message: "Report deleted successfully",
    });
  } catch (error) {
    res.status(500).json({
      message: "Delete failed",
    });
  }
};
