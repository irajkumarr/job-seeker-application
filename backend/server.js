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

app.use("/", authRoutes);
app.use("/api/users", userRoutes);

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
