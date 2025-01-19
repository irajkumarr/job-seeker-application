const express = require("express");
const router = express.Router();
const jobApplicationController = require("../../controllers/JobApplication/jobApplicationController");
const { verifyAndAuthorize } = require("../../middlewares/jwt");

router.post("/",verifyAndAuthorize, jobApplicationController.createJobApplication);
router.get("/job/:jobId", jobApplicationController.getJobApplicationsByJob);
router.get("/applicant/:applicantId", jobApplicationController.getJobApplicationsByApplicant);
router.put("/status/:applicationId", jobApplicationController.updateJobApplicationStatus);
router.put("/note/:applicationId", jobApplicationController.addNoteToJobApplication);
router.put("/feedback/:applicationId", jobApplicationController.addFeedbackToJobApplication);
router.delete("/:applicationId", jobApplicationController.deleteJobApplication);

module.exports = router;
