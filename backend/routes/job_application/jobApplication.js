const express = require("express");
const router = express.Router();
const {
  handleAddFeedbackToJobApplication,
  handleAddNoteToJobApplication,
  handleCreateJobApplication,
  handleDeleteJobApplication,
  handleUpdateJobApplicationStatus,
  handleGetJobApplicationsByJob,
  handleGetJobApplicationsByApplicant,
  handleGetAllJobApplications,
  handleCheckJobApplicationStatus,
} = require("../../controllers/job_application/jobApplicationController");
const { verifyAndAuthorize, verifyEmployer } = require("../../middlewares/jwt");

router.post("/", verifyAndAuthorize, handleCreateJobApplication);
router.get("/", verifyAndAuthorize, handleGetAllJobApplications);
router.get(
  "/jobs/:jobId/application-status",
  verifyAndAuthorize,
  handleCheckJobApplicationStatus
);
router.get("/job/:jobId", verifyEmployer, handleGetJobApplicationsByJob);
router.get("/applicant", verifyEmployer, handleGetJobApplicationsByApplicant);
router.put(
  "/status/:applicationId",
  verifyEmployer,
  handleUpdateJobApplicationStatus
);
router.put(
  "/note/:applicationId",
  verifyEmployer,
  handleAddNoteToJobApplication
);
router.put(
  "/feedback/:applicationId",
  verifyEmployer,
  handleAddFeedbackToJobApplication
);
router.delete("/:applicationId", verifyEmployer, handleDeleteJobApplication);

module.exports = router;
