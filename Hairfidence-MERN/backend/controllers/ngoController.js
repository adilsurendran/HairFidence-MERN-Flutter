import bcrypt from "bcryptjs";
import Login from "../models/login.js";
import Ngo from "../models/ngo.js";
import PatientPost from "../models/PatientPost.js";
import PatientPostRequest from "../models/PatientPostRequest.js";
import PatientReport from "../models/PatientReport.js";
import Notification from "../models/Notification.js";
import hairRequest from "../models/hairRequest.js";
import campaign from "../models/campaign.js";
import NGO_HairPost from "../models/NGO_HairPost.js";
import DonorHairPost from "../models/DonorHairPost.js";


export const addNgo = async (req, res) => {
    console.log(req.body);
    
  try {
    const {
      password,
      name,
      contactPerson,
      phone,
      email,
      state,
      city,
      place,
      pincode,
    } = req.body;

    // basic validation
    if (!email || !password || !name || !contactPerson || !phone) {
      return res.status(400).json({
        message: "Required fields are missing",
      });
    }

    // email is username
    const existingUser = await Login.findOne({ username: email });
    if (existingUser) {
      return res.status(400).json({
        message: "NGO login already exists with this email",
      });
    }

    // hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    // create login
    const login = await Login.create({
      username: email,
      password: hashedPassword,
      role: "ngo",
      verified: true,
    });

    // create ngo with loginId as common key
    const ngo = await Ngo.create({
      loginId: login._id,
      name,
      contactPerson,
      phone,
      email,
      state,
      city,
      place,
      pincode,
    });

    res.status(201).json({
      message: "NGO added successfully",
      ngo,
    });
  } catch (error) {
    res.status(500).json({
      message: "Failed to add NGO",
      error: error.message,
    });
  }
};

export const getAllNgos = async (req, res) => {
  try {
    const ngos = await Ngo.find().populate("loginId", "username");
    res.status(200).json(ngos);
  } catch (error) {
    res.status(500).json({ message: "Failed to fetch NGOs" });
  }
};

/* ===========================
   GET SINGLE NGO
=========================== */
export const getNgoById = async (req, res) => {
  try {
    const ngo = await Ngo.findById(req.params.id).select("name contactPerson phone state city place pincode -_id");
    if (!ngo) return res.status(404).json({ message: "NGO not found" });
    res.status(200).json(ngo);
  } catch (error) {
    res.status(500).json({ message: "Failed to fetch NGO" });
  }
};

/* ===========================
   UPDATE NGO
=========================== */
export const updateNgo = async (req, res) => {
  try {
    const ngo = await Ngo.findByIdAndUpdate(req.params.id, req.body, {
      new: true,
    });

    if (!ngo) return res.status(404).json({ message: "NGO not found" });

    res.status(200).json({ message: "NGO updated", ngo });
  } catch (error) {
    res.status(500).json({ message: "Failed to update NGO" });
  }
};

/* ===========================
   DELETE NGO + LOGIN
=========================== */
export const deleteNgo = async (req, res) => {
  try {
    const ngo = await Ngo.findById(req.params.id);
    if (!ngo) return res.status(404).json({ message: "NGO not found" });

    await Login.findByIdAndDelete(ngo.loginId);
    await Ngo.findByIdAndDelete(req.params.id);

    res.status(200).json({ message: "NGO deleted successfully" });
  } catch (error) {
    res.status(500).json({ message: "Failed to delete NGO" });
  }
};


/**
 * NGO – View all active patient posts
 */
// export const getActivePatientPosts = async (req, res) => {
//   console.log("hii");
  
//   try {
//     const posts = await PatientPost.find({ status: "active" })
//       .populate("patientId", "name district");

//     return res.status(200).json(posts);
//   } catch (err) {
//     console.log(err);
    
