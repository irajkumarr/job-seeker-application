const Industry = require("../../models/Industry/Industry");

// Add a new industry
const handleAddIndustry = async (req, res) => {
  try {
    const industry = new Industry(req.body);
    await industry.save();
    return res
      .status(201)
      .json({ status: true, message: "Industry added successfully" });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

// Get all industries
const handleGetIndustries = async (req, res) => {
  try {
    const industries = await Industry.find();
    return res.status(200).json(industries);
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

// Get industry by ID
const handleGetIndustryById = async (req, res) => {
  try {
    const industry = await Industry.findById(req.params.id);
    if (!industry) {
      return res
        .status(404)
        .json({ status: false, message: "Industry not found" });
    }
    return res.status(200).json(industry);
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

// Update an industry
const handleUpdateIndustry = async (req, res) => {
  const id = req.params.id;
  try {
    const updatedIndustry = await Industry.findByIdAndUpdate(id, req.body, {
      new: true,
    });
    if (!updatedIndustry) {
      return res
        .status(404)
        .json({ status: false, message: "Industry not found" });
    }
    return res.status(200).json({
      status: true,
      message: "Industry updated successfully",
    });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

// Delete an industry
const handleDeleteIndustry = async (req, res) => {
  try {
    const deletedIndustry = await Industry.findByIdAndDelete(req.params.id);
    if (!deletedIndustry) {
      return res
        .status(404)
        .json({ status: false, message: "Industry not found" });
    }
    res.status(200).json({
      status: true,
      message: "Industry deleted successfully",
    });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

// Update job count for an industry
const handleUpdateJobCount = async (industryId, adjustment) => {
  try {
    const industry = await Industry.findById(industryId);
    if (!industry) {
      throw new Error("Industry not found");
    }
    industry.metadata.jobCount += adjustment;
    await industry.save();
    console.log(
      `Updated job count for industry ${industryId}: ${industry.metadata.jobCount}`
    );
  } catch (error) {
    console.error(
      `Failed to update job count for industry ${industryId}:`,
      error.message
    );
    throw error;
  }
};

// Get industries with pagination and filtering (optional)
const handleGetFilteredIndustries = async (req, res) => {
  const { name, status, page = 1, limit = 10 } = req.query;

  try {
    const filters = {};
    if (name) filters.name = { $regex: name, $options: "i" };
    if (status) filters.status = status === "true";

    const industries = await Industry.find(filters)
      .skip((page - 1) * limit)
      .limit(Number(limit));
    const total = await Industry.countDocuments(filters);

    res.status(200).json({
      message: "Industries retrieved successfully",
      data: industries,
      meta: {
        total,
        page: Number(page),
        limit: Number(limit),
        totalPages: Math.ceil(total / limit),
      },
    });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

module.exports = {
  handleAddIndustry,
  handleDeleteIndustry,
  handleGetIndustries,
  handleUpdateIndustry,
  handleUpdateJobCount,
  handleGetFilteredIndustries,
  handleGetIndustryById,
};
