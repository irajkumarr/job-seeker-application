const mongoose = require("mongoose");
const profileSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
      unique: true,
    },
    preferredCategories: {
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
    preferredJobLocation: {
      province: { type: String, required: true },
      district: { type: String, required: true },
      municipality: { type: String, required: true },
      fullAddress: { type: String, required: true },
    },
    personalDetails: {
      age: {
        type: Number,
        required: true,
      },
      experience: {
        type: Number,
        required: true,
      },
      gender: {
        type: String,
        enum: ["male", "female", "other"],
        required: true,
      },
      maritalStatus: {
        type: String,
        enum: ["single", "married", "divorced", "widowed"],
      },
      nationality: {
        type: String,
      },
      religion: String,
      email: {
        type: String,
        // required: [true, "Email is required"],
        trim: true,
        lowercase: true,
        match: [
          /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/,
          "Please enter a valid email address",
        ],
      },
      disability: {
        hasDisability: Boolean,
        details: String,
      },

      foreignEmployment: {
        hasWorkedAboroad: Boolean,
        details: String,
      },
    },
    //job preference
    jobPreference: {
      jobLevel: {
        type: String,
        enum: ["Top Level", "Senior Level", "Mid Level", "Entry Level"],
        // required: true,
      },
      workingStatus: {
        type: String,
        enum: [
          "Actively Seeking Employment",
          "Available For Employment",
          "Currently Working",
        ],
      },
      availabilityStatus: {
        type: String,
        enum: [
          "Full Time",
          "Part Time",
          "Contractual",
          "Freelancing",
          "Intenship",
          "Volunteer",
          "Temporary",
          "Traineeship",
        ],
        // required: true,
      },
      preferredShift: {
        type: String,
        enum: [
          "Regular",
          "Morning",
          "Day",
          "Evening",
          "Flexible",
          "Anytime",
          "Night",
        ],
      },
      // expectedSalary: {
      //   type: String,
      //   required: true,
      // },
      currentSalary: {
        currency: {
          type: String,
          enum: ["NPR."],
          default: "NPR.",
          required: true,
          trim: true,
        },
        value: {
          type: Number,
          required: true,
          min: 0,
        },
        valueType: {
          // New field to indicate "above", "below", or "equals"
          type: String,
          enum: ["Above", "Equals", "Below"],
          required: true, // Make it required
          trim: true,
        },
        duration: {
          type: String,
          required: true,
          enum: ["per Hour", "per Day", "per Week", "per Month", "per Year"],
          trim: true,
        },
        amount: { type: Number, required: true, min: 0 },
      },
      expectedSalary: {
        currency: {
          type: String,
          enum: ["NPR."],
          default: "NPR.",
          required: true,
          trim: true,
        },
        valueType: {
          // New field to indicate "above", "below", or "equals"
          type: String,
          enum: ["Above", "Equals", "Below"],
          required: true, // Make it required
          trim: true,
        },
        duration: {
          type: String,
          required: true,
          enum: ["per Hour", "per Day", "per Week", "per Month", "per Year"],
          trim: true,
        },
        amount: { type: Number, required: true, min: 0 },
      },

      careerObjectives: { type: String, maxlength: 500 },
    },
  },
  { timestamps: true }
);

const Profile = mongoose.model("Profile", profileSchema);

module.exports = Profile;
