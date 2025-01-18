const JobPreference = require("../../models/User/JobPreference");

const handleAddJobPreference = async (req, res) => {
  const jobPreference = req.body;
  const userId = req.user.id;
  try {
    const newJobPreference = new JobPreference({
      userId: userId,
      name: jobPreference.name,
      score: jobPreference.score,
    });
    await newJobPreference.save();
    return res.status(201).json({ status: true, message: "JobPreference added!" });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleUpdateJobPreference = async (req, res) => {
  const updatedJobPreference = req.body;
  const id = req.params.id;
  try {
    const jobPreference = await JobPreference.findById(id);
    if (!jobPreference) {
      return res
        .status(404)
        .json({ status: false, message: "JobPreference not found" });
    }
    await JobPreference.findByIdAndUpdate(
      id,
      {
        $set: updatedJobPreference,
      },
      { new: true, runValidators: true }
    );
    return res
      .status(200)
      .json({ status: true, message: "JobPreference updated successfully!" });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleDeleteJobPreference = async (req, res) => {
  const id = req.params.id;
  try {
    const jobPreference = await JobPreference.findById(id);
    if (!jobPreference) {
      return res
        .status(404)
        .json({ status: false, message: "JobPreference not found" });
    }
    await JobPreference.findByIdAndDelete(id);
    return res
      .status(200)
      .json({ status: true, message: "JobPreference deleted successfully!" });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleGetJobPreference = async (req, res) => {
  const userId = req.user.id;
  try {
    const jobPreference = await JobPreference.find(
      { userId: userId },
      { __v: 0, createdAt: 0, updatedAt: 0 }
    );
    if (!jobPreference.length) {
      return res
        .status(404)
        .json({ status: false, message: "JobPreference not found" });
    }

    return res.status(200).json(jobPreference);
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

module.exports = {
  handleAddJobPreference,
  handleDeleteJobPreference,
  handleUpdateJobPreference,
  handleGetJobPreference,
};
