const mongoose = require("mongoose");
const educationSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    level: { type: String, required: true },
    institution: { type: String, required: true },
    major: String,
    startDate: Date,
    endDate: Date,
    grade: String,
  },
  { timestamps: true }
);

const Education = mongoose.model("Education", educationSchema);

module.exports = Education;
