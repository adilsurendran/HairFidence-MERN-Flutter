import mongoose from "mongoose";

const campaignSchema = new mongoose.Schema(
  {
    ngoId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Ngo",
      required: true,
    },
    name: {
      type: String,
      required: true,
    },
    location: {
      type: String,
      required: true,
    },
    date: {
      type: String,
      required: true,
    },
    time: {
      type: String,
      required: true,
    },
    description: String,
    image: String,
  },
  { timestamps: true }
);

export default mongoose.model("Campaign", campaignSchema);
