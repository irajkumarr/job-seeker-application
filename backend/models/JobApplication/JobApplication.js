const mongoose = require("mongoose");

const jobApplicationSchema = new mongoose.Schema(
  {
    job: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "JobPosting",
      required: true,
    },
    applicant: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },

    coverLetter: {
      type: String,
      maxlength: 2000,
    },
    status: {
      type: String,
      enum: ["pending", "shortlisted", "rejected", "hired", "withdrawn"],
      default: "pending",
    },
    appliedAt: {
      type: Date,
      default: Date.now,
    },
    updatedAt: {
      type: Date,
      default: Date.now,
    },
    notes: [
      {
        addedBy: {
          type: mongoose.Schema.Types.ObjectId,
          ref: "User", // Typically the employer/admin
        },
        content: {
          type: String,
          maxlength: 1000,
        },
        addedAt: {
          type: Date,
          default: Date.now,
        },
      },
    ],
    feedback: {
      type: String,
      maxlength: 2000, // Optional field for employer feedback
    },

    status: {
      type: String,
      enum: [
        "applied",
        "under_review",
        "shortlisted",
        "interview_scheduled",
        "interviewed",
        "offer_extended",
        "offer_accepted",
        "offer_declined",
        "rejected",
        "withdrawn",
      ],
    },
  },
  { timestamps: true }
);

const JobApplication = mongoose.model("JobApplication", jobApplicationSchema);

module.exports = JobApplication;
