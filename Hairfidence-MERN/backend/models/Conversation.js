// import mongoose from "mongoose";

// const participantSchema = new mongoose.Schema(
//   {
//     userId: {
//       type: mongoose.Schema.Types.ObjectId,
//       required: true,
//     },

//     role: {
//       type: String,
//       enum: ["ngo", "donor", "patient"],
//       required: true,
//     },
//   },
//   { _id: false }
// );

// const conversationSchema = new mongoose.Schema(
//   {
//     participants: {
//       type: [participantSchema],
//       required: true,
//       validate: {
//         validator: (arr) => arr.length === 2,
//         message: "Conversation must have exactly 2 participants",
//       },
//     },

//     lastMessage: {
//       type: String,
//       default: "",
//     },

//     lastMessageAt: {
//       type: Date,
//       default: null,
//     },

//     createdByRole: {
//       type: String,
//       enum: ["ngo", "donor", "patient"],
//       required: true,
//     },

//     isActive: {
//       type: Boolean,
//       default: true,
//     },
//   },
//   { timestamps: true }
// );

// /**
//  * Prevent duplicate conversations between same two users
//  */
// conversationSchema.index(
//   { "participants.userId": 1 },
//   { unique: true }
// );

// export default mongoose.model("Conversation", conversationSchema);


import mongoose from "mongoose";

const participantSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      required: true,
    },
    role: {
      type: String,
      enum: ["ngo", "donor", "patient"],
      required: true,
    },
  },
  { _id: false }
);

const conversationSchema = new mongoose.Schema(
  {
    participants: {
      type: [participantSchema],
      required: true,
      validate: {
        validator: (arr) => arr.length === 2,
        message: "Conversation must have exactly 2 participants",
      },
    },

    lastMessage: {
      type: String,
      default: "",
    },

    lastMessageAt: {
      type: Date,
      default: null,
    },

    createdByRole: {
      type: String,
      enum: ["ngo", "donor", "patient"],
      required: true,
    },
  },
  { timestamps: true }
);

/**
 * ❌ DO NOT ADD UNIQUE INDEX HERE
 * Duplicate prevention is handled in controller
 */

export default mongoose.model("Conversation", conversationSchema);
