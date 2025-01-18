const mongoose = require("mongoose");

const socialAccountSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    platform: {
      type: String,
      enum: ["youtube", "facebook", "instagram", "linkedin"],
    },
    url: { type: String, required: true },
  },
  { timestamps: true }
);

const SocialAccount = mongoose.model("SocialAccount", socialAccountSchema);
module.exports = SocialAccount;
