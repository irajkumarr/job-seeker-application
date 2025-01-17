const mongoose = require("mongoose");
const profileSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
      unique: true,
    },
    interestedCategories: {
      type: [String],
      validate: [
        (array) => array.length <= 5,
        "Categories cannot exceed 5 items",
      ],
      required: true,
      min: 1,
    },
    skills: {
      type: [String],
      validate: [(array) => array.length <= 5, "Skills cannot exceed 5 items"],
      required: true,
      min: 1,
    },
    currentLocation: {
      province: { type: String, required: true },
      district: { type: String, required: true },
      municipality: { type: String, required: true },
      fullAddress: { type: String, required: true },
    },
    permanentLocation: {
      province: String,
      district: String,
      municipality: String,
      fullAddress: String,
    },
    personalDetails: {
      age: { type: Number, required: true },
      gender: {
        type: String,
        enum: ["male", "female", "other"],
        required: true,
      },
      maritalStatus: {
        type: String,
        enum: ["single", "married", "divorced", "widowed"],
      },
      nationality: { type: String, required: true },
      religion: String,
      disability: {
        hasDisability: Boolean,
        details: String,
      },
      foreignEmployment: {
        hasWorkedAboroad: Boolean,
        details: String,
      },
    },
  },
  { timestamps: true }
);

const Profile = mongoose.model("Profile", profileSchema);

module.exports = Profile;
