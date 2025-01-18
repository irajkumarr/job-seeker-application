require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");
const app = express();
const PORT = process.env.PORT || 4000;

const cors = require("cors");
const compression = require("compression");

//middlewares
app.use(cors());
app.use(compression());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

//routes
const authRoutes = require("./routes/Auth/auth");
const userRoutes = require("./routes/User/user");
const userProfileRoutes = require("./routes/User/profile");
const userLanguageRoutes = require("./routes/User/language");
const userTrainingRoutes = require("./routes/User/training");

app.use("/", authRoutes);
app.use("/api/users", userRoutes);
app.use("/api/users/profile", userProfileRoutes);
app.use("/api/users/language", userLanguageRoutes);
app.use("/api/users/training", userTrainingRoutes);

//connection to MONGO DB
mongoose
  .connect(process.env.MONGO_CLOUD_URL)
  .then(() => {
    console.log("Mongo DB connected!!");
  })
  .catch((error) => {
    console.log("Mongo DB connection error: ", error);
  });

//connection to server listening to port 4000
app.listen(PORT, () => {
  console.log(`Server connected at http://localhost:${PORT}`);
});
