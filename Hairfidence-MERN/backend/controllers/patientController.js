import bcrypt from "bcryptjs";
import Login from "../models/login.js";
import Patient from "../models/Patient.js";
import PatientReport from "../models/PatientReport.js";
import NGO_HairPost from "../models/NGO_HairPost.js";
import hairRequest from "../models/hairRequest.js";
import PatientPostRequest from "../models/PatientPostRequest.js";
import PatientPost from "../models/PatientPost.js";
import campaign from "../models/campaign.js";


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

export const getallNgoPost = async(req,res)=>{
  try{
    const posts = await NGO_HairPost.find({status:"active"}).sort({createdAt:-1});
    return res.status(200).json(posts)
  }
  catch(e){
    console.log(e);
    
        return res.status(200).json({message:e})

  }
}

export const sendHairRequest = async (req, res) => {
  try {
    const { postId, profileId } = req.body;

    const exists = await hairRequest.findOne({ postId, profileId });

    if (exists) {
      return res.status(400).json({ message: "Already requested" });
    }

    const request = await hairRequest.create({
      postId,
      profileId,
    });

    res.status(201).json(request);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

export const getMyRequests = async (req, res) => {
  console.log("Hiiii");
  
  
  try {
    const { profileId } = req.params;
    console.log(req.params);

    const requests = await hairRequest.find({ profileId }).populate("postId");
console.log(requests);

    return res.status(200).json(requests);
  } catch (error) {
    console.log(error);
    
    res.status(500).json({ message: error.message });
  }
};


export const cancelRequest = async (req, res) => {
  console.log(req.params);
  
  try {
    const { requestId } = req.params;

    const request = await hairRequest.findById(requestId);
console.log(request);

    if (!request)
      return res.status(404).json({ message: "Request not found" });

    // Already cancelled
    if (request.status === "cancelled") {
      return res.status(400).json({ message: "Already cancelled" });
    }

    // Delivered / rejected cannot cancel
    if (["delivered", "rejected"].includes(request.status)) {
      return res
        .status(400)
        .json({ message: "Cannot cancel after delivery or rejection" });
    }

    // If approved → restore quantity
    if (request.status === "approved") {
      const post = await NGO_HairPost.findById(request.postId);

      if (post) {
        post.quantity += 1;
        await post.save();
      }
    }

    // Finally cancel
    request.status = "cancelled";
    await request.save();

    res.json({ message: "Request cancelled successfully" });
  } catch (error) {
    console.log(error);
    
    res.status(500).json({ message: error.message });
  }
};


/* CREATE POST */
export const createPatientPost = async (req, res) => {
  try {
    const post = await PatientPost.create(req.body);
    res.status(201).json(post);
  } catch (err) {
    res.status(500).json({ message: "Failed to create post" });
  }
};

/* GET POSTS BY PATIENT */
export const getPatientPosts = async (req, res) => {
  try {
    const posts = await PatientPost.find({
      patientId: req.params.patientId,
    }).sort({ createdAt: -1 });

    res.json(posts);
  } catch {
    res.status(500).json({ message: "Failed to fetch posts" });
  }
};

/* UPDATE POST */
export const updatePatientPost = async (req, res) => {
  try {
    await PatientPost.findByIdAndUpdate(req.params.id, req.body);
    res.json({ message: "Post updated" });
  } catch {
    res.status(500).json({ message: "Update failed" });
  }
};

/* DELETE POST */
export const deletePatientPost = async (req, res) => {
  try {
    await PatientPost.findByIdAndDelete(req.params.id);
    res.json({ message: "Post deleted" });
  } catch {
    res.status(500).json({ message: "Delete failed" });
  }
};

/* NGO SEND REQUEST */
export const createPostRequest = async (req, res) => {
  try {
    const request = await PatientPostRequest.create(req.body);
    res.status(201).json(request);
  } catch {
    res.status(500).json({ message: "Request failed" });
  }
};


export const getPatientRequests = async (req, res) => {
  try {
    const { patientId } = req.params;

    const requests = await PatientPostRequest.find({ patientId })
      .populate("ngoId", "name place pincode phone email")
      .populate("postId");

    res.status(200).json(requests);
  } catch (err) {
    res.status(500).json({ message: "Failed to fetch requests" });
  }
};

/* =========================================
   UPDATE REQUEST STATUS (ACCEPT / REJECT)
========================================= */

export const updateRequestStatus = async (req, res) => {
  try {
    const { requestId } = req.params;
    const { status } = req.body; // approved | rejected

    if (!["approved", "rejected"].includes(status)) {
      return res.status(400).json({ message: "Invalid status" });
    }

    /* ===============================
       UPDATE REQUEST STATUS
    =============================== */
    const request = await PatientPostRequest.findByIdAndUpdate(
      requestId,
      { status },
      { new: true }
    );

    if (!request) {
      return res.status(404).json({ message: "Request not found" });
    }

    /* ===============================
       IF APPROVED → CLOSE POST
    =============================== */
    if (status === "approved") {
      await PatientPost.findByIdAndUpdate(request.postId, {
        status: "closed",
      });
    }

    res.status(200).json({
      message: "Request updated successfully",
      request,
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Status update failed" });
  }
};

export const getUpcomingCampaigns = async (req, res) => {
  console.log("hiii");
  
  try {
    const { today } = req.params; // yyyy-mm-dd

    const campaigns = await campaign.find({
      date: { $gte: today },
    })
      .populate("ngoId", "name place pincode phone email")
      .sort({ date: 1 });

    res.status(200).json(campaigns);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: "Failed to fetch upcoming campaigns",
    });
  }
};