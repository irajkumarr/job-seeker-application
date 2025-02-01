const mongoose = require("mongoose");

const trainingSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    name: { type: String, required: true },
    institute: { type: String, required: true },
    duration: {
      value: String,
      unit: { type: String, enum: ["Days", "Months", "Years"] },
    },
    completionYear: {
      year: String,
      month: String,
    },
  },
  { timestamps: true }
);

const Training = mongoose.model("Training", trainingSchema);
module.exports = Training;
