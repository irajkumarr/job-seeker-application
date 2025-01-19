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
} = require("../../controllers/JobApplication/jobApplicationController");
const { verifyAndAuthorize, verifyEmployer } = require("../../middlewares/jwt");

router.post("/", verifyAndAuthorize, handleCreateJobApplication);
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
