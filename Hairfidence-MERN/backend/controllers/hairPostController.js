import HairPost from "../models/NGO_HairPost.js";

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
