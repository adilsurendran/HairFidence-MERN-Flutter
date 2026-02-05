import DonorHairPost from "../models/DonorHairPost.js";

/* ===============================
   ADD DONOR HAIR POST
================================ */
export const addDonorHairPost = async (req, res) => {
    console.log(req.body);
    
  try {
    const post = await DonorHairPost.create(req.body);

    res.status(201).json({
      message: "Hair donation post added",
      post,
    });
  } catch (err) {
    console.log(err);
    
    res.status(500).json({
      message: "Failed to add post",
      error: err.message,
    });
  }
};

/* ===============================
   GET DONOR POSTS
================================ */
export const getDonorHairPosts = async (req, res) => {
  try {
    const { donorId } = req.params;

    const posts = await DonorHairPost.find({ donorId })
      .sort({ createdAt: -1 });

    res.status(200).json(posts);
  } catch (err) {
    res.status(500).json({ message: "Failed to fetch posts" });
  }
};

/* ===============================
   UPDATE DONOR POST
================================ */
export const updateDonorHairPost = async (req, res) => {
  try {
    const { postId } = req.params;

    const updated = await DonorHairPost.findByIdAndUpdate(
      postId,
      req.body,
      { new: true }
    );

    res.status(200).json({
      message: "Post updated",
      post: updated,
    });
  } catch (err) {
    res.status(500).json({ message: "Update failed" });
  }
};

/* ===============================
   DELETE DONOR POST
================================ */
export const deleteDonorHairPost = async (req, res) => {
  try {
    const { postId } = req.params;

    await DonorHairPost.findByIdAndDelete(postId);

    res.status(200).json({ message: "Post deleted" });
  } catch (err) {
    res.status(500).json({ message: "Delete failed" });
  }
};


export const getNgoDonorHairPosts = async (req, res) => {
  try {
    const { ngoId } = req.params;

    const posts = await DonorHairPost.find({ ngoId })
      .populate("donorId", "name phone gender district")
      .sort({ createdAt: -1 });

    res.status(200).json(posts);
  } catch (err) {
    res.status(500).json({
      message: "Failed to fetch donor posts",
    });
  }
};

/* ===============================
   NGO APPROVE POST
================================ */
export const approveDonorHairPost = async (req, res) => {
  try {
    const { postId } = req.params;

    const post = await DonorHairPost.findById(postId);
    if (!post)
      return res.status(404).json({ message: "Post not found" });

    post.status = "approved";
    post.rejectNote = null;
    await post.save();

    res.status(200).json({ message: "Post approved" });
  } catch (err) {
    res.status(500).json({ message: "Approval failed" });
  }
};

/* ===============================
   NGO REJECT POST
================================ */
export const rejectDonorHairPost = async (req, res) => {
  try {
    const { postId } = req.params;
    const { rejectNote } = req.body;

    if (!rejectNote)
      return res.status(400).json({ message: "Reject note required" });

    const post = await DonorHairPost.findById(postId);
    if (!post)
      return res.status(404).json({ message: "Post not found" });

    post.status = "rejected";
    post.rejectNote = rejectNote;
    await post.save();

    res.status(200).json({ message: "Post rejected" });
  } catch (err) {
    res.status(500).json({ message: "Rejection failed" });
  }
};


export const collectDonorHairPost = async (req, res) => {
  try {
    const { postId } = req.params;

    await DonorHairPost.findByIdAndUpdate(postId, {
      status: "collected",
    });

    res.status(200).json({ message: "Hair collected successfully" });
  } catch (err) {
    res.status(500).json({ message: "Collection failed" });
  }
};