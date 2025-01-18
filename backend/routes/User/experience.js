const express = require("express");

const { verifyAndAuthorize } = require("../../middlewares/jwt");
const {
  handleAddExperience,
  handleDeleteExperience,
  handleUpdateExperience,
  handleGetExperience,
} = require("../../controllers/User/experienceController");

const router = express.Router();

router.post("/", verifyAndAuthorize, handleAddExperience);
router.delete("/:id", verifyAndAuthorize, handleDeleteExperience);
router.put("/:id", verifyAndAuthorize, handleUpdateExperience);
router.get("/", verifyAndAuthorize, handleGetExperience);

module.exports = router;
