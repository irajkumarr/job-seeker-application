const express = require("express");

const { verifyAndAuthorize } = require("../../middlewares/jwt");
const {
  handleAddEducation,
  handleDeleteEducation,
  handleUpdateEducation,
  handleGetEducation,
} = require("../../controllers/User/educationController");

const router = express.Router();

router.post("/", verifyAndAuthorize, handleAddEducation);
router.delete("/:id", verifyAndAuthorize, handleDeleteEducation);
router.put("/:id", verifyAndAuthorize, handleUpdateEducation);
router.get("/", verifyAndAuthorize, handleGetEducation);

module.exports = router;
