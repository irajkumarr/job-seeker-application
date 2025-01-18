//get user
//delete user
//update user
//forgot password todo
//reset password todo
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

module.exports = {
  handleGetUser,
  handleDeleteUser,
  handleUpdateUser,
};
