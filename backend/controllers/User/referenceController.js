const Reference = require("../../models/User/Reference");

const handleAddReference = async (req, res) => {
  const reference = req.body;
  const userId = req.user.id;
  try {
    const newReference = new Reference({
      userId: userId,
      name: reference.name,
      designation: reference.designation,
      organization: reference.organization,
      email: reference.email,
      phoneNumber: reference.phoneNumber,
    });
    await newReference.save();
    return res.status(201).json({ status: true, message: "Reference added!" });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleUpdateReference = async (req, res) => {
  const updatedReference = req.body;
  const id = req.params.id;
  try {
    const reference = await Reference.findById(id);
    if (!reference) {
      return res
        .status(404)
        .json({ status: false, message: "Reference not found" });
    }
    await Reference.findByIdAndUpdate(
      id,
      {
        $set: updatedReference,
      },
      { new: true, runValidators: true }
    );
    return res
      .status(200)
      .json({ status: true, message: "Reference updated successfully!" });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleDeleteReference = async (req, res) => {
  const id = req.params.id;
  try {
    const reference = await Reference.findById(id);
    if (!reference) {
      return res
        .status(404)
        .json({ status: false, message: "Reference not found" });
    }
    await Reference.findByIdAndDelete(id);
    return res
      .status(200)
      .json({ status: true, message: "Reference deleted successfully!" });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleGetReference = async (req, res) => {
  const userId = req.user.id;
  try {
    const reference = await Reference.find(
      { userId: userId },
      { __v: 0, createdAt: 0, updatedAt: 0 }
    );
    if (!reference.length) {
      return res
        .status(404)
        .json({ status: false, message: "Reference not found" });
    }

    return res.status(200).json(reference);
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

module.exports = {
  handleAddReference,
  handleDeleteReference,
  handleUpdateReference,
  handleGetReference,
};
