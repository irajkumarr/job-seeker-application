const mongoose = require("mongoose");
const educationSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    level: { type: String, required: true },
    educationProgram: { type: String, required: true },
    educationBoard: { type: String, required: true },
    institution: { type: String, required: true },
    startDate: {
      year: String,
      month: String,
    },
    graduationYear: {
      year: String,
      month: String,
    },
    grade: {
      type: {
        type: String,
        enum: ["CGPA", "Percentage"],
      },
      marks: String,
    },
  },
  { timestamps: true }
);

const Education = mongoose.model("Education", educationSchema);

module.exports = Education;
