const express = require("express");
const {
  createJobPosting,
  getAllJobPostings,
  getJobPostingById,
  updateJobPosting,
  deleteJobPosting,
  filterJobPostings,
  getUniqueJobDistricts,
  getJobsByDistrict,
} = require("../../controllers/JobPosting/jobPostingController");

const router = express.Router();

router.post("/", createJobPosting);
router.get("/", getAllJobPostings);
router.get("/filter", filterJobPostings);
router.get("/:id", getJobPostingById);
router.get("/districts/all", getUniqueJobDistricts);
router.get("/all/by-district", getJobsByDistrict);
router.put("/:id", updateJobPosting);
router.delete("/:id", deleteJobPosting);

module.exports = router;
