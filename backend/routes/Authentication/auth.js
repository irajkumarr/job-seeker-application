const express = require("express");
const {
  handleCreateUser,
  handleCheckMobileNumber,
  handleLoginUser,
} = require("../../controllers/Authentication/authController");
const router = express.Router();

router.post("/register", handleCreateUser);
router.post("/check-mobile", handleCheckMobileNumber);
router.post("/login", handleLoginUser);

module.exports = router;
