const express = require("express");
const {
  handleCreateUser,
  handleLoginUser,
} = require("../../controllers/auth/authController");
const router = express.Router();

router.post("/register", handleCreateUser);
router.post("/login", handleLoginUser);

module.exports = router;
