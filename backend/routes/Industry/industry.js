const express = require("express");
const {
  handleDeleteIndustry,
  handleUpdateIndustry,
  handleGetIndustryById,
  handleGetFilteredIndustries,
  handleAddIndustry,
  handleGetIndustries,
} = require("../../controllers/Industry/industryController");
const router = express.Router();
const { verifyEmployer } = require("../../middlewares/jwt");

router.post("/", verifyEmployer, handleAddIndustry);

router.get("/", handleGetFilteredIndustries);
router.get("/all", handleGetIndustries);

router.get("/:id", handleGetIndustryById);

router.put("/:id", verifyEmployer, handleUpdateIndustry);

router.delete("/:id", verifyEmployer, handleDeleteIndustry);

module.exports = router;
