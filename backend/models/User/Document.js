const mongoose = require("mongoose");
const documentSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    title: { type: String, required: true },
    category: {
      type: String,
      enum: ["resume", "cv", "citizenship", "other"],
      required: true,
    },
    file: { type: String, required: true },
    uploadDate: { type: Date, default: Date.now },
  },
  { timestamps: true }
);

const Document = mongoose.model("Document", documentSchema);

module.exports = Document;
