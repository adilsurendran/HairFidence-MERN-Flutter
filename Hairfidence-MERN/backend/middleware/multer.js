import multer from "multer";
import path from "path";

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "uploads/");
  },
  filename: (req, file, cb) => {
    cb(
      null,
      Date.now() + "-" + Math.round(Math.random() * 1e9) + path.extname(file.originalname)
    );
  },
});

const fileFilter = (req, file, cb) => {
  const allowedTypes = /jpeg|jpg|png/;
  const isValid =
    allowedTypes.test(file.mimetype) &&
    allowedTypes.test(path.extname(file.originalname).toLowerCase());

  cb(isValid ? null : new Error("Images only"), isValid);
};

export const uploadCampaignImage = multer({
  storage,
  fileFilter,
});
