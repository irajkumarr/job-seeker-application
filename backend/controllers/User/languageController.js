const Language = require("../../models/User/Language");

const handleAddLanguage = async (req, res) => {
  const language = req.body;
  const userId = req.user.id;
  try {
    const newLanguage = new Language({
      userId: userId,
      name: language.name,
      score: language.score,
    });
    await newLanguage.save();
    return res.status(201).json({ status: true, message: "Language added!" });
  } catch (error) {
    return res.status(201).json({ status: false, message: error.message });
  }
};

const handleUpdateLanguage = async (req, res) => {
  const updatedLanguage = req.body;
  const id = req.params.id;
  try {
    const language = await Language.findById(id);
    if (!language) {
      return res
        .status(404)
        .json({ status: false, message: "Language not found" });
    }
    await Language.findByIdAndUpdate(
      id,
      {
        $set: updatedLanguage,
      },
      { new: true, runValidators: true }
    );
    return res
      .status(200)
      .json({ status: true, message: "Language updated successfully!" });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleDeleteLanguage = async (req, res) => {
  const id = req.params.id;
  try {
    const language = await Language.findById(id);
    if (!language) {
      return res
        .status(404)
        .json({ status: false, message: "Language not found" });
    }
    await Language.findByIdAndDelete(id);
    return res
      .status(200)
      .json({ status: true, message: "Language deleted successfully!" });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleGetLanguage = async (req, res) => {
  const userId = req.user.id;
  try {
    const language = await Language.find(
      { userId: userId },
      { __v: 0, createdAt: 0, updatedAt: 0 }
    );
    if (!language.length) {
      return res
        .status(404)
        .json({ status: false, message: "Language not found" });
    }

    return res.status(200).json(language);
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

module.exports = {
  handleAddLanguage,
  handleDeleteLanguage,
  handleUpdateLanguage,
  handleGetLanguage,
};
