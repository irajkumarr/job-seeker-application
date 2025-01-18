const express = require("express");

const { verifyAndAuthorize } = require("../../middlewares/jwt");
const {
  handleAddReference,
  handleDeleteReference,
  handleUpdateReference,
  handleGetReference,
} = require("../../controllers/User/referenceController");

const router = express.Router();

router.post("/", verifyAndAuthorize, handleAddReference);
router.delete("/:id", verifyAndAuthorize, handleDeleteReference);
router.put("/:id", verifyAndAuthorize, handleUpdateReference);
router.get("/", verifyAndAuthorize, handleGetReference);

module.exports = router;
