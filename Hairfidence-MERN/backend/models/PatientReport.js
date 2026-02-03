import mongoose from "mongoose";

const patientReportSchema = new mongoose.Schema(
  {
    patientId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Patient",
      required: true,
    },

    title: {
      type: String,
      required: true,
      trim: true,
    },

    reportType: {
      type: String,
      required: true,
    },

    hospital: {
      type: String,
      required: true,
    },

    reportDate: {
      type: String,
      required: true,
    },

    image: {
      type: String,
      required: true, // prescription image
    },
  },
  { timestamps: true }
);

export default mongoose.model("PatientReport", patientReportSchema);
