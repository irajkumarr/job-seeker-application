const mongoose = require("mongoose");

const trainingSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
      unique: true,
    },
    name: { type: String, required: true },
    institute: { type: String, required: true },
    duration: {
      value: Number,
      unit: { type: String, enum: ["days", "weeks", "months", "years"] },
    },
    completionYear: Number,
  },
  { timestamps: true }
);

const Training = mongoose.model("Training", trainingSchema);
module.exports = Training;
