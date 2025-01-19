const express = require("express");
const {
  handleDeleteIndustry,
  handleUpdateIndustry,
  handleGetIndustryById,
  handleGetFilteredIndustries,
  handleAddIndustry,
} = require("../../controllers/Industry/industryController");
const router = express.Router();
const { verifyEmployer } = require("../../middlewares/jwt");

router.post("/", verifyEmployer, handleAddIndustry);

router.get("/", handleGetFilteredIndustries);

router.get("/:id", handleGetIndustryById);

router.put("/:id", verifyEmployer, handleUpdateIndustry);

router.delete("/:id", verifyEmployer, handleDeleteIndustry);

module.exports = router;
