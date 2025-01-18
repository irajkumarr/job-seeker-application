const express = require("express");

const { verifyAndAuthorize } = require("../../middlewares/jwt");
const {
  handleAddLanguage,
  handleDeleteLanguage,
  handleUpdateLanguage,
  handleGetLanguage,
} = require("../../controllers/User/languageController");

const router = express.Router();

router.post("/", verifyAndAuthorize, handleAddLanguage);
router.delete("/:id", verifyAndAuthorize, handleDeleteLanguage);
router.put("/:id", verifyAndAuthorize, handleUpdateLanguage);
router.get("/", verifyAndAuthorize, handleGetLanguage);

module.exports = router;
