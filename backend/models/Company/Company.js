const mongoose = require("mongoose");

const companySchema = new mongoose.Schema(
  {
    // Company Admin/Employer Reference
    user: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: [true, "Company must be associated with a user"],
    },

    // Basic Information
    name: {
      type: String,
      required: [true, "Company name is required"],
      trim: true,
      unique: true,
      maxLength: [100, "Company name cannot exceed 100 characters"],
    },

    description: {
      type: String,
      required: [true, "Company description is required"],
      trim: true,
      maxLength: [2000, "Description cannot exceed 2000 characters"],
    },

    // Company Details
    industry: {
      type: String,
      required: [true, "Industry is required"],
      trim: true,
    },

    establishmentDate: {
      type: Date,
    },

    employeeSize: {
      type: String,
      required: [true, "Employee size is required"],
      enum: [
        "1-10",
        "11-50",
        "51-200",
        "201-500",
        "501-1000",
        "1001-5000",
        "5000+",
      ],
    },

    companyType: {
      type: String,
      enum: [
        "Private",
        "Public",
        "Government",
        "NGO",
        "INGO",
        "Startup",
        "Other",
      ],
      required: true,
    },

    registrationNumber: {
      type: String,
      unique: true,
      sparse: true, // Allows null/undefined values
    },

    // Contact & Web Presence
    website: {
      type: String,
      trim: true,
      match: [
        /^(https?:\/\/)?([\da-z.-]+)\.([a-z.]{2,6})([/\w .-]*)*\/?$/,
        "Please enter a valid URL",
      ],
    },

    email: {
      type: String,
      required: [true, "Company email is required"],
      trim: true,
      lowercase: true,
      match: [
        /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/,
        "Please enter a valid email address",
      ],
    },

    contactNumber: {
      type: String,
      required: [true, "Contact number is required"],
      trim: true,
    },

    // Location
    location: {
      province: {
        type: String,
        required: [true, "Province is required"],
      },
      district: {
        type: String,
        required: [true, "District is required"],
      },
      municipality: {
        type: String,
        required: [true, "Municipality is required"],
      },
      fullAddress: {
        type: String,
        required: [true, "Full address is required"],
      },
      coordinates: {
        type: {
          type: String,
          enum: ["Point"],
          default: "Point",
        },
        coordinates: {
          type: [Number],
          default: [0, 0], // [longitude, latitude]
        },
      },
    },

    // Media
    logo: {
      url: {
        type: String,
        required: [true, "Company logo is required"],
      },
      publicId: String, // For cloud storage reference
    },

    coverImage: {
      url: String,
      publicId: String,
    },

    // Social Media Links
    socialMedia: {
      linkedin: {
        type: String,
        trim: true,
        match: [
          /^https?:\/\/(www\.)?linkedin\.com\/.+/i,
          "Please enter a valid LinkedIn URL",
        ],
      },
      twitter: {
        type: String,
        trim: true,
        match: [
          /^https?:\/\/(www\.)?twitter\.com\/.+/i,
          "Please enter a valid Twitter URL",
        ],
      },
      facebook: {
        type: String,
        trim: true,
        match: [
          /^https?:\/\/(www\.)?facebook\.com\/.+/i,
          "Please enter a valid Facebook URL",
        ],
      },
      instagram: {
        type: String,
        trim: true,
        match: [
          /^https?:\/\/(www\.)?instagram\.com\/.+/i,
          "Please enter a valid Instagram URL",
        ],
      },
    },

    // Additional Company Information
    benefits: [
      {
        type: String,
        trim: true,
      },
    ],

    culture: {
      type: String,
      maxLength: [1000, "Culture description cannot exceed 1000 characters"],
    },

    // Verification Status
    isVerified: {
      type: Boolean,
      default: false,
    },

    verificationDetails: {
      verifiedAt: Date,
      verifiedBy: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
      },
      documents: [
        {
          title: String,
          url: String,
          publicId: String,
          uploadedAt: {
            type: Date,
            default: Date.now,
          },
        },
      ],
    },

    // Status
    status: {
      type: String,
      enum: ["active", "inactive", "suspended"],
      default: "active",
    },
  },
  {
    timestamps: true,
    toJSON: { virtuals: true },
    toObject: { virtuals: true },
  }
);

// Indexes
companySchema.index({ "location.coordinates": "2dsphere" });
companySchema.index({ name: "text", description: "text" });

// Virtual for jobs posted by company
companySchema.virtual("jobs", {
  ref: "Job",
  localField: "_id",
  foreignField: "company",
});

// Method to check if company can post new jobs
companySchema.methods.canPostJobs = function () {
  return this.isVerified && this.status === "active";
};

// Pre-save middleware for data cleaning
companySchema.pre("save", function (next) {
  // Clean URLs - ensure they start with http:// or https://
  if (this.website && !this.website.startsWith("http")) {
    this.website = "https://" + this.website;
  }

  // Clean social media links
  for (let platform in this.socialMedia) {
    if (
      this.socialMedia[platform] &&
      !this.socialMedia[platform].startsWith("http")
    ) {
      this.socialMedia[platform] = "https://" + this.socialMedia[platform];
    }
  }

  next();
});

const Company = mongoose.model("Company", companySchema);

module.exports = Company;
