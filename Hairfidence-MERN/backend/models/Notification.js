import mongoose from "mongoose";

const notificationSchema = new mongoose.Schema(
  {
    title: {
      type: String,
      required: true,
    },
    message: {
      type: String,
      required: true,
    },
    roles: {
      type: [String], // ['donor', 'patient', 'ngo','all]
      required: true,
    }
  },
  { timestamps: true }
);

export default mongoose.model("Notification", notificationSchema);
