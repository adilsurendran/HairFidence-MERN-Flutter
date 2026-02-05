import hairRequest from "../models/hairRequest.js";
import HairPost from "../models/NGO_HairPost.js";
import PatientReport from "../models/PatientReport.js";

/* CREATE */
export const createHairPost = async (req, res) => {
  try {
    const { profileId, ...data } = req.body;

    if (!profileId)
      return res.status(400).json({ message: "profileId required" });

    const post = await HairPost.create({
      ...data,
      ngoId: profileId,
    });

    res.status(201).json(post);
  } catch (err) {
    res.status(500).json({ message: "Failed to create hair post" });
  }
};

/* GET NGO POSTS */
export const getNgoHairPosts = async (req, res) => {
  try {
    const { profileId } = req.params;

    if (!profileId)
      return res.status(400).json({ message: "profileId required" });

    const posts = await HairPost.find({ ngoId: profileId }).sort({
      createdAt: -1,
    });

    res.json(posts);
  } catch (err) {
    res.status(500).json({ message: "Failed to fetch posts" });
  }
};

/* UPDATE */
export const updateHairPost = async (req, res) => {
  try {
    const { profileId, ...updatedData } = req.body;

    if (!profileId) {
      return res.status(400).json({ message: "profileId required" });
    }

    const post = await HairPost.findOneAndUpdate(
      {
        _id: req.params.id,
        ngoId: profileId,
      },
      updatedData,
      { new: true }
    );

    if (!post) {
      return res.status(404).json({ message: "Hair post not found" });
    }

    res.status(200).json({
      message: "Hair post updated",
      post,
    });
  } catch (error) {
    res.status(500).json({ message: "Update failed" });
  }
};

/* DELETE */
export const deleteHairPost = async (req, res) => {
  try {
    const { profileId } = req.query;

    const post = await HairPost.findOneAndDelete({
      _id: req.params.id,
      ngoId: profileId,
    });

    if (!post)
      return res.status(404).json({ message: "Post not found" });

    res.json({ message: "Hair post deleted" });
  } catch (err) {
    res.status(500).json({ message: "Delete failed" });
  }
};

/* =====================================================
   GET ALL REQUESTS FOR NGO POSTS
===================================================== */
// export const getNgoHairRequests = async (req, res) => {
//   try {
//     const { ngoId } = req.params;

//     const requests = await hairRequest.find()
//       .populate({
//         path: "postId",
//         match: { ngoId },
//       })
//       .populate("profileId", "name phone gender")
//       .sort({ createdAt: -1 });

//     // remove null posts (other NGOs)
//     const filtered = requests.filter(r => r.postId !== null);

//     res.status(200).json(filtered);
//   } catch (err) {
//     console.log(err);
    
//     res.status(500).json({ message: "Failed to fetch requests" });
//   }
// };

export const getNgoHairRequests = async (req, res) => {
  try {
    const { ngoId } = req.params;

    /* ===============================
       FETCH REQUESTS
    =============================== */
    const requests = await hairRequest
      .find()
      .populate({
        path: "postId",
        match: { ngoId },
      })
      .populate("profileId", "name phone gender")
      .sort({ createdAt: -1 });

    // remove null posts (other NGOs)
    const filtered = requests.filter((r) => r.postId !== null);

    /* ===============================
       ATTACH PATIENT REPORTS
    =============================== */
    const enrichedRequests = await Promise.all(
      filtered.map(async (reqItem) => {
        const reports = await PatientReport.find({
          patientId: reqItem.profileId._id,
        }).sort({ createdAt: -1 });

        return {
          ...reqItem.toObject(),
          patientReports: reports, // 👈 ADDED HERE
        };
      })
    );

    res.status(200).json(enrichedRequests);
  } catch (err) {
    console.log(err);
    res.status(500).json({ message: "Failed to fetch requests" });
  }
};

/* =====================================================
   APPROVE REQUEST
===================================================== */
export const approveHairRequest = async (req, res) => {
  try {
    const { requestId } = req.params;

    const request = await hairRequest.findById(requestId).populate("postId");

    if (!request) {
      return res.status(404).json({ message: "Request not found" });
    }

    if (request.status !== "pending") {
      return res.status(400).json({ message: "Request already processed" });
    }

    const post = await HairPost.findById(request.postId._id);

    if (post.quantity <= 0) {
      // mark this request sold out
      request.status = "soldout";
      await request.save();

      return res.status(400).json({ message: "Hair post sold out" });
    }

    // approve request
    request.status = "approved";
    await request.save();

    // decrease quantity
    post.quantity -= 1;

    if (post.quantity === 0) {
      post.status = "closed";
    }
    
    await post.save();

    // if quantity becomes zero -> mark others soldout
    if (post.quantity === 0) {
      await hairRequest.updateMany(
        {
          postId: post._id,
          status: "pending",
        },
        { status: "soldout" }
      );
    }

    res.status(200).json({
      message: "Request approved",
    });
  } catch (err) {
    res.status(500).json({ message: "Approval failed" });
  }
};

/* =====================================================
   REJECT REQUEST
===================================================== */
export const rejectHairRequest = async (req, res) => {
  try {
    const { requestId } = req.params;

    await hairRequest.findByIdAndUpdate(requestId, {
      status: "rejected",
    });

    res.status(200).json({ message: "Request rejected" });
  } catch (err) {
    res.status(500).json({ message: "Reject failed" });
  }
};
