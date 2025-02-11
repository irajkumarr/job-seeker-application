const User = require("../../models/User/User");
const JobPosting = require("../../models/JobPosting/JobPosting");
const mongoose = require("mongoose");

const cloudinary = require("../../utils/cloudinary");
const handleGetUser = async (req, res) => {
  const userId = req.user.id;
  try {
    const user = await User.findOne(
      { _id: userId, isActive: true },
      { password: 0, createdAt: 0, updatedAt: 0, __v: 0 }
    );
    if (!user) {
      return res.status(404).json({ status: false, message: "User not found" });
    }
    if (!user.isActive) {
      return res.status(403).json({
        status: false,
        message: "Account is deactivated. Please contact support.",
      });
    }
    return res.status(200).json(user);
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleDeleteUser = async (req, res) => {
  const userId = req.user.id;
  try {
    const user = await User.findOne({ _id: userId, isActive: true });

    if (!user) {
      return res.status(404).json({ status: false, message: "User not found" });
    }
    if (!user.isActive) {
      return res.status(403).json({
        status: false,
        message: "Account is deactivated. Please contact support.",
      });
    }
    await User.findByIdAndDelete(userId);
    return res
      .status(200)
      .json({ status: true, message: "Account deleted succesfully!" });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

//handle update password
const handleUpdatePassword = async (req, res) => {
  const userId = req.user.id;
  const { oldPassword, newPassword } = req.body;
  try {
    const user = await User.findOne({ _id: userId, isActive: true });
    if (!user) {
      return res
        .status(404)
        .json({ success: false, message: "User not found" });
    }

    if (!(await user.comparePassword(oldPassword))) {
      return res
        .status(401)
        .json({ status: false, message: "Incorrect old password" });
    }
    user.password = newPassword;
    await user.save();
    return res
      .status(200)
      .json({ status: true, message: "Password changed successfully" });
  } catch (error) {
    return res.status(500).json({ success: false, message: error.message });
  }
};

const handleUpdateUser = async (req, res) => {
  const userId = req.user.id;
  try {
    const user = await User.findOne({ _id: userId, isActive: true });
    if (!user) {
      return res.status(404).json({ status: false, message: "User not found" });
    }
    if (!user.isActive) {
      return res.status(403).json({
        status: false,
        message: "Account is deactivated. Please contact support.",
      });
    }
    const updatedUser = await User.findByIdAndUpdate(
      userId,
      {
        $set: req.body,
      },
      { new: true, select: "-password -__v -createdAt -updatedAt" }
    );

    if (!updatedUser) {
      return res.status(404).json({ message: "User not updated" });
    }
    return res
      .status(200)
      .json({ status: true, message: "User updated successfully" });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

// Update User Profile Image (File Upload)
const handleUpdateProfileImage = async (req, res) => {
  try {
    const userId = req.user.id;

    if (!req.file) {
      return res
        .status(400)
        .json({ success: false, message: "No image file uploaded" });
    }

    // Upload file to Cloudinary
    const result = await cloudinary.uploader.upload_stream(
      { folder: "profile_images", resource_type: "auto" },
      async (error, result) => {
        if (error) {
          return res.status(500).json({
            success: false,
            message: "Cloudinary upload failed",
            error,
          });
        }

        // Update user profile image
        const user = await User.findByIdAndUpdate(
          { _id: userId },
          { profileImage: result.secure_url },
          { new: true, runValidators: true }
        );

        if (!user) {
          return res
            .status(404)
            .json({ success: false, message: "User not found" });
        }

        res.status(200).json({
          success: true,
          message: "Profile image updated successfully",
          data: user,
        });
      }
    );

    // Pipe the file buffer to Cloudinary
    result.end(req.file.buffer);
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

//handle saved jobs
const handleSavedJob = async (req, res) => {
  try {
    const userId = req.user.id;
    const { jobId } = req.body;

    // Check if the job exists in the Job collection
    const job = await JobPosting.findById(jobId);
    if (!job) {
      return res.status(404).json({ message: "Job not found" });
    }

    // Find the user by their ID
    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    // Check if the job is already saved by the user
    const isSaved = user.savedJobs.includes(jobId);

    if (isSaved) {
      user.savedJobs = user.savedJobs.filter(
        (savedJob) => savedJob.toString() !== jobId
      );
      await user.save();
      return res.status(200).json({ message: "Job removed from saved jobs" });
    } else {
      user.savedJobs.push(jobId);
      await user.save();
      return res.status(200).json({ message: "Job saved successfully" });
    }
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: "Server error" });
  }
};

const handleGetUserSavedJobs = async (req, res) => {
  try {
    const userId = req.user.id;

    const user = await User.findById(userId).populate({
      path: "savedJobs",
      populate: [{ path: "company", select: "name logo" }],
      select: "title company location",
    });

    if (!user) {
      return res.status(404).json({ status: false, message: "User not found" });
    }

    if (!user.savedJobs) {
      return res
        .status(404)
        .json({ status: false, message: "No saved jobs found" });
    }

    return res.status(200).json(user.savedJobs);
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleGetAllProfiles = async (req, res) => {
  try {
    if (!req.user || !req.user.id) {
      return res.status(400).json({
        status: false,
        message: "User ID not found in request",
      });
    }

    const userId = new mongoose.Types.ObjectId(req.user.id);

    const userProfile = await User.aggregate([
      {
        $match: { _id: userId },
      },
      {
        $lookup: {
          from: "profiles",
          localField: "_id",
          foreignField: "userId",
          as: "profile",
        },
      },
      {
        $lookup: {
          from: "experiences",
          localField: "_id",
          foreignField: "userId",
          as: "experiences",
        },
      },
      {
        $lookup: {
          from: "documents",
          localField: "_id",
          foreignField: "userId",
          as: "documents",
        },
      },
      {
        $lookup: {
          from: "trainings",
          localField: "_id",
          foreignField: "userId",
          as: "trainings",
        },
      },
      {
        $lookup: {
          from: "socialaccounts",
          localField: "_id",
          foreignField: "userId",
          as: "socialaccounts",
        },
      },
      {
        $lookup: {
          from: "references",
          localField: "_id",
          foreignField: "userId",
          as: "references",
        },
      },
      {
        $lookup: {
          from: "languages",
          localField: "_id",
          foreignField: "userId",
          as: "languages",
        },
      },
      {
        $lookup: {
          from: "educations",
          localField: "_id",
          foreignField: "userId",
          as: "educations",
        },
      },
      {
        $lookup: {
          from: "emergencycontacts",
          localField: "_id",
          foreignField: "userId",
          as: "emergencycontacts",
        },
      },
      {
        $lookup: {
          from: "otherinformations",
          localField: "_id",
          foreignField: "userId",
          as: "otherinformations",
        },
      },
      {
        $project: {
          password: 0,
          // "profile.password": 0,
          // "experiences._id": 0,
          // "documents._id": 0,
          // "trainings._id": 0,
          // "socialaccounts._id": 0,
          // "references._id": 0,
          // "languages._id": 0,
          // "educations._id": 0,
          // "emergencycontacts._id": 0,
        },
      },
    ]);

    if (!userProfile.length) {
      return res.status(404).json({
        status: false,
        message: "User profile not found",
      });
    }

    return res.status(200).json(userProfile[0]);
  } catch (error) {
    return res.status(500).json({
      status: false,
      message: error.message,
    });
  }
};

module.exports = {
  handleGetUser,
  handleDeleteUser,
  handleUpdateUser,
  handleGetAllProfiles,
  handleUpdateProfileImage,
  handleSavedJob,
  handleGetUserSavedJobs,
  handleUpdatePassword,
};
