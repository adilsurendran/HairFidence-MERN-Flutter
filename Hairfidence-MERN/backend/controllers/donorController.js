import bcrypt from "bcryptjs";
import Login from "../models/login.js";
import Donor from "../models/Donor.js";
import Ngo from "../models/ngo.js";

export const registerDonor = async (req, res) => {
    console.log(req.body);
    
  try {
    const {
      name,
      email,
      phone,
      address,
      pin,
      district,
      password,
      gender,
      dob,
      ngoId,
    } = req.body;

    if (
      !name ||
      !email ||
      !phone ||
      !address ||
      !pin ||
      !district ||
      !password ||
      !gender ||
      !dob ||
      !ngoId
    ) {
      return res.status(400).json({
        message: "All fields including NGO are required",
      });
    }

    const ngoExists = await Ngo.findById(ngoId);
    if (!ngoExists) {
      return res.status(404).json({ message: "Selected NGO not found" });
    }

    const existingLogin = await Login.findOne({ username: email });
    if (existingLogin) {
      return res.status(409).json({ message: "User already registered" });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const login = await Login.create({
      username: email,
      password: hashedPassword,
      role: "donor",
    });

    const donor = await Donor.create({
      loginId: login._id,
      ngoId,
      name,
      email,
      phone,
      address,
      pin,
      district,
      gender,
      dob,
    });

    res.status(201).json({
      message: "Donor registered successfully",
      loginId: login._id,
      profileId: donor._id,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Donor registration failed" });
  }
};

export const getAllNgos = async (req, res) => {
  try {
    const ngos = await Ngo.find(
      {},
      {
        name: 1,
        place: 1,
        pincode: 1,
      }
    ).sort({ name: 1 });

    res.status(200).json(ngos);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Failed to fetch NGOs" });
  }
};