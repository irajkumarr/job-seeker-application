const Industry = require("../../models/Industry/Industry");

// Add a new industry
const handleAddIndustry = async (req, res) => {
  try {
    const industry = new Industry(req.body);
    const savedIndustry = await industry.save();
    res
      .status(201)
      .json({ message: "Industry added successfully", data: savedIndustry });
  } catch (error) {
    res
      .status(500)
      .json({ error: "Failed to add industry", details: error.message });
  }
};

// Get all industries
const handleGetIndustries = async (req, res) => {
  try {
    const industries = await Industry.find();
    res
      .status(200)
      .json({ message: "Industries retrieved successfully", data: industries });
  } catch (error) {
    res
      .status(500)
      .json({ error: "Failed to retrieve industries", details: error.message });
  }
};

// Get industry by ID
const handleGetIndustryById = async (req, res) => {
  try {
    const industry = await Industry.findById(req.params.id);
    if (!industry) {
      return res.status(404).json({ error: "Industry not found" });
    }
    res
      .status(200)
      .json({ message: "Industry retrieved successfully", data: industry });
  } catch (error) {
    res
      .status(500)
      .json({ error: "Failed to retrieve industry", details: error.message });
  }
};

// Update an industry
const handleUpdateIndustry = async (req, res) => {
  try {
    const updatedIndustry = await Industry.findByIdAndUpdate(
      req.params.id,
      req.body,
      { new: true }
    );
    if (!updatedIndustry) {
      return res.status(404).json({ error: "Industry not found" });
    }
    res
      .status(200)
      .json({
        message: "Industry updated successfully",
        data: updatedIndustry,
      });
  } catch (error) {
    res
      .status(500)
      .json({ error: "Failed to update industry", details: error.message });
  }
};

// Delete an industry
const handleDeleteIndustry = async (req, res) => {
  try {
    const deletedIndustry = await Industry.findByIdAndDelete(req.params.id);
    if (!deletedIndustry) {
      return res.status(404).json({ error: "Industry not found" });
    }
    res
      .status(200)
      .json({
        message: "Industry deleted successfully",
        data: deletedIndustry,
      });
  } catch (error) {
    res
      .status(500)
      .json({ error: "Failed to delete industry", details: error.message });
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
    res
      .status(500)
      .json({ error: "Failed to retrieve industries", details: error.message });
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
