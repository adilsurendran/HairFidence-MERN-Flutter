import bcrypt from "bcryptjs";
import Login from "../models/login.js";
import Ngo from "../models/ngo.js";


export const addNgo = async (req, res) => {
    console.log(req.body);
    
  try {
    const {
      password,
      name,
      contactPerson,
      phone,
      email,
      state,
      city,
      place,
      pincode,
    } = req.body;

    // basic validation
    if (!email || !password || !name || !contactPerson || !phone) {
      return res.status(400).json({
        message: "Required fields are missing",
      });
    }

    // email is username
    const existingUser = await Login.findOne({ username: email });
    if (existingUser) {
      return res.status(400).json({
        message: "NGO login already exists with this email",
      });
    }

    // hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    // create login
    const login = await Login.create({
      username: email,
      password: hashedPassword,
      role: "ngo",
      verified: true,
    });

    // create ngo with loginId as common key
    const ngo = await Ngo.create({
      loginId: login._id,
      name,
      contactPerson,
      phone,
      email,
      state,
      city,
      place,
      pincode,
    });

    res.status(201).json({
      message: "NGO added successfully",
      ngo,
    });
  } catch (error) {
    res.status(500).json({
      message: "Failed to add NGO",
      error: error.message,
    });
  }
};

export const getAllNgos = async (req, res) => {
  try {
    const ngos = await Ngo.find().populate("loginId", "username");
    res.status(200).json(ngos);
  } catch (error) {
    res.status(500).json({ message: "Failed to fetch NGOs" });
  }
};

/* ===========================
   GET SINGLE NGO
=========================== */
export const getNgoById = async (req, res) => {
  try {
    const ngo = await Ngo.findById(req.params.id).select("name contactPerson phone state city place pincode -_id");
    if (!ngo) return res.status(404).json({ message: "NGO not found" });
    res.status(200).json(ngo);
  } catch (error) {
    res.status(500).json({ message: "Failed to fetch NGO" });
  }
};

/* ===========================
   UPDATE NGO
=========================== */
export const updateNgo = async (req, res) => {
  try {
    const ngo = await Ngo.findByIdAndUpdate(req.params.id, req.body, {
      new: true,
    });

    if (!ngo) return res.status(404).json({ message: "NGO not found" });

    res.status(200).json({ message: "NGO updated", ngo });
  } catch (error) {
    res.status(500).json({ message: "Failed to update NGO" });
  }
};

/* ===========================
   DELETE NGO + LOGIN
=========================== */
export const deleteNgo = async (req, res) => {
  try {
    const ngo = await Ngo.findById(req.params.id);
    if (!ngo) return res.status(404).json({ message: "NGO not found" });

    await Login.findByIdAndDelete(ngo.loginId);
    await Ngo.findByIdAndDelete(req.params.id);

    res.status(200).json({ message: "NGO deleted successfully" });
  } catch (error) {
    res.status(500).json({ message: "Failed to delete NGO" });
  }
};