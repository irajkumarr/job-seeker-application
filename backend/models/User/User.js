// const mongoose = require("mongoose");

// const userSchema = new mongoose.Schema(
//   {
//     //basic information
//     email: {
//       type: String,
//       required: [true, "Email is required"],
//       unique: true,
//       trim: true,
//       lowercase: true,
//       match: [
//         /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/,
//         "Please enter a valid email address",
//       ],
//     },
//     password: {
//       type: String,
//       required: [true, "Password is required"],
//     },
//     userType: {
//       type: String,
//       required: [true, "User type is required"],
//       enum: ["jobseeker", "employer"],
//       default: "jobseeker",
//     },
//     mobileNumber: {
//       type: String,
//       required: [true, "Mobile number is required"],
//       unique: true,
//       trim: true,
//       match: [/^\d{10}$/, "Please enter a valid 10-digit phone number"],
//     },
//     firstName: {
//       type: String,
//       required: [true, "First name is required"],
//     },
//     lastName: {
//       type: String,
//       required: [true, "Last name is required"],
//     },
//     isActive: {
//       type: Boolean,
//       default: true,
//     },

//     //categories and skills
//     interestedCategories: {
//       type: [
//         {
//           type: String,
//           trim: true,
//         },
//       ],
//       validate: [
//         (array) => array.length <= 5,
//         "Categories cannot exceed 5 items",
//       ],
//       required: true,
//       min: 1,
//     },
//     skills: {
//       type: [
//         {
//           type: String,
//           trim: true,
//         },
//       ],
//       validate: [(array) => array.length <= 5, "Skills cannot exceed 5 items"],
//       required: true,
//       min: 1,
//     },

//     //location information
//     currentLocation: {
//       province: { type: String, required: true },
//       district: { type: String, required: true },
//       municipality: { type: String, required: true },
//       fullAddress: { type: String, required: true },
//     },
//     permanentLocation: {
//       province: String,
//       district: String,
//       municipality: String,
//       fullAddress: String,
//     },

//     //personal details
//     personalDetails: {
//       age: {
//         type: Number,
//         required: true,
//       },
//       gender: {
//         type: String,
//         enum: ["male", "female", "other"],
//         required: true,
//       },
//       maritalStatus: {
//         type: String,
//         enum: ["single", "married", "divorced", "widowed"],
//       },
//       nationality: {
//         type: String,
//         required: true,
//       },
//       religion: {
//         type: String,
//       },
//       disability: {
//         hasDisability: {
//           type: Boolean,
//         },
//         details: {
//           type: String,
//         },
//       },
//       foreignEmployment: {
//         hasWorkedAboroad: {
//           type: Boolean,
//         },
//         details: {
//           type: String,
//         },
//       },
//       //job preferences
//       jobPreferences: {
//         jobLevel: {
//           type: String,
//           enum: ["entry", "mid", "senior", "executive"],
//           required: true,
//         },
//         availabilityStatus: {
//           type: String,
//           enum: ["immediate", "15days", "30days", "custom"],
//           required: true,
//         },
//         preferredShift: {
//           type: String,
//           enum: ["day", "night", "any"],
//         },
//         expectedSalary: {
//           minimum: Number,
//           maximum: Number,
//           currency: { type: String, default: "NPR" },
//         },
//         workingStatus: {
//           type: String,
//           enum: ["employed", "unemployed", "freelancing"],
//         },
//         careerObjectives: { type: String, maxlength: 500 },
//       },

//       // Work Experience
//       workExperience: [
//         {
//           organizationName: { type: String, required: true },
//           industry: { type: String, required: true },
//           jobCategory: { type: String, required: true },
//           location: {
//             city: String,
//             country: String,
//           },
//           designation: { type: String, required: true },
//           jobLevel: { type: String, required: true },
//           startDate: { type: Date, required: true },
//           currentlyWorking: { type: Boolean, default: false },
//           endDate: Date,
//           rolesAndResponsibilities: { type: String, required: true },
//         },
//       ],

//       // Education
//       education: [
//         {
//           level: { type: String, required: true },
//           institution: { type: String, required: true },
//           major: String,
//           startDate: Date,
//           endDate: Date,
//           grade: String,
//           country: String,
//         },
//       ],

//       // Training
//       training: [
//         {
//           name: { type: String, required: true },
//           institute: { type: String, required: true },
//           duration: {
//             value: Number,
//             unit: { type: String, enum: ["days", "weeks", "months", "years"] },
//           },
//           completionYear: Number,
//         },
//       ],

//       // Language Skills
//       languages: [
//         {
//           name: { type: String, required: true },
//           proficiency: {
//             type: String,
//             enum: ["basic", "intermediate", "fluent", "native"],
//             required: true,
//           },
//         },
//       ],

//       // Documents
//       documents: [
//         {
//           title: { type: String, required: true },
//           category: {
//             type: String,
//             enum: ["resume", "cv", "citizenship", "other"],
//             required: true,
//           },
//           file: { type: String, required: true }, // URL to stored file
//           uploadDate: { type: Date, default: Date.now },
//         },
//       ],

//       // Social Accounts
//       socialAccounts: [
//         {
//           platform: {
//             type: String,
//             enum: ["linkedin", "github", "twitter", "portfolio", "other"],
//           },
//           url: { type: String, required: true },
//         },
//       ],

//       // Emergency Contact
//       emergencyContact: {
//         fullName: { type: String, required: true },
//         address: String,
//         relation: { type: String, required: true },
//         phoneNumber: { type: String, required: true },
//       },

//       // References
//       references: [
//         {
//           name: { type: String, required: true },
//           designation: { type: String, required: true },
//           organization: { type: String, required: true },
//           email: { type: String, required: true },
//           phoneNumber: { type: String, required: true },
//         },
//       ],
//     },
//   },
//   { timestamps: true }
// );

const mongoose = require("mongoose");

const userSchema = new mongoose.Schema(
  {
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
      enum: ["jobseeker", "employer"],
      default: "jobseeker",
    },
    mobileNumber: {
      type: String,
      required: [true, "Mobile number is required"],
      unique: true,
      trim: true,
      match: [/^\d{10}$/, "Please enter a valid 10-digit phone number"],
    },
    firstName: { type: String, required: true },
    lastName: { type: String, required: true },
    isActive: { type: Boolean, default: true },
  },
  { timestamps: true }
);

userSchema.pre("save", async function (next) {
  const user = this;
  if (!user.isModified("password")) return next();
  try {
    const salt = await bcrypt.genSalt(10);
    const hashPassword = await bcrypt.hash(user.password, salt);
    user.password = hashPassword;
    next();
  } catch (error) {
    return next(error);
  }
});

userSchema.methods.comparePassword = async function (enteredPassword) {
  try {
    const isMatch = await bcrypt.compare(enteredPassword, this.password);
    return isMatch;
  } catch (error) {
    throw error;
  }
};

const User = mongoose.model("User", userSchema);

module.exports = User;
