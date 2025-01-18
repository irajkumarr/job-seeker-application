const express = require("express");

const { verifyAndAuthorize } = require("../../middlewares/jwt");
const {
  handleAddDocument,
  handleDeleteDocument,
  handleUpdateDocument,
  handleGetDocument,
} = require("../../controllers/User/documentController");
const upload = require("../../middlewares/multer");

const router = express.Router();

router.post("/", verifyAndAuthorize, upload.single("file"), handleAddDocument);
router.delete("/:id", verifyAndAuthorize, handleDeleteDocument);
router.put(
  "/:id",
  verifyAndAuthorize,
  upload.single("file"),
  handleUpdateDocument
);
router.get("/", verifyAndAuthorize, handleGetDocument);

module.exports = router;
