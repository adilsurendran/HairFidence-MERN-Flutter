import Notification from "../models/Notification.js";

/* CREATE NOTIFICATION */
export const sendNotification = async (req, res) => {
  try {
    const { title, message, roles } = req.body;

    if (!title || !message || !roles || roles.length === 0) {
      return res.status(400).json({ message: "All fields required" });
    }

    const notification = await Notification.create({
      title,
      message,
      roles,
    });

    res.status(201).json(notification);
  } catch (err) {
    res.status(500).json({ message: "Failed to send notification" });
  }
};

/* GET ALL NOTIFICATIONS */
export const getNotifications = async (req, res) => {
  try {
    const notifications = await Notification.find().sort({
      createdAt: -1,
    });
    res.json(notifications);
  } catch (err) {
    res.status(500).json({ message: "Failed to fetch notifications" });
  }
};

export const getNgoNotifications = async (req, res) => {
  try {
    const { ngoId } = req.params;

    // ngoId not strictly needed now, but kept for future filtering
    const notifications = await Notification.find({
      roles: { $in: ["ngo", "all"] },
    }).sort({ createdAt: -1 });

    res.status(200).json(notifications);
  } catch (error) {
    res.status(500).json({ message: "Failed to fetch notifications" });
  }
};

export const getPatientNotifications = async (req, res) => {
  try {
    const { patientId } = req.params;

    // patientId kept for future (personal notifications)
    const notifications = await Notification.find({
      roles: { $in: ["patient", "all"] },
    }).sort({ createdAt: -1 });

    res.status(200).json(notifications);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: "Failed to fetch notifications",
    });
  }
};

export const getDonorNotifications = async (req, res) => {
  try {
    const { donorId } = req.params;

    // donorId kept for future personal notifications
    const notifications = await Notification.find({
      roles: { $in: ["donor", "all"] },
    }).sort({ createdAt: -1 });

    res.status(200).json(notifications);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: "Failed to fetch notifications",
    });
  }
};