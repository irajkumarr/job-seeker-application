const express = require("express");

const {
  handleGetUser,
  handleUpdateUser,
  handleDeleteUser,
  handleGetAllProfiles,
} = require("../../controllers/User/userController");
const { verifyAndAuthorize } = require("../../middlewares/jwt");

const router = express.Router();

router.get("/", verifyAndAuthorize, handleGetUser);
router.put("/", verifyAndAuthorize, handleUpdateUser);
router.delete("/", verifyAndAuthorize, handleDeleteUser);
router.get("/profiles", verifyAndAuthorize, handleGetAllProfiles);

module.exports = router;
