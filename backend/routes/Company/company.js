const express = require("express");
const router = express.Router();
const {
  addCompany,
  getCompanies,
  getCompanyById,
  updateCompany,
  deleteCompany,
  getVerifiedCompanies,
} = require("../../controllers/Company/companyController");
const { verifyEmployer } = require("../../middlewares/jwt");

// Add a new company
router.post("/", verifyEmployer, addCompany);

// Get all companies (with optional filters and pagination)
router.get("/", getCompanies);

// Get a single company by ID
router.get("/:id", getCompanyById);

// Update a company by ID
router.put("/:id", verifyEmployer, updateCompany);

// Delete a company by ID
router.delete("/:id", verifyEmployer, deleteCompany);

// Get verified or unverified companies
router.get("/filter/verified", getVerifiedCompanies);

module.exports = router;
