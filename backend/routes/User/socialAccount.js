const express = require("express");

const { verifyAndAuthorize } = require("../../middlewares/jwt");
const {
  handleAddSocialAccount,
  handleDeleteSocialAccount,
  handleUpdateSocialAccount,
  handleGetSocialAccount,
} = require("../../controllers/User/socialAccountController");

const router = express.Router();

router.post("/", verifyAndAuthorize, handleAddSocialAccount);
router.delete("/:id", verifyAndAuthorize, handleDeleteSocialAccount);
router.put("/:id", verifyAndAuthorize, handleUpdateSocialAccount);
router.get("/", verifyAndAuthorize, handleGetSocialAccount);

module.exports = router;
