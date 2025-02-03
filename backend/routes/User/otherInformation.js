const express = require("express");

const { verifyAndAuthorize } = require("../../middlewares/jwt");
const {
  handleAddOtherInformation,
  handleDeleteOtherInformation,
  handleUpdateOtherInformation,
  handleGetOtherInformation,
} = require("../../controllers/User/otherInformationController");

const router = express.Router();

router.post("/", verifyAndAuthorize, handleAddOtherInformation);
router.delete("/:id", verifyAndAuthorize, handleDeleteOtherInformation);
router.put("/", verifyAndAuthorize, handleUpdateOtherInformation);
router.get("/", verifyAndAuthorize, handleGetOtherInformation);

module.exports = router;
