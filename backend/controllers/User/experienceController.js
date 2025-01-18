const Experience = require("../../models/User/Experience");

const handleAddExperience = async (req, res) => {
  const experience = req.body;
  const userId = req.user.id;
  try {
    const newExperience = new Experience({
      userId: userId,
      organizationName: experience.organizationName,
      industry: experience.industry,
      jobCategory: experience.jobCategory,
      location: experience.location,
      designation: experience.designation,
      jobLevel: experience.jobLevel,
      startDate: experience.startDate,
      currentlyWorking: experience.currentlyWorking,
      endDate: experience.endDate,
      rolesAndResponsibilities: experience.rolesAndResponsibilities,
    });
    await newExperience.save();
    return res.status(201).json({ status: true, message: "Experience added!" });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleUpdateExperience = async (req, res) => {
  const updatedExperience = req.body;
  const id = req.params.id;
  try {
    const experience = await Experience.findById(id);
    if (!experience) {
      return res
        .status(404)
        .json({ status: false, message: "Experience not found" });
    }
    await Experience.findByIdAndUpdate(
      id,
      {
        $set: updatedExperience,
      },
      { new: true, runValidators: true }
    );
    return res
      .status(200)
      .json({ status: true, message: "Experience updated successfully!" });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleDeleteExperience = async (req, res) => {
  const id = req.params.id;
  try {
    const experience = await Experience.findById(id);
    if (!experience) {
      return res
        .status(404)
        .json({ status: false, message: "Experience not found" });
    }
    await Experience.findByIdAndDelete(id);
    return res
      .status(200)
      .json({ status: true, message: "Experience deleted successfully!" });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleGetExperience = async (req, res) => {
  const userId = req.user.id;
  try {
    const experience = await Experience.find(
      { userId: userId },
      { __v: 0, createdAt: 0, updatedAt: 0 }
    );
    if (!experience.length) {
      return res
        .status(404)
        .json({ status: false, message: "Experience not found" });
    }

    return res.status(200).json(experience);
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

module.exports = {
  handleAddExperience,
  handleDeleteExperience,
  handleUpdateExperience,
  handleGetExperience,
};
