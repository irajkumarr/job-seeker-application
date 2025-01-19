const express = require("express");
const {
  handleCreateJobPosting,
  handleGetAllJobPostings,
  handleGetJobPostingById,
  handleUpdateJobPosting,
  handleDeleteJobPosting,
  handleFilterJobPostings,
  handleGetJobsByDistrict,
  handleGetUniqueJobDistricts,
} = require("../../controllers/JobPosting/jobPostingController");
const { verifyEmployer } = require("../../middlewares/jwt");
const router = express.Router();

router.post("/", verifyEmployer, handleCreateJobPosting);
router.get("/", handleGetAllJobPostings);
router.get("/filter", handleFilterJobPostings);
router.get("/:id", handleGetJobPostingById);
router.get("/districts/all", handleGetUniqueJobDistricts);
router.get("/all/by-district", handleGetJobsByDistrict);
router.put("/:id", verifyEmployer, handleUpdateJobPosting);
router.delete("/:id", verifyEmployer, handleDeleteJobPosting);

module.exports = router;
