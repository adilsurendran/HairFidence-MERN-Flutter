import Conversation from "../models/Conversation.js";

export const createOrGetConversation = async (req, res) => {
  try {
    const {
      profileId,          // NGO profileId
      profileRole,        // "ngo"
      otherProfileId,     // donor _id
      otherProfileRole,   // "donor"
    } = req.body;

    if (
      !profileId ||
      !profileRole ||
      !otherProfileId ||
      !otherProfileRole
    ) {
      return res.status(400).json({ message: "All fields required" });
    }

    // ❌ NGO cannot initiate chat with patient (rule safe-guard)
    if (profileRole === "ngo" && otherProfileRole === "patient") {
      return res.status(403).json({
        message: "NGO cannot initiate chat with patient",
      });
    }

    // 🔍 Check existing conversation
    let conversation = await Conversation.findOne({
      "participants.userId": { $all: [profileId, otherProfileId] },
    });

    if (conversation) {
      return res.json({
        conversationId: conversation._id,
        isNew: false,
      });
    }

    // 🆕 Create new conversation
    conversation = await Conversation.create({
      participants: [
        { userId: profileId, role: profileRole },
        { userId: otherProfileId, role: otherProfileRole },
      ],
      createdByRole: profileRole,
    });

    res.status(201).json({
      conversationId: conversation._id,
      isNew: true,
    });
  } catch (err) {
    console.error("Create/Get Chat Error:", err);
    res.status(500).json({ message: "Server error" });
  }
};


import Message from "../models/Message.js";
import ConversationRead from "../models/ConversationRead.js";
import Donor from "../models/Donor.js";
import Patient from "../models/Patient.js";
import ngo from "../models/ngo.js";

export const getMyChats = async (req, res) => {
  try {
    const { profileId, profileRole } = req.body;

    if (!profileId || !profileRole) {
      return res.status(400).json({ message: "profileId required" });
    }

    const conversations = await Conversation.find({
      "participants.userId": profileId,
    }).sort({ lastMessageAt: -1 });

    const result = [];

    for (const convo of conversations) {
      const other = convo.participants.find(
        (p) => p.userId.toString() !== profileId
      );

      if (!other) continue;

      let otherProfile = null;

      if (other.role === "donor") {
        otherProfile = await Donor.findById(other.userId).select("name");
      } else if (other.role === "ngo") {
        otherProfile = await ngo.findById(other.userId).select("name");
      } else if (other.role === "patient") {
        otherProfile = await Patient.findById(other.userId).select("name");
      }

      const read = await ConversationRead.findOne({
        conversationId: convo._id,
        userId: profileId,
      });

      const lastReadAt = read?.lastReadAt || new Date(0);

      const unreadCount = await Message.countDocuments({
        conversationId: convo._id,
        senderId: { $ne: profileId },
        createdAt: { $gt: lastReadAt },
      });

      result.push({
        conversationId: convo._id,
        name: otherProfile?.name || "Unknown",
        role: other.role,
        lastMessage: convo.lastMessage,
        lastMessageAt: convo.lastMessageAt,
        unreadCount,
      });
    }

    res.json(result);
  } catch (err) {
    console.error("Chat List Error:", err);
    res.status(500).json({ message: "Server error" });
  }
};


export const sendMessage = async (req, res) => {
  try {
    const { conversationId, senderId, senderRole, message } = req.body;

    if (!conversationId || !senderId || !senderRole || !message) {
      return res.status(400).json({ message: "All fields required" });
    }

    const msg = await Message.create({
      conversationId,
      senderId,
      senderRole,
      message,
    });

    await Conversation.findByIdAndUpdate(conversationId, {
      lastMessage: message,
      lastMessageAt: new Date(),
    });

    res.status(201).json(msg);
  } catch (err) {
    console.error("Send Message Error:", err);
    res.status(500).json({ message: "Server error" });
  }
};

export const getMessages = async (req, res) => {
  try {
    const { conversationId } = req.params;

    const messages = await Message.find({ conversationId }).sort({
      createdAt: 1,
    });

    res.json(messages);
  } catch (err) {
    res.status(500).json({ message: "Server error" });
  }
};


export const getDonorsByNgo = async (req, res) => {
  try {
    const { profileId } = req.params;

    if (!profileId) {
      return res.status(400).json({
        message: "NGO profileId is required",
      });
    }

    const donors = await Donor.find({ ngoId: profileId })
      .select("name email phone") // only needed fields
      .sort({ createdAt: -1 });

    res.status(200).json(donors);
  } catch (error) {
    console.error("Get Donors Error:", error);
    res.status(500).json({
      message: "Failed to fetch donors",
    });
  }
};


/**
 * Mark conversation as read for a user
 */
export const markAsRead = async (req, res) => {
  try {
    const { conversationId, profileId } = req.body;

    if (!conversationId || !profileId) {
      return res.status(400).json({
        message: "conversationId and profileId are required",
      });
    }

    await ConversationRead.findOneAndUpdate(
      {
        conversationId,
        userId: profileId,
      },
      {
        lastReadAt: new Date(),
      },
      {
        upsert: true,
        new: true,
      }
    );

    res.status(200).json({
      message: "Conversation marked as read",
    });
  } catch (error) {
    console.error("Mark Read Error:", error);
    res.status(500).json({
      message: "Failed to mark conversation as read",
    });
  }
};
