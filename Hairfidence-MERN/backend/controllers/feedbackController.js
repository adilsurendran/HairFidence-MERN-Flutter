import Feedback from "../models/feedback.js";

/* ===============================
   SEND FEEDBACK
================================ */
export const sendFeedback = async (req, res) => {
  try {
    const { senderId, senderRole, message } = req.body;

    if (!senderId || !senderRole || !message) {
      return res.status(400).json({
        message: "All fields are required",
      });
    }

    const feedback = await Feedback.create({
      senderId,
      senderRole,
      message,
    });

    res.status(201).json({
      message: "Feedback submitted successfully",
      feedback,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: "Failed to submit feedback",
    });
  }
};

/* ===============================
   VIEW ALL FEEDBACK (ADMIN)
================================ */
export const getAllFeedbacks = async (req, res) => {
  try {
    const feedbacks = await Feedback.find()
      .sort({ createdAt: -1 });

    res.status(200).json(feedbacks);
  } catch (error) {
    res.status(500).json({
      message: "Failed to fetch feedbacks",
    });
  }
};
