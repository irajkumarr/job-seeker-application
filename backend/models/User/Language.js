const mongoose = require("mongoose");

const languagesSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    name: { type: String, required: true },
    proficiency: {
      type: String,
      enum: ["basic", "intermediate", "fluent", "native"],
      required: true,
    },
  },
  { timestamps: true }
);

const Language = mongoose.model("Language", languagesSchema);
module.exports = Language;
