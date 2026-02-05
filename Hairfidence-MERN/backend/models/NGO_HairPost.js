import mongoose from "mongoose";

const hairPostSchema = new mongoose.Schema(
  {
    ngoId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },

    title: { type: String, required: true },
    hairLength: { type: Number, required: true },
    hairType: { type: String, required: true },
    hairColor: { type: String, required: true },
    chemicallyTreated: {
      type: String,
      enum: ["yes", "no"],
      default: "no",
    },

    greyHair: {
      type: String,
      enum: ["yes", "no"],
      default: "no",
    },

    quantity: { type: Number, required: true },
    condition: { type: String, required: true },
    location: { type: String, required: true },
    description: { type: String },
    status:{type:String, default:"active",enum:["active", "closed"]}
  },
  { timestamps: true }
);

export default mongoose.model("HairPost", hairPostSchema);
