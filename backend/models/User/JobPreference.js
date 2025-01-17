const mongoose = require("mongoose");
const jobPreferenceSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
      unique: true,
    },
    jobLevel: {
      type: String,
      enum: ["entry", "mid", "senior", "executive"],
      required: true,
    },
    availabilityStatus: {
      type: String,
      enum: ["immediate", "15days", "30days", "custom"],
      required: true,
    },
    preferredShift: {
      type: String,
      enum: ["day", "night", "any"],
    },
    expectedSalary: {
      minimum: Number,
      maximum: Number,
      currency: { type: String, default: "NPR" },
    },
    workingStatus: {
      type: String,
      enum: ["employed", "unemployed", "freelancing"],
    },
    careerObjectives: { type: String, maxlength: 500 },
  },
  { timestamps: true }
);

const JobPreference = mongoose.model("JobPreference", jobPreferenceSchema);

module.exports = JobPreference;