//     return res.status(500).json({ message: "Failed to fetch patient posts",err });
//   }
// };
export const getActivePatientPosts = async (req, res) => {
  try {
    // 1. fetch active posts + patient basic info
    const posts = await PatientPost.find({ status: "active" })
      .populate("patientId", "name district");

    // 2. attach patient reports to each post
    const postsWithReports = await Promise.all(
      posts.map(async (post) => {
        const reports = await PatientReport.find({
          patientId: post.patientId._id,
        }).sort({ createdAt: -1 });

        return {
          ...post.toObject(),
          patientReports: reports,
        };
      })
    );

    return res.status(200).json(postsWithReports);
  } catch (err) {
    console.log(err);
    return res.status(500).json({
      message: "Failed to fetch patient posts",
      err,
    });
  }
};

export const sendRequestToPatientPost = async (req, res) => {
  try {
    const { postId, patientId, ngoId, message } = req.body;

    if (!postId || !patientId || !ngoId) {
      return res.status(400).json({ message: "Missing required fields" });
    }

    // Prevent duplicate request
    const exists = await PatientPostRequest.findOne({
      postId,
      ngoId,
    });

    if (exists) {
      return res
        .status(409)
        .json({ message: "Request already sent" });
    }

    const request = await PatientPostRequest.create({
      postId,
      patientId,
      ngoId,
      message,
    });

    res.status(201).json({
      message: "Request sent successfully",
      request,
    });
  } catch (err) {
    res.status(500).json({ message: "Failed to send request" });
  }
};

/**
 * NGO – View all requests sent by this NGO
 */
export const getNgoRequests = async (req, res) => {
  try {
    const { ngoId } = req.params;

    const requests = await PatientPostRequest.find({ ngoId })
      .populate("postId")
      .populate("patientId", "name phone district");

    res.status(200).json(requests);
  } catch (err) {
    res.status(500).json({ message: "Failed to fetch requests" });
  }
};

// export const getNgoDashboardCounts = async (req, res) => {
//   try {
//     const { ngoId } = req.params;

//     const [
//       campaignsCount,
//       notificationsCount,
//       requestsCount,
//       donorPostsCount,
//     ] = await Promise.all([
//       campaign.countDocuments({ ngoId }),
//       Notification.countDocuments({ ngoId }),
//       hairRequest.countDocuments({ ngoId }),
//       NGO_HairPost.countDocuments({ ngoId }),
//     ]);

//     res.status(200).json({
//       campaigns: campaignsCount,
//       notifications: notificationsCount,
//       requests: requestsCount,
//       donorPosts: donorPostsCount,
//     });
//   } catch (error) {
//     res.status(500).json({ message: "Dashboard load failed" });
//   }
// };


export const getNgoDashboardCounts = async (req, res) => {
  try {
    const { ngoId } = req.params;

    /* -------------------------------
       1. Campaign count
    -------------------------------- */
    const campaignsCount = await campaign.countDocuments({
      ngoId,
    });

    /* -------------------------------
       2. Notifications count
       (NGO OR ALL)
    -------------------------------- */
    const notificationsCount = await Notification.countDocuments({
      roles: { $in: ["ngo", "all"] },
    });

    /* -------------------------------
       3. Donor hair posts count
    -------------------------------- */
    const donorPostsCount = await DonorHairPost.countDocuments({
      ngoId,
    });

    /* -------------------------------
       4. Requests count
       (requests for this NGO’s posts)
    -------------------------------- */
    const ngoPosts = await NGO_HairPost.find(
      { ngoId },
      { _id: 1 }
    );

    const postIds = ngoPosts.map((p) => p._id);

    const requestsCount = await hairRequest.countDocuments({
      postId: { $in: postIds },
    });

    /* -------------------------------
       RESPONSE
    -------------------------------- */
    res.status(200).json({
      campaigns: campaignsCount,
      notifications: notificationsCount,
      donorPosts: donorPostsCount,
      requests: requestsCount,
    });
  } catch (error) {
    console.error("NGO Dashboard Error:", error);
    res.status(500).json({ message: "Dashboard load failed" });
  }
};

