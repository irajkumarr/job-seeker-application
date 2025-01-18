const express = require("express");

const { verifyAndAuthorize } = require("../../middlewares/jwt");

const {
  handleAddTraining,
  handleDeleteTraining,
  handleUpdateTraining,
  handleGetTraining,
} = require("../../controllers/User/trainingController");

const router = express.Router();

router.post("/", verifyAndAuthorize, handleAddTraining);
router.delete("/:id", verifyAndAuthorize, handleDeleteTraining);
router.put("/:id", verifyAndAuthorize, handleUpdateTraining);
router.get("/", verifyAndAuthorize, handleGetTraining);

module.exports = router;
