// import DonorHairPost from "../models/DonorHairPost.js";
// import NGO_HairPost from "../models/NGO_HairPost.js";
// import PatientPost from "../models/PatientPost.js";


// export const getAllPostsReport = async (req, res) => {
//   try {
//     const { from, to } = req.query;

//     const dateFilter = {};
//     if (from && to) {
//       dateFilter.createdAt = {
//         $gte: new Date(from),
//         $lte: new Date(to),
//       };
//     }

//     /* ================= NGO POSTS ================= */
//     const ngoPosts = await NGO_HairPost.find(dateFilter).populate(
//       "ngoId",
//       "name"
//     );

//     const ngoData = ngoPosts.map((p) => ({
//       postType: "NGO",
//       postId: p._id,
//       ownerName: p.ngoId?.name || "NGO",
//       title: p.title,
//       hairLength: p.hairLength,
//       hairType: p.hairType,
//       hairColor: p.hairColor,
//       quantity: p.quantity,
//       location: p.location,
//       status: p.status,
//       createdAt: p.createdAt,
//     }));

//     /* ================= DONOR POSTS ================= */
//     const donorPosts = await DonorHairPost.find(dateFilter)
//       .populate("donorId", "name")
//       .populate("ngoId", "name");

//     const donorData = donorPosts.map((p) => ({
//       postType: "DONOR",
//       postId: p._id,
//       ownerName: p.donorId?.name || "Donor",
//       title: p.title,
//       hairLength: p.hairLength,
//       hairType: p.hairType,
//       hairColor: p.hairColor,
//       quantity: p.quantity,
//       location: p.location,
//       status: p.status,
//       createdAt: p.createdAt,
//     }));

//     /* ================= PATIENT POSTS ================= */
//     const patientPosts = await PatientPost.find(dateFilter).populate(
//       "patientId",
//       "name"
//     );

//     const patientData = patientPosts.map((p) => ({
//       postType: "PATIENT",
//       postId: p._id,
//       ownerName: p.patientId?.name || "Patient",
//       title: "Patient Hair Request",
//       hairLength: p.hairLength,
//       hairType: p.hairType,
//       hairColor: p.hairColor,
//       quantity: p.quantity,
//       location: p.location,
//       status: p.status,
//       createdAt: p.createdAt,
//     }));

//     const result = [...ngoData, ...donorData, ...patientData].sort(
//       (a, b) => new Date(b.createdAt) - new Date(a.createdAt)
//     );

//     res.json(result);
//   } catch (err) {
//     console.error("Admin Post Report Error:", err);
//     res.status(500).json({ message: "Failed to load admin report" });
//   }
// };


import DonorHairPost from "../models/DonorHairPost.js";
import NGO_HairPost from "../models/NGO_HairPost.js";
import PatientPost from "../models/PatientPost.js";

/**
 * Utility to build filters
 */
const buildFilter = ({ from, to, status }) => {
  const filter = {};

  if (from && to) {
    filter.createdAt = {
      $gte: new Date(from),
      $lte: new Date(to),
    };
  }

  if (status && status !== "all") {
    filter.status = status;
  }

  return filter;
};

export const getAllPostsReport = async (req, res) => {
  try {
    const { from, to, status } = req.query;
    const filter = buildFilter({ from, to, status });

    /* ================= NGO POSTS ================= */
    const ngoPosts = await NGO_HairPost.find(filter).populate(
      "ngoId",
      "name"
    );

    const ngoData = ngoPosts.map((p) => ({
      postType: "NGO",
      postId: p._id,
      ownerName: p.ngoId?.name || "NGO",
      hairLength: p.hairLength,
      hairType: p.hairType,
      hairColor: p.hairColor,
      quantity: p.quantity,
      location: p.location,
      status: p.status,
      createdAt: p.createdAt,
    }));

    /* ================= DONOR POSTS ================= */
    const donorPosts = await DonorHairPost.find(filter)
      .populate("donorId", "name")
      .populate("ngoId", "name");

    const donorData = donorPosts.map((p) => ({
      postType: "DONOR",
      postId: p._id,
      ownerName: p.donorId?.name || "Donor",
      hairLength: p.hairLength,
      hairType: p.hairType,
      hairColor: p.hairColor,
      quantity: p.quantity,
      location: p.location,
      status: p.status,
      createdAt: p.createdAt,
    }));

    /* ================= PATIENT POSTS ================= */
    const patientPosts = await PatientPost.find(filter).populate(
      "patientId",
      "name"
    );

    const patientData = patientPosts.map((p) => ({
      postType: "PATIENT",
      postId: p._id,
      ownerName: p.patientId?.name || "Patient",
      hairLength: p.hairLength,
      hairType: p.hairType,
      hairColor: p.hairColor,
      quantity: p.quantity,
      location: p.location,
      status: p.status,
      createdAt: p.createdAt,
    }));

    const result = [...ngoData, ...donorData, ...patientData].sort(
      (a, b) => new Date(b.createdAt) - new Date(a.createdAt)
    );

    res.json(result);
  } catch (err) {
    console.error("Admin Post Report Error:", err);
    res.status(500).json({ message: "Failed to load admin report" });
  }
};
