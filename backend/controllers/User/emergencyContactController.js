const EmergencyContact = require("../../models/User/EmergencyContact");

const handleAddEmergencyContact = async (req, res) => {
  const emergencyContact = req.body;
  const userId = req.user.id;
  try {
    const newEmergencyContact = new EmergencyContact({
      userId: userId,
      fullName: emergencyContact.fullName,
      address: emergencyContact.address,
      relation:emergencyContact.relation,
      phoneNumber:emergencyContact.phoneNumber,
    });
    await newEmergencyContact.save();
    return res.status(201).json({ status: true, message: "EmergencyContact added!" });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleUpdateEmergencyContact = async (req, res) => {
  const updatedEmergencyContact = req.body;
  const id = req.params.id;
  try {
    const emergencyContact = await EmergencyContact.findById(id);
    if (!emergencyContact) {
      return res
        .status(404)
        .json({ status: false, message: "EmergencyContact not found" });
    }
    await EmergencyContact.findByIdAndUpdate(
      id,
      {
        $set: updatedEmergencyContact,
      },
      { new: true, runValidators: true }
    );
    return res
      .status(200)
      .json({ status: true, message: "EmergencyContact updated successfully!" });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleDeleteEmergencyContact = async (req, res) => {
  const id = req.params.id;
  try {
    const emergencyContact = await EmergencyContact.findById(id);
    if (!emergencyContact) {
      return res
        .status(404)
        .json({ status: false, message: "EmergencyContact not found" });
    }
    await EmergencyContact.findByIdAndDelete(id);
    return res
      .status(200)
      .json({ status: true, message: "EmergencyContact deleted successfully!" });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleGetEmergencyContact = async (req, res) => {
  const userId = req.user.id;
  try {
    const emergencyContact = await EmergencyContact.find(
      { userId: userId },
      { __v: 0, createdAt: 0, updatedAt: 0 }
    );
    if (!emergencyContact.length) {
      return res
        .status(404)
        .json({ status: false, message: "EmergencyContact not found" });
    }

    return res.status(200).json(emergencyContact);
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

module.exports = {
  handleAddEmergencyContact,
  handleDeleteEmergencyContact,
  handleUpdateEmergencyContact,
  handleGetEmergencyContact,
};
