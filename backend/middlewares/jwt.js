const jwt = require("jsonwebtoken");

const verifyToken = (req, res, next) => {
  // first check request headers has authorization or not
  const authHeader = req.headers.authorization;
  if (!authHeader)
    return res.status(401).json({ status: false, message: "Token not found" });

  // Extract the jwt token from the request headers
  const token = req.headers.authorization.split(" ")[1];
  if (!token)
    return res.status(401).json({ status: false, message: "Unauthorized" });

  try {
    // Verify the JWT token
    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    // Attach user information to the request object
    req.user = decoded;
    next();
  } catch (error) {
    return res.status(401).json({
      status: false,
      message: "Invalid token, Please Log out and Login again!",
    });
  }
};

const generateToken = (userData) => {
  return jwt.sign(userData, process.env.JWT_SECRET, {
    expiresIn: "30d",
  });
};

const verifyAndAuthorize = (req, res, next) => {
  verifyToken(req, res, () => {
    if (req.user.userType === "admin" || req.user.userType === "jobseeker") {
      next();
    } else {
      return res.status(401).json({ status: false, message: "Unauthorized" });
    }
  });
};

const verifyAdmin = (req, res, next) => {
  verifyToken(req, res, () => {
    if (req.user.userType === "admin") {
      next();
    } else {
      return res.status(401).json({ status: false, message: "Unauthorized" });
    }
  });
};
const verifyEmployer = (req, res, next) => {
  verifyToken(req, res, () => {
    if (req.user.userType === "admin" || req.user.userType === "employer") {
      next();
    } else {
      return res.status(401).json({ status: false, message: "Unauthorized" });
    }
  });
};

module.exports = {
  verifyToken,
  generateToken,
  verifyAndAuthorize,
  verifyAdmin,
  verifyEmployer,
};
