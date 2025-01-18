const Training = require("../../models/User/Training");

const handleAddTraining = async (req, res) => {
  const training = req.body;
  const userId = req.user.id;
  try {
    const newTraining = new Training({
      userId: userId,
      name: training.name,
      institute: training.institute,
      duration: training.duration,
      completionYear: training.completionYear,
    });
    await newTraining.save();
    return res.status(201).json({ status: true, message: "Training added!" });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleUpdateTraining = async (req, res) => {
  const updatedTraining = req.body;
  const id = req.params.id;
  try {
    const training = await Training.findById(id);
    if (!training) {
      return res
        .status(404)
        .json({ status: false, message: "Training not found" });
    }
    await Training.findByIdAndUpdate(
      id,
      {
        $set: updatedTraining,
      },
      { new: true, runValidators: true }
    );
    return res
      .status(200)
      .json({ status: true, message: "Training updated successfully!" });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleDeleteTraining = async (req, res) => {
  const id = req.params.id;
  try {
    const training = await Training.findById(id);
    if (!training) {
      return res
        .status(404)
        .json({ status: false, message: "Training not found" });
    }
    await Training.findByIdAndDelete(id);
    return res
      .status(200)
      .json({ status: true, message: "Training deleted successfully!" });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleGetTraining = async (req, res) => {
  const userId = req.user.id;
  try {
    const training = await Training.find(
      { userId: userId },
      { __v: 0, createdAt: 0, updatedAt: 0 }
    );
    if (!training.length) {
      return res
        .status(404)
        .json({ status: false, message: "Training not found" });
    }

    return res.status(200).json(training);
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

module.exports = {
  handleAddTraining,
  handleDeleteTraining,
  handleUpdateTraining,
  handleGetTraining,
};
