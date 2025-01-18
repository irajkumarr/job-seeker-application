const express = require("express");

const {
  handleGetUser,
  handleUpdateUser,
  handleDeleteUser,
} = require("../../controllers/User/userController");
const { verifyAndAuthorize } = require("../../middlewares/jwt");

const router = express.Router();

router.get("/", verifyAndAuthorize, handleGetUser);
router.put("/", verifyAndAuthorize, handleUpdateUser);
router.delete("/", verifyAndAuthorize, handleDeleteUser);

module.exports = router;
