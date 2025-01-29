const User = require("../../models/User/User.js");
const { generateToken } = require("../../middlewares/jwt.js");

const handleCreateUser = async (req, res) => {
  const user = req.body;

  try {
    // Check if user already exists by mobile number
    const existingUserWithPhone = await User.findOne({
      mobileNumber: user.mobileNumber,
    });
    if (existingUserWithPhone) {
      return res
        .status(400)
        .json({ status: false, message: "Mobile number already registered!" });
    }

    // Create new user
    const newUser = new User({
      name: user.name,
      mobileNumber: user.mobileNumber,
      password: user.password,
      userType: user.userType,
    });

    // Save user to database
    const savedUser = await newUser.save();

    // Generate JWT token
    const payload = {
      id: savedUser._id,
      userType: savedUser.userType,
    };
    const userToken = generateToken(payload);

    // Exclude sensitive information like password
    const { password, createdAt, updatedAt, __v, ...others } =
      savedUser.toObject();

    // Send response with user data and token
    return res.status(201).json({
      ...others,
      userToken,
    });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleCheckMobileNumber = async (req, res) => {
  const { mobileNumber } = req.body;

  try {
    // Validate request body
    if (!mobileNumber) {
      return res.status(400).json({
        status: false,
        message: "Mobile number is required!"
      });
    }

    // Check if user exists with this mobile number
    const existingUser = await User.findOne({ mobileNumber });

    if (existingUser) {
      return res.status(400).json({
        status: false,
        message: "Mobile number already registered!"
      });
    }

    // If no user found with this mobile number
    return res.status(200).json({
      status: true,
      message: "Mobile number is available"
    });

  } catch (error) {
    return res.status(500).json({
      status: false,
      message: error.message
    });
  }
};

//login user controller
const handleLoginUser = async (req, res) => {
  // fcmToken if necessary if the device changes with same account
  const { mobileNumber, password } = req.body;
  try {
    const user = await User.findOne(
      { mobileNumber },
      { __v: 0, createdAt: 0, updatedAt: 0 }
    );

    //checking user
    if (!user || !(await user.comparePassword(password))) {
      return res
        .status(404)
        .json({ status: false, message: "Invalid Mobile number or Password" });
    }

    // Check if the account is active
    if (!user.isActive) {
      return res.status(403).json({
        status: false,
        message: "Account is deactivated. Please contact support.",
      });
    }
    //generating token
    const payload = {
      id: user._id,
      userType: user.userType,
    };

    const userToken = generateToken(payload);

    //extracting password and other info
    const { password: _, ...others } = user._doc;

    return res.status(200).json({ ...others, userToken });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

module.exports = {
  handleCreateUser,
  handleCheckMobileNumber,
  handleLoginUser,
};
