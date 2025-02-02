const mongoose = require("mongoose");
const experienceSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    organizationName: { type: String, required: true },
    industry: { type: String, required: true },
    jobCategory: { type: String, required: true },
    location: {
      type: String,
      required: true,
    },
    designation: { type: String, required: true },
    jobLevel: {
      type: String,
      enum: ["Top Level", "Senior Level", "Mid Level", "Entry Level"],
      required: true,
    },
    startDate: {
      year: String,
      month: String,
    },
    currentlyWorking: { type: Boolean, default: false },
    endDate: {
      year: String,
      month: String,
    },
    rolesAndResponsibilities: { type: String, required: true },
  },
  { timestamps: true }
);

const Experience = mongoose.model("Experience", experienceSchema);

module.exports = Experience;
