import mongoose from "mongoose";

const ngoSchema = new mongoose.Schema(
  {
    loginId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Login",
      required: true,
    },
    name: {
      type: String,
      required: true,
      trim: true,
    },
    contactPerson: {
      type: String,
      required: true,
    },
    phone: {
      type: String,
      required: true,
    },
    email: {
      type: String,
      lowercase: true,
    },
    state: String,
    city: String,
    place: String,
    pincode: String,
  },
  { timestamps: true }
);

export default mongoose.model("Ngo", ngoSchema);
