import mongoose from "mongoose";

const conversationReadSchema = new mongoose.Schema(
  {
    conversationId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Conversation",
      required: true,
      index: true,
    },

    userId: {
      type: mongoose.Schema.Types.ObjectId,
      required: true,
      index: true,
    },

    lastReadAt: {
      type: Date,
      default: null,
    },
  },
  { timestamps: true }
);

/**
 * One read state per user per conversation
 */
conversationReadSchema.index(
  { conversationId: 1, userId: 1 },
  { unique: true }
);

export default mongoose.model("ConversationRead", conversationReadSchema);
