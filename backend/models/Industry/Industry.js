const mongoose = require("mongoose");

const industrySchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: true,
      unique: true,
      trim: true,
    },
    status: {
      type: Boolean,
      default: true,
    },
    image: {
      type: String,
    },
    metadata: {
      jobCount: {
        type: Number,
        default: 0,
      },
      companyCount: {
        type: Number,
        default: 0,
      },
    },
  },
  {
    timestamps: true,
  }
);

const Industry = mongoose.model("Industry", industrySchema);
module.exports = Industry;
