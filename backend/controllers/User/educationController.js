const Education = require("../../models/User/Education");

const handleAddEducation = async (req, res) => {
  const education = req.body;
  const userId = req.user.id;

  try {
    const newEducation = new Education({
      userId: userId,
      level:education.level,
      educationProgram: education.educationProgram,
      educationBoard: education.educationBoard,
      institution: education.institution,
      startDate: education.startDate,
      graduationYear: education.graduationYear,
      grade: education.grade,
    });

    await newEducation.save();
    return res.status(201).json({ status: true, message: "Education added!" });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleUpdateEducation = async (req, res) => {
  const updatedEducation = req.body;
  const id = req.params.id;
  try {
    const education = await Education.findById(id);
    if (!education) {
      return res
        .status(404)
        .json({ status: false, message: "Education not found" });
    }
    await Education.findByIdAndUpdate(
      id,
      {
        $set: updatedEducation,
      },
      { new: true, runValidators: true }
    );
    return res
      .status(200)
      .json({ status: true, message: "Education updated successfully!" });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleDeleteEducation = async (req, res) => {
  const id = req.params.id;
  try {
    const education = await Education.findById(id);
    if (!education) {
      return res
        .status(404)
        .json({ status: false, message: "Education not found" });
    }
    await Education.findByIdAndDelete(id);
    return res
      .status(200)
      .json({ status: true, message: "Education deleted successfully!" });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleGetEducation = async (req, res) => {
  const userId = req.user.id;
  try {
    const education = await Education.find(
      { userId: userId },
      { __v: 0, createdAt: 0, updatedAt: 0 }
    );
    if (!education.length) {
      return res
        .status(404)
        .json({ status: false, message: "Education not found" });
    }

    return res.status(200).json(education);
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

module.exports = {
  handleAddEducation,
  handleDeleteEducation,
  handleUpdateEducation,
  handleGetEducation,
};
