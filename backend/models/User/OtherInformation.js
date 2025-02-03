const mongoose = require("mongoose");

const otherInformationSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    willingToTravelOutsideResidingLocation: { type: Boolean, default: false },
    willingToRelocateOutsideResidingLocation: { type: Boolean, default: false },
    haveTwoWheelerDrivingLicense: { type: Boolean, default: false },
    havefourWheelerDrivingLicense: { type: Boolean, default: false },
    ownTwoWheelerVehicle: { type: Boolean, default: false },
    ownFourWheelerVehicle: { type: Boolean, default: false },
  },

  { timestamps: true }
);

const OtherInformation = mongoose.model(
  "OtherInformation",
  otherInformationSchema
);
module.exports = OtherInformation;
