import mongoose from "mongoose";

const donorSchema = new mongoose.Schema(
  {
    loginId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Login",
      required: true,
      unique: true,
    },

    ngoId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Ngo",
      required: true,
    },

    name: { type: String, required: true },
    email: { type: String, required: true, unique: true },
    phone: { type: String, required: true },
    address: { type: String, required: true },
    pin: { type: String, required: true },
    district: { type: String, required: true },
    gender: { type: String, enum: ["Male", "Female"], required: true },
    dob: { type: String, required: true },
  },
  { timestamps: true }
);

export default mongoose.model("Donor", donorSchema);
