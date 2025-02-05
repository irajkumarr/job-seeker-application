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
const authRoutes = require("./routes/auth/auth");
const userRoutes = require("./routes/user/user");
const userProfileRoutes = require("./routes/user/profile");
const userLanguageRoutes = require("./routes/user/language");
const userTrainingRoutes = require("./routes/user/training");
const userEducationRoutes = require("./routes/user/education");
const userEmergencyContactRoutes = require("./routes/user/emergencyContact");
const userExperienceRoutes = require("./routes/user/experience");
const userReferenceRoutes = require("./routes/user/reference");
const userSocialAccountRoutes = require("./routes/user/socialAccount");
const userDocumentRoutes = require("./routes/user/document");
const userOtherInformationRoutes = require("./routes/user/otherInformation");

const industryRoutes = require("./routes/industry/industry");
const companyRoutes = require("./routes/company/company");
const jobPostingRoutes = require("./routes/job_posting/jobPosting");
const jobApplicationRoutes = require("./routes/job_application/jobApplication");

app.use("/", authRoutes);
app.use("/api/users", userRoutes);
app.use("/api/users/profile", userProfileRoutes);
app.use("/api/users/language", userLanguageRoutes);
app.use("/api/users/training", userTrainingRoutes);
app.use("/api/users/education", userEducationRoutes);
app.use("/api/users/contact", userEmergencyContactRoutes);
app.use("/api/users/experience", userExperienceRoutes);
app.use("/api/users/reference", userReferenceRoutes);
app.use("/api/users/socialAccount", userSocialAccountRoutes);
app.use("/api/users/document", userDocumentRoutes);
app.use("/api/users/otherInformation", userOtherInformationRoutes);
app.use("/api/industries", industryRoutes);
app.use("/api/companies", companyRoutes);
app.use("/api/jobs", jobPostingRoutes);
app.use("/api/applications", jobApplicationRoutes);

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
