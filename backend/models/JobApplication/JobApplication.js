const mongoose = require("mongoose");

const jobPostingSchema = new mongoose.Schema(
  {
    company: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Company",
      required: [true, "Company reference is required"],
    },

    title: {
      type: String,
      required: [true, "Job title is required"],
      trim: true,
    },

    // description: {
    //   type: String,
    //   required: [true, "Job description is required"],
    //   maxlength: 5000,
    // },

    type: {
      type: String,
      enum: ["Full-Time", "Part-Time", "Contract", "Internship", "Temporary"],
      required: [true, "Job type is required"],
    },

    location: {
      province: { type: String, required: true },
      district: { type: String, required: true },
      municipality: { type: String, required: true },
      fullAddress: { type: String, required: true },
    },

    salary: {
      min: { type: Number, required: true },
      max: { type: Number },
      currency: { type: String, default: "NPR" },
    },

    expiryDate: {
      type: Date,
      required: [true, "Expiry date is required"],
    },

    // Basic Information
    basicInformation: {
      noOfVacancy: { type: Number, default: 1 },
      jobLevel: {
        type: String,
        enum: ["Entry Level", "Mid Level", "Senior Level", "Managerial"],
      },
      jobType: {
        type: String,
        enum: ["On-site", "Remote", "Hybrid"],
      },
      age: {
        min: { type: Number },
        max: { type: Number },
      },
      gender: {
        type: String,
        enum: ["Male", "Female", "Other", "Any"],
        default: "Any",
      },
      education: {
        type: String,
        required: [true, "Education level is required"],
      },
      experience: {
        minYears: { type: Number, required: true },
        maxYears: { type: Number },
      },
      shift: {
        type: String,
        enum: ["Day", "Night", "Flexible"],
        default: "Day",
      },
    },

    // Skills (1-5 skills required)
    skills: {
      type: [String],
      validate: {
        validator: function (v) {
          return v.length >= 1 && v.length <= 5;
        },
        message: "At least 1 skill and no more than 5 skills are required",
      },
    },

    // Personal Qualities (1-5 qualities required)
    personalQualities: {
      type: [String],
      validate: {
        validator: function (v) {
          return v.length >= 1 && v.length <= 5;
        },
        message: "At least 1 quality and no more than 5 qualities are required",
      },
    },

    benefits: {
      type: [String], // List of benefits (e.g., health insurance, free meals)
    },

    jobDescription: {
      type: String,
      required: [true, "Job description is required"],
    },

    allowFreshers: {
      type: Boolean,
      default: false,
    },

    applicationInstructions: {
      type: String, // Additional instructions for applying
    },
  },
  { timestamps: true }
);

const JobPosting = mongoose.model("JobPosting", jobPostingSchema);

module.exports = JobPosting;
