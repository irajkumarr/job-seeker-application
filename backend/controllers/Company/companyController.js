const Company = require("../../models/Company/Company");

// Add a new company
const handleAddCompany = async (req, res) => {
  const userId = req.user.id;
  try {
    const company = new Company({
      ...req.body,
      user: userId,
    });
    await company.save();
    res.status(201).json({ message: "Company added successfully", company });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

// Get all companies (with optional filtering and pagination)
const handleGetCompanies = async (req, res) => {
  try {
    const { page = 1, limit = 10, status, industry } = req.query;
    const query = {};
    if (status) query.status = status;
    if (industry) query.industry = industry;

    const companies = await Company.find(query)
      .skip((page - 1) * limit)
      .limit(parseInt(limit));
    const total = await Company.countDocuments(query);

    res.status(200).json({ total, page: parseInt(page), companies });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Get a company by ID
const handleGetCompanyById = async (req, res) => {
  try {
    const company = await Company.findById(req.params.id);
    if (!company) {
      return res.status(404).json({ message: "Company not found" });
    }
    res.status(200).json(company);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Update a company by ID
const handleUpdateCompany = async (req, res) => {
  try {
    const company = await Company.findByIdAndUpdate(req.params.id, req.body, {
      new: true,
      runValidators: true,
    });
    if (!company) {
      return res.status(404).json({ message: "Company not found" });
    }
    res.status(200).json({ message: "Company updated successfully", company });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

// Delete a company by ID
const hanldeDeleteCompany = async (req, res) => {
  try {
    const company = await Company.findByIdAndDelete(req.params.id);
    if (!company) {
      return res.status(404).json({ message: "Company not found" });
    }
    res.status(200).json({ message: "Company deleted successfully" });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Get companies filtered by verification status
const handleGetVerifiedCompanies = async (req, res) => {
  try {
    const { isVerified } = req.query;
    const query = { isVerified: isVerified === "true" };
    const companies = await Company.find(query);

    res.status(200).json({ total: companies.length, companies });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

module.exports = {
  handleAddCompany,
  handleGetCompanies,
  handleGetCompanyById,
  handleUpdateCompany,
  hanldeDeleteCompany,
  handleGetVerifiedCompanies,
};
