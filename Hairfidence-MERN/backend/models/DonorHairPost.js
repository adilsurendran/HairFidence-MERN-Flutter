import mongoose from "mongoose";

const donorHairPostSchema = new mongoose.Schema(
  {
    donorId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Donor",
      required: true,
    },

    ngoId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Ngo",
      required: true,
    },

    title: {
      type: String,
      required: true,
    },

    donationDate: {
      type: String,
      required: true,
    },

    hairLength: {
      type: Number,
      required: true,
    },

    hairType: {
      type: String,
      required: true,
      enum: ["Straight", "Wavy", "Curly"],
    },

    hairColor: {
      type: String,
      required: true,
    },

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

    quantity: {
      type: Number,
      default:null
    },

    condition: {
      type: String,
      required: true,
    },

    location: {
      type: String,
      required: true,
    },

    description: {
      type: String,
    },

    status: {
      type: String,
      enum: ["pending","approved","rejected", "collected"],
      default: "pending",
    },
    rejectNote:{
        type:String, default:null
    }
  },
  { timestamps: true }
);

export default mongoose.model("DonorHairPost", donorHairPostSchema);
