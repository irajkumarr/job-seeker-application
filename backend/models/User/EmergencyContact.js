const mongoose = require("mongoose");

const emergencyContactSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    fullName: { type: String, required: true },
    address: String,
    relation: { type: String, required: true },
    phoneNumber: { type: String, required: true },
  },

  { timestamps: true }
);

const EmergencyContact = mongoose.model(
  "EmergencyContact",
  emergencyContactSchema
);
module.exports = EmergencyContact;
