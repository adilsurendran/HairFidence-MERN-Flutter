import Campaign from "../models/campaign.js";

/* ================= ADD CAMPAIGN ================= */
export const addCampaign = async (req, res) => {
  try {
    const { name, location, date, time, description } = req.body;
    const ngoId = req.body.ngoId;

    const campaign = await Campaign.create({
      ngoId,
      name,
      location,
      date,
      time,
      description,
      image: req.file ? req.file.filename : null,
    });

    res.status(201).json({ message: "Campaign added", campaign });
  } catch (error) {
    res.status(500).json({ message: "Failed to add campaign" });
  }
};

/* ================= GET NGO CAMPAIGNS ================= */
export const getNgoCampaigns = async (req, res) => {
  try {
    const campaigns = await Campaign.find({ ngoId: req.params.ngoId });
    res.status(200).json(campaigns);
  } catch (error) {
    res.status(500).json({ message: "Failed to fetch campaigns" });
  }
};

/* ================= DELETE CAMPAIGN ================= */
export const deleteCampaign = async (req, res) => {
  try {
    await Campaign.findByIdAndDelete(req.params.id);
    res.status(200).json({ message: "Campaign deleted" });
  } catch (error) {
    res.status(500).json({ message: "Delete failed" });
  }
};

export const updateCampaign = async (req, res) => {
  try {
    const updatedData = {
      ...req.body,
    };

    if (req.file) {
      updatedData.image = req.file.filename;
    }

    const campaign = await Campaign.findByIdAndUpdate(
      req.params.id,
      updatedData,
      { new: true }
    );

    res.status(200).json({ message: "Campaign updated", campaign });
  } catch (error) {
    res.status(500).json({ message: "Update failed" });
  }
};