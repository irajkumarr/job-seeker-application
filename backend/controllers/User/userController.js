const User = require("../../models/User/User");

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

//getting all user data
const handleGetAllProfiles = async (req, res) => {
  try {
    const userProfiles = await User.aggregate([
      {
        $lookup: {
          from: "profiles", // Collection for profiles
          localField: "_id", // User's `_id`
          foreignField: "userId", // Field in profiles referencing the user's ID
          as: "profile", // Alias for the result
        },
      },
      {
        $lookup: {
          from: "experiences", // Collection for experiences
          localField: "_id",
          foreignField: "userId",
          as: "experiences",
        },
      },
      {
        $lookup: {
          from: "documents", // Collection for documents
          localField: "_id",
          foreignField: "userId",
          as: "documents",
        },
      },
      {
        $lookup: {
          from: "trainings", // Collection for documents
          localField: "_id",
          foreignField: "userId",
          as: "trainings",
        },
      },
      {
        $lookup: {
          from: "socialaccounts", // Collection for documents
          localField: "_id",
          foreignField: "userId",
          as: "socialaccounts",
        },
      },
      {
        $lookup: {
          from: "references", // Collection for documents
          localField: "_id",
          foreignField: "userId",
          as: "references",
        },
      },
      {
        $lookup: {
          from: "languages", // Collection for documents
          localField: "_id",
          foreignField: "userId",
          as: "languages",
        },
      },
      {
        $lookup: {
          from: "educations", // Collection for documents
          localField: "_id",
          foreignField: "userId",
          as: "educations",
        },
      },
      {
        $lookup: {
          from: "emergencycontacts", // Collection for documents
          localField: "_id",
          foreignField: "userId",
          as: "emergencycontacts",
        },
      },
      // Add more lookups as needed for other related collections
      {
        // $project: {
        //   password: 0, // Exclude sensitive fields like passwords
        //   "profile.password": 0, // Exclude nested sensitive fields if necessary
        // },
        $project: {
          password: 0, // Exclude sensitive fields like passwords
          "profile.password": 0, // Exclude nested sensitive fields if necessary
          "experiences._id": 0, // Optionally, exclude other sensitive fields from subcollections
          "documents._id": 0, // Exclude _id from documents if not needed
          "trainings._id": 0,
          "socialaccounts._id": 0,
          "references._id": 0,
          "languages._id": 0,
          "educations._id": 0,
          "emergencycontacts._id": 0,
        },
      },
    ]);

    // Check if profiles exist
    if (!userProfiles.length) {
      return res.status(404).json({
        status: false,
        message: "No profiles found",
      });
    }

    return res.status(200).json(userProfiles);
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
};
