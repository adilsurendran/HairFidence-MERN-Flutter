import mongoose from "mongoose";

const patientPostSchema = new mongoose.Schema(
  {
    patientId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Patient",
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

    quantity: {
      type: Number,
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
      enum: ["active", "closed"],
      default: "active",
    },
  },
  { timestamps: true }
);

export default mongoose.model("PatientPost", patientPostSchema);
