import Complaint from "../models/complaint.js";

/* ===============================
   SEND COMPLAINT
================================ */
export const sendComplaint = async (req, res) => {
  try {
    const { senderId, senderRole, subject, message } = req.body;

    if (!senderId || !senderRole || !subject || !message) {
      return res.status(400).json({
        message: "All fields are required",
      });
    }

    const complaint = await Complaint.create({
      senderId,
      senderRole,
      subject,
      message,
    });

    res.status(201).json({
      message: "Complaint submitted successfully",
      complaint,
    });
  } catch (error) {
    res.status(500).json({
      message: "Failed to submit complaint",
    });
  }
};

/* ===============================
   USER VIEW OWN COMPLAINTS
================================ */
export const getUserComplaints = async (req, res) => {
  try {
    const { senderId } = req.params;

    const complaints = await Complaint.find({ senderId })
      .sort({ createdAt: -1 });

    res.status(200).json(complaints);
  } catch (error) {
    res.status(500).json({
      message: "Failed to fetch complaints",
    });
  }
};

/* ===============================
   ADMIN VIEW ALL COMPLAINTS
================================ */
export const getAllComplaints = async (req, res) => {
  try {
    const complaints = await Complaint.find()
      .sort({ createdAt: -1 });

    res.status(200).json(complaints);
  } catch (error) {
    res.status(500).json({
      message: "Failed to fetch complaints",
    });
  }
};

/* ===============================
   ADMIN REPLY TO COMPLAINT
================================ */
export const replyComplaint = async (req, res) => {
  try {
    const { complaintId } = req.params;
    const { reply } = req.body;

    if (!reply) {
      return res.status(400).json({
        message: "Reply message required",
      });
    }

    const updated = await Complaint.findByIdAndUpdate(
      complaintId,
      {
        reply,
        status: "replied",
      },
      { new: true }
    );

    res.status(200).json({
      message: "Reply sent successfully",
      complaint: updated,
    });
  } catch (error) {
    res.status(500).json({
      message: "Reply failed",
    });
  }
};
