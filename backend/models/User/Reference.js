const mongoose = require("mongoose");

const referenceSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    name: { type: String, required: true },
    designation: { type: String, required: true },
    organization: { type: String, required: true },
    email: { type: String, required: true },
    phoneNumber: { type: String, required: true },
  },
  { timestamps: true }
);

const Reference = mongoose.model("Reference", referenceSchema);
module.exports = Reference;
