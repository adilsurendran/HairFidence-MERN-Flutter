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

export const getdetails = async(req,res)=>{
  try{
    const {id} = req.params
    const user = await Donor.findById(id);
    return res.status(200).json(user)
  }
  catch(e){
    console.log(e);
        return res.status(500).json({message:"server error"})

  }
}


export const getDonorProfile = async (req, res) => {
  try {
    const { donorId } = req.params;

    const donor = await Donor.findById(donorId)
      .populate("ngoId", "name place pincode");

    if (!donor) {
      return res.status(404).json({
        message: "Donor not found",
      });
    }

    res.status(200).json({
      _id: donor._id,
      name: donor.name,
      email: donor.email,
      phone: donor.phone,
      address: donor.address,
      pin: donor.pin,
      district: donor.district,
      gender: donor.gender,
      dob: donor.dob,
      ngoId: donor.ngoId?._id, // ✅ Flutter expects ID
      ngoDetails: donor.ngoId, // optional (future use)
    });
  } catch (err) {
    console.log(err);
    res.status(500).json({
      message: "Failed to fetch donor profile",
    });
  }
};

/* ===============================
   UPDATE DONOR PROFILE
================================ */
export const updateDonorProfile = async (req, res) => {
  try {
    const { donorId } = req.params;

    const {
      name,
      phone,
      address,
      pin,
      district,
      gender,
      dob,
      ngoId,
    } = req.body;

    const donor = await Donor.findById(donorId);

    if (!donor) {
      return res.status(404).json({
        message: "Donor not found",
      });
    }

    // Update allowed fields only
    donor.name = name ?? donor.name;
    donor.phone = phone ?? donor.phone;
    donor.address = address ?? donor.address;
    donor.pin = pin ?? donor.pin;
    donor.district = district ?? donor.district;
    donor.gender = gender ?? donor.gender;
    donor.dob = dob ?? donor.dob;
    donor.ngoId = ngoId ?? donor.ngoId; // ✅ NGO update allowed

    await donor.save();

    res.status(200).json({
      message: "Donor profile updated successfully",
    });
  } catch (err) {
    console.log(err);
    res.status(500).json({
      message: "Failed to update donor profile",
    });
  }
};