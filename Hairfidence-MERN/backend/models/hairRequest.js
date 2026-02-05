import mongoose from "mongoose";

const hairRequestSchema = new mongoose.Schema(
  {
    postId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "HairPost",
      required: true,
    },

    profileId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Patient",
      required: true,
    },

    status: {
      type: String,
      enum:["pending","approved","delivered","rejected","cancelled","soldout"],
      default: "pending", // pending | approved | rejected
    },
  },
  { timestamps: true }
);

export default mongoose.model("HairRequest", hairRequestSchema);
