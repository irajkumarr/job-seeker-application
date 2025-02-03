const OtherInformation = require("../../models/User/OtherInformation");

const handleAddOtherInformation = async (req, res) => {
  const otherInformation = req.body;
  const userId = req.user.id;
  try {
    const newOtherInformation = new OtherInformation({
      userId: userId,
      willingToTravelOutsideResidingLocation: otherInformation.willingToTravelOutsideResidingLocation,
      willingToRelocateOutsideResidingLocation: otherInformation.willingToRelocateOutsideResidingLocation,
      haveTwoWheelerDrivingLicense: otherInformation.haveTwoWheelerDrivingLicense,
      havefourWheelerDrivingLicense: otherInformation.havefourWheelerDrivingLicense,
      ownTwoWheelerVehicle: otherInformation.ownTwoWheelerVehicle,
      ownFourWheelerVehicle: otherInformation.ownFourWheelerVehicle,
    });
    await newOtherInformation.save();
    return res
      .status(201)
      .json({ status: true, message: "OtherInformation added!" });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleUpdateOtherInformation = async (req, res) => {
  const updatedOtherInformation = req.body;
  const id = req.params.id;
  try {
    const otherInformation = await OtherInformation.findById(id);
    if (!otherInformation) {
      return res
        .status(404)
        .json({ status: false, message: "OtherInformation not found" });
    }
    await OtherInformation.findByIdAndUpdate(
      id,
      {
        $set: updatedOtherInformation,
      },
      { new: true, runValidators: true }
    );
    return res
      .status(200)
      .json({
        status: true,
        message: "OtherInformation updated successfully!",
      });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleDeleteOtherInformation = async (req, res) => {
  const id = req.params.id;
  try {
    const otherInformation = await OtherInformation.findById(id);
    if (!otherInformation) {
      return res
        .status(404)
        .json({ status: false, message: "OtherInformation not found" });
    }
    await OtherInformation.findByIdAndDelete(id);
    return res.status(200).json({
      status: true,
      message: "OtherInformation deleted successfully!",
    });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleGetOtherInformation = async (req, res) => {
  const userId = req.user.id;
  try {
    const otherInformation = await OtherInformation.find(
      { userId: userId },
      { __v: 0, createdAt: 0, updatedAt: 0 }
    );
    if (!otherInformation.length) {
      return res
        .status(404)
        .json({ status: false, message: "OtherInformation not found" });
    }

    return res.status(200).json(otherInformation);
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

module.exports = {
  handleAddOtherInformation,
  handleDeleteOtherInformation,
  handleUpdateOtherInformation,
  handleGetOtherInformation,
};
