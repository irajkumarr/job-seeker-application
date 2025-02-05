const express = require("express");

const {
  handleGetUser,
  handleUpdateUser,
  handleDeleteUser,
  handleGetAllProfiles,
  handleUpdateProfileImage,
  handleUpdatePassword,
  handleSavedJob,
  handleGetUserSavedJobs,
} = require("../../controllers/user/userController");
const { verifyAndAuthorize } = require("../../middlewares/jwt");

const upload = require("../../middlewares/multer");
const router = express.Router();

router.get("/", verifyAndAuthorize, handleGetUser);
router.put("/", verifyAndAuthorize, handleUpdateUser);
router.delete("/", verifyAndAuthorize, handleDeleteUser);
router.put("/change-password", verifyAndAuthorize, handleUpdatePassword);
router.post("/saved-jobs", verifyAndAuthorize, handleSavedJob);
router.get("/saved-jobs", verifyAndAuthorize, handleGetUserSavedJobs);
router.get("/profiles", verifyAndAuthorize, handleGetAllProfiles);
router.put(
  "/profileImage/",
  verifyAndAuthorize,
  upload.single("profileImage"),
  handleUpdateProfileImage
);

module.exports = router;
