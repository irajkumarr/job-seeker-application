const mongoose = require("mongoose");

const userSchema = new mongoose.Schema(
  {
    //basic information
    email: {
      type: String,
      required: [true, "Email is required"],
      unique: true,
      trim: true,
      lowercase: true,
      match: [
        /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/,
        "Please enter a valid email address",
      ],
    },
    password: {
      type: String,
      required: [true, "Password is required"],
    },
    userType: {
      type: String,
      required: [true, "User type is required"],
      enum: ["Jobseeker", "Employer"],
      default: "Jobseeker",
    },
    mobileNumber: {
      type: String,
      required: [true, "Mobile number is required"],
      unique: true,
      trim: true,
      match: [/^\d{10}$/, "Please enter a valid 10-digit phone number"],
    },
    firstName: {
      type: String,
      required: [true, "First name is required"],
    },
    lastName: {
      type: String,
      required: [true, "Last name is required"],
    },
    isActive: {
      type: Boolean,
      default: true,
    },

    //categories and skills
    interestedCategories: {
      type: [
        {
          type: String,
          trim: true,
        },
      ],
      validate: [
        (array) => array.length <= 5,
        "Categories cannot exceed 5 items",
      ],
      required: true,
      min: 1,
    },
    skills: {
      type: [
        {
          type: String,
          trim: true,
        },
      ],
      validate: [(array) => array.length <= 5, "Skills cannot exceed 5 items"],
      required: true,
      min: 1,
    },

    //location information
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

    //personal details
    personalDetails: {
      age: {
        type: Number,
        required: true,
      },
      gender: {
        type: String,
        enum: ["Male", "Female", "Other"],
        required: true,
      },
      maritalStatus: {
        type: String,
        enum: ["Single", "Married", "Divorced", "Widowed"],
      },
      nationality: {
        type: String,
        required: true,
      },
      religion: {
        type: String,
      },
      disability: {
        hasDisability: {
          type: Boolean,
        },
        details: {
          type: String,
        },
      },
      foreignEmployment: {
        hasWorkedAboroad: {
          type: Boolean,
        },
        details: {
          type: String,
        },
      },
      //job preferences
    },
  },
  { timestamps: true }
);

const User = mongoose.model("User", userSchema);

module.exports = User;
