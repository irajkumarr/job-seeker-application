const express = require("express");
const router = express.Router();
const {
  handleAddCompany,
  handleGetCompanies,
  handleGetCompanyById,
  handleUpdateCompany,
  hanldeDeleteCompany,
  handleGetVerifiedCompanies,
} = require("../../controllers/company/companyController");
const { verifyEmployer } = require("../../middlewares/jwt");

router.post("/", verifyEmployer, handleAddCompany);

router.get("/", handleGetCompanies);

router.get("/:id", handleGetCompanyById);

router.put("/:id", verifyEmployer, handleUpdateCompany);

router.delete("/:id", verifyEmployer, hanldeDeleteCompany);

router.get("/filter/verified", handleGetVerifiedCompanies);

module.exports = router;
