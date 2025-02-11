const Profile = require("../../models/User/Profile");
const JobPosting = require("../../models/JobPosting/JobPosting");
const handleCreateProfile = async (req, res) => {
  const {
    preferredCategories,
    skills,
    preferredJobLocation,
    personalDetails,
    jobPreference,
  } = req.body;
  const userId = req.user.id;

  try {
    if (!userId) {
      return res.status(400).json({
        status: false,
        message: "User ID is required to create a profile.",
      });
    }

    if (!preferredCategories || preferredCategories.length === 0) {
      return res.status(400).json({
        status: false,
        message: "At least one preferred category is required.",
      });
    }

    if (!skills || skills.length === 0) {
      return res.status(400).json({
        status: false,
        message: "At least one skill is required.",
      });
    }

    if (
      !preferredJobLocation ||
      !preferredJobLocation.province ||
      !preferredJobLocation.district ||
      !preferredJobLocation.municipality ||
      !preferredJobLocation.fullAddress
    ) {
      return res.status(400).json({
        status: false,
        message: "Current location fields are required.",
      });
    }

    if (
      !personalDetails ||
      !personalDetails.age ||
      !personalDetails.gender ||
      !personalDetails.experience ||
      !personalDetails.foreignEmployment
    ) {
      return res.status(400).json({
        status: false,
        message:
          "Personal details (age, gender, experience, expected salary) are required.",
      });
    }
    // if (
    //   !jobPreference ||
    //   !jobPreference.jobLevel ||
    //   !jobPreference.availabilityStatus ||
    //   !jobPreference.preferredShift ||
    //   !jobPreference.careerObjectives
    // ) {
    //   return res.status(400).json({
    //     status: false,
    //     message:
    //       "Job Preference (job level, availability status, preferred shift, working status) are required.",
    //   });
    // }

    const newProfile = new Profile({
      userId,
      preferredCategories,
      skills,
      preferredJobLocation,
      personalDetails,
      jobPreference,
    });

    await newProfile.save();

    return res
      .status(201)
      .json({ status: true, message: "User Profile created successfully!" });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleGetProfile = async (req, res) => {
  const userId = req.user.id;
  try {
    const profile = await Profile.findOne(
      { userId: userId },
      { createdAt: 0, updatedAt: 0, __v: 0 }
    );
    return res.status(200).json(profile);
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};
const handleUpdateProfile = async (req, res) => {
  const userId = req.user.id;
  // console.log(req.body);
  try {
    const profile = await Profile.findOne({ userId });

    if (!profile) {
      return res.status(404).json({
        status: false,
        message: "Profile not found",
      });
    }

    const updateFields = {};

    // Handle top-level fields
    ["preferredCategories", "skills"].forEach((field) => {
      if (req.body[field]) {
        updateFields[field] = req.body[field];
      }
    });

    // Handle preferred job location
    if (req.body.preferredJobLocation) {
      ["province", "district", "municipality", "fullAddress"].forEach(
        (field) => {
          if (req.body.preferredJobLocation[field]) {
            updateFields[`preferredJobLocation.${field}`] =
              req.body.preferredJobLocation[field];
          }
        }
      );
    }

    // Handle personal details fields (support both direct and nested)
    const personalDetailsFields = [
      "age",
      "experience",
      "gender",
      "maritalStatus",
      "nationality",
      "religion",
      "email",
    ];

    personalDetailsFields.forEach((field) => {
      if (req.body[field] !== undefined) {
        updateFields[`personalDetails.${field}`] = req.body[field];
      }
    });

    // Ensure `disability` exists as an object before setting properties
    if (req.body.disability) {
      updateFields["personalDetails.disability"] = {
        hasDisability: req.body.disability.hasDisability ?? false,
        details: req.body.disability.details ?? "",
      };
    }

    // Ensure `foreignEmployment` exists as an object before setting properties
    if (req.body.foreignEmployment) {
      updateFields["personalDetails.foreignEmployment"] = {
        hasWorkedAboroad: req.body.foreignEmployment.hasWorkedAboroad ?? false,
        details: req.body.foreignEmployment.details ?? "",
      };
    }

    // Handle top-level job preference fields (only if jobPreference exists)
    if (
      req.body.jobLevel ||
      req.body.availabilityStatus ||
      req.body.preferredShift ||
      req.body.careerObjectives ||
      req.body.workingStatus
    ) {
      const jobPreferenceFields = [
        "jobLevel",
        "availabilityStatus",
        "preferredShift",
        "careerObjectives",
        "workingStatus",
      ];

      jobPreferenceFields.forEach((field) => {
        if (req.body[field] !== undefined && req.body[field] !== null) {
          updateFields[`jobPreference.${field}`] = req.body[field];
        }
      });

      // Ensure currentSalary and expectedSalary are processed correctly
      if (req.body.currentSalary && req.body.currentSalary !== null) {
        const { amount, currency, valueType, duration } =
          req.body.currentSalary;
        if (
          amount !== undefined &&
          currency !== undefined &&
          valueType !== undefined &&
          duration !== undefined
        ) {
          updateFields["jobPreference.currentSalary"] = {
            amount,
            currency,
            valueType,
            duration,
          };
        }
      }

      // Handle expectedSalary (if it exists)
      if (req.body.expectedSalary && req.body.expectedSalary !== null) {
        const { amount, currency, valueType, duration } =
          req.body.expectedSalary;
        if (
          amount !== undefined &&
          currency !== undefined &&
          valueType !== undefined &&
          duration !== undefined
        ) {
          updateFields["jobPreference.expectedSalary"] = {
            amount,
            currency,
            valueType,
            duration,
          };
        }
      }
    }

    // Check for duplicate email
    if (req.body.personalDetails?.email) {
      const existingProfileWithEmail = await Profile.findOne({
        "personalDetails.email": req.body.personalDetails.email,
        userId: { $ne: userId },
      });

      if (existingProfileWithEmail) {
        return res.status(400).json({
          status: false,
          message: "Email already in use by another profile",
        });
      }
    }

    // Perform the update
    const updatedUserProfile = await Profile.findOneAndUpdate(
      { userId },
      { $set: updateFields },
      {
        new: true,
        runValidators: true,
        select: "-__v -createdAt -updatedAt",
        // upsert: false,
      }
    );

    if (!updatedUserProfile) {
      return res.status(404).json({
        status: false,
        message: "User Profile not updated",
      });
    }

    return res.status(200).json({
      status: true,
      message: "User profile updated successfully",
      profile: updatedUserProfile,
    });
  } catch (error) {
    console.error("Profile update error:", error);
    return res.status(500).json({
      status: false,
      message: error.message || "Internal server error",
    });
  }
};

const handleGetMatchedJobs = async (req, res) => {
  try {
    const userId = req.user.id;

    // Fetch the user's profile
    const profile = await Profile.findOne({ userId });
    if (!profile) {
      return res.status(404).json({ message: "Profile not found" });
    }

    const { preferredCategories, preferredJobLocation } = profile;

    // Fetch jobs that match the preferred location
    const matchedJobs = await JobPosting.find({
      "location.district": preferredJobLocation.district, // Match location
    }).populate({
      path: "company",
      populate: {
        path: "industry",
        match: { name: { $in: preferredCategories } }, // Try matching industry
      },
    });

    // 🚀 Filter out jobs where `company.industry` is null
    const filteredJobs = matchedJobs.filter(
      (job) => job.company && job.company.industry
    );

    if (filteredJobs.length === 0) {
      return res.status(200).json({ message: "No matched jobs found" });
    }

    res.status(200).json(filteredJobs);
  } catch (error) {
    res.status(500).json({ message: "An error occurred", error });
  }
};

module.exports = {
  handleCreateProfile,
  handleGetProfile,
  handleUpdateProfile,
  handleGetMatchedJobs,
};
