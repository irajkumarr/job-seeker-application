const express = require("express");

const {
  handleGetUser,
  handleUpdateUser,
  handleDeleteUser,
  handleGetAllProfiles,
  handleUpdateProfileImage,
} = require("../../controllers/User/userController");
const { verifyAndAuthorize } = require("../../middlewares/jwt");

const upload = require("../../middlewares/multer");
const router = express.Router();

router.get("/", verifyAndAuthorize, handleGetUser);
router.put("/", verifyAndAuthorize, handleUpdateUser);
router.delete("/", verifyAndAuthorize, handleDeleteUser);
router.get("/profiles", verifyAndAuthorize, handleGetAllProfiles);
router.put(
  "/profileImage/",
  verifyAndAuthorize,
  upload.single("profileImage"),
  handleUpdateProfileImage
);

module.exports = router;
