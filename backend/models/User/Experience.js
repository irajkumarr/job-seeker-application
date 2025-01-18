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
      enum: ["top-level", "senior-level", "mid-level", "entry-level"],
      required: true,
    },
    startDate: { type: Date, required: true },
    currentlyWorking: { type: Boolean, default: false },
    endDate: Date,
    rolesAndResponsibilities: { type: String, required: true },
  },
  { timestamps: true }
);

const Experience = mongoose.model("Experience", experienceSchema);

module.exports = Experience;
