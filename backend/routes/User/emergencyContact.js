const express = require("express");

const { verifyAndAuthorize } = require("../../middlewares/jwt");
const {
  handleAddEmergencyContact,
  handleDeleteEmergencyContact,
  handleUpdateEmergencyContact,
  handleGetEmergencyContact,
} = require("../../controllers/User/emergencyContactController");

const router = express.Router();

router.post("/", verifyAndAuthorize, handleAddEmergencyContact);
router.delete("/:id", verifyAndAuthorize, handleDeleteEmergencyContact);
router.put("/:id", verifyAndAuthorize, handleUpdateEmergencyContact);
router.get("/", verifyAndAuthorize, handleGetEmergencyContact);

module.exports = router;
