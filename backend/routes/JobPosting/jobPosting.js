const express = require("express");
const {
  createJobPosting,
  getAllJobPostings,
  getJobPostingById,
  updateJobPosting,
  deleteJobPosting,
  filterJobPostings,
} = require("../../controllers/JobPosting/jobPostingController");

const router = express.Router();

router.post("/", createJobPosting);
router.get("/", getAllJobPostings);
router.get("/filter", filterJobPostings);
router.get("/:id", getJobPostingById);
router.put("/:id", updateJobPosting);
router.delete("/:id", deleteJobPosting);

module.exports = router;
