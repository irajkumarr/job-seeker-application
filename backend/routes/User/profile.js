const express = require("express");

const { verifyAndAuthorize } = require("../../middlewares/jwt");
const {
  handleCreateProfile,
  handleGetProfile,
  handleUpdateProfile,
  handleGetMatchedJobs,
} = require("../../controllers/User/profileController");

const router = express.Router();

router.post("/", verifyAndAuthorize, handleCreateProfile);
router.get("/", verifyAndAuthorize, handleGetProfile);
router.put("/", verifyAndAuthorize, handleUpdateProfile);
router.get("/matched-jobs", verifyAndAuthorize, handleGetMatchedJobs);

module.exports = router;
