const express = require("express");

const { verifyAndAuthorize } = require("../../middlewares/jwt");
const {
  handleCreateProfile,
  handleGetProfile,
  handleUpdateProfile,
} = require("../../controllers/User/profileController");

const router = express.Router();

router.post("/", verifyAndAuthorize, handleCreateProfile);
router.get("/", verifyAndAuthorize, handleGetProfile);
router.put("/", verifyAndAuthorize, handleUpdateProfile);

module.exports = router;
