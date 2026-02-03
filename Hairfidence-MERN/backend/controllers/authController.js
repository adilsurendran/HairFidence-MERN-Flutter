import bcrypt from "bcryptjs";
import Login from "../models/login.js";
import Ngo from "../models/ngo.js";
import Donor from "../models/Donor.js";
import Patient from "../models/Patient.js";


export const loginUser = async (req, res) => {
  console.log(req.body);
  
  try {
    const { username, password } = req.body;

    // basic validation
    if (!username || !password) {
      return res.status(400).json({ message: "All fields are required" });
    }

    const user = await Login.findOne({ username });

    if (!user) {
      return res.status(401).json({ message: "Invalid credentials" });
    }

    if (!user.verified) {
      return res.status(403).json({ message: "Account not verified" });
    }

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(401).json({ message: "Invalid credentials" });
    }

    let profileId = null;

    // role-based profile lookup
    if (user.role === "ngo") {
      const ngo = await Ngo.findOne({ loginId: user._id });
      profileId = ngo?._id;
    }

    if (user.role === "donor") {
      const donor = await Donor.findOne({ loginId: user._id });
      profileId = donor?._id;
    }

    if (user.role === "patient") {
      const patient = await Patient.findOne({ loginId: user._id });
      profileId = patient?._id;
    }

    res.status(200).json({
      message: "Login successful",
      loginId: user._id,
      role: user.role,
      profileId, // ngoId / donorId / patientId
    });
  } catch (error) {
    res.status(500).json({
      message: "Login failed",
      error: error.message,
    });
  }
};
