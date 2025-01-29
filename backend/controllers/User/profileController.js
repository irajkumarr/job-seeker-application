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
      !personalDetails.nationality ||
      !personalDetails.email
    ) {
      return res.status(400).json({
        status: false,
        message:
          "Personal details (age, gender, nationality, email) are required.",
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
  const userId = req.user.id; // Assuming req.user.id contains the authenticated user's ID

  try {
    // First check if profile exists
    const profile = await Profile.findOne({ userId });

    if (!profile) {
      return res.status(404).json({
        status: false,
        message: "Profile not found",
      });
    }

    // Create an update object for nested fields
    const updateFields = {};

    // Handle flat fields (top-level fields)
    ["interestedCategories", "skills"].forEach((field) => {
      if (req.body[field]) {
        updateFields[field] = req.body[field];
      }
    });

    // Handle nested location fields
    ["currentLocation", "permanentLocation"].forEach((locationType) => {
      if (req.body[locationType]) {
        const locationFields = [
          "province",
          "district",
          "municipality",
          "fullAddress",
        ];
        locationFields.forEach((field) => {
          if (req.body[locationType][field]) {
            updateFields[`${locationType}.${field}`] =
              req.body[locationType][field];
          }
        });
      }
    });

    // Handle nested personal details fields
    if (req.body.personalDetails) {
      // Handle direct fields in personalDetails
      [
        "age",
        "gender",
        "maritalStatus",
        "nationality",
        "religion",
        "email",
      ].forEach((field) => {
        if (req.body.personalDetails[field] !== undefined) {
          updateFields[`personalDetails.${field}`] =
            req.body.personalDetails[field];
        }
      });

      // Handle disability object
      if (req.body.personalDetails.disability) {
        if (req.body.personalDetails.disability.hasDisability !== undefined) {
          updateFields["personalDetails.disability.hasDisability"] =
            req.body.personalDetails.disability.hasDisability;
        }
        if (req.body.personalDetails.disability.details !== undefined) {
          updateFields["personalDetails.disability.details"] =
            req.body.personalDetails.disability.details;
        }
      }

      // Handle foreignEmployment object
      if (req.body.personalDetails.foreignEmployment) {
        if (
          req.body.personalDetails.foreignEmployment.hasWorkedAboroad !==
          undefined
        ) {
          updateFields["personalDetails.foreignEmployment.hasWorkedAboroad"] =
            req.body.personalDetails.foreignEmployment.hasWorkedAboroad;
        }
        if (req.body.personalDetails.foreignEmployment.details !== undefined) {
          updateFields["personalDetails.foreignEmployment.details"] =
            req.body.personalDetails.foreignEmployment.details;
        }
      }
    }

    // Handle job preference fields
    if (req.body.jobPreference) {
      const jobPreferenceFields = [
        "jobLevel",
        "availabilityStatus",
        "preferredShift",
        "workingStatus",
        "careerObjectives",
      ];

      jobPreferenceFields.forEach((field) => {
        if (req.body.jobPreference[field] !== undefined) {
          updateFields[`jobPreference.${field}`] =
            req.body.jobPreference[field];
        }
      });

      // Handle expectedSalary object
      if (req.body.jobPreference.expectedSalary) {
        const salaryFields = ["minimum", "maximum", "currency"];
        salaryFields.forEach((field) => {
          if (req.body.jobPreference.expectedSalary[field] !== undefined) {
            updateFields[`jobPreference.expectedSalary.${field}`] =
              req.body.jobPreference.expectedSalary[field];
          }
        });
      }
    }

    // If updating email, check if it's already in use by another profile
    if (req.body.personalDetails?.email) {
      const existingProfileWithEmail = await Profile.findOne({
        "personalDetails.email": req.body.personalDetails.email,
        userId: { $ne: userId }, // Exclude current user's profile
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
        runValidators: true, // This ensures schema validations run on update
        select: "-__v -createdAt -updatedAt",
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
    return res.status(500).json({ status: false, message: error.message });
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

    const { interestedCategories, currentLocation } = profile;

    // Fetch jobs that match the user's interested categories
    const matchedJobs = await JobPosting.find()
      .populate({
        path: "company",
        populate: {
          path: "industry",
          match: { name: { $in: interestedCategories } }, // Match based on industry name
        },
      })
      .then((jobs) =>
        jobs.filter(
          (job) => job.company && job.company.industry
          //  &&
          // job.location.district === currentLocation.district // Match district in job location
        )
      );

    res.status(200).json({ matchedJobs });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "An error occurred", error });
  }
  // try {
  //   const { userId } = req.params;

  //   // Find the user's profile
  //   const profile = await Profile.findOne({ userId });
  //   if (!profile) {
  //     return res.status(404).json({ message: "Profile not found" });
  //   }

  //   // Fetch matched jobs based on the user's interested categories
  //   const matchedJobs = await JobPosting.find()
  //     .populate({
  //       path: "company",
  //       populate: {
  //         path: "industry",
  //         match: { name: { $in: profile.interestedCategories } }, // Match based on industry name
  //       },
  //     })
  //     .then((jobs) => jobs.filter((job) => job.company && job.company.industry)); // Filter jobs with matching industries

  //   res.status(200).json({ matchedJobs });
  // } catch (error) {
  //   console.error(error);
  //   res.status(500).json({ message: "An error occurred", error });
  // }
};

module.exports = {
  handleCreateProfile,
  handleGetProfile,
  handleUpdateProfile,
  handleGetMatchedJobs,
};
