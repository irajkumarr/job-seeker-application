const JobApplication = require("../../models/job_application/JobApplication");
const User = require("../../models/user/user");
const JobPosting = require("../../models/job_posting/JobPosting");
const mongoose = require("mongoose");
// Create a new job application

const handleCreateJobApplication = async (req, res) => {
  try {
    const { jobId, coverLetter } = req.body;
    const applicantId = req.user.id;

    // Find the job posting by jobId
    const jobPosting = await JobPosting.findById(jobId);
    if (!jobPosting) {
      return res.status(404).json({ message: "Job posting not found" });
    }

    // Find the user/applicant
    const user = await User.findById(applicantId);
    if (!user) {
      return res.status(404).json({ message: "Applicant not found" });
    }

    // Check if the user has already applied for this job
    const existingApplication = await JobApplication.findOne({
      job: jobId,
      applicant: applicantId,
    });
    if (existingApplication) {
      return res
        .status(400)
        .json({ message: "You have already applied for this job" });
    }

    // Create a new job application
    const newJobApplication = new JobApplication({
      job: jobId,
      applicant: applicantId,
      coverLetter,
    });

    await newJobApplication.save();

    // Return the created job application
    res.status(201).json(newJobApplication);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server error" });
  }
};

const handleCheckJobApplicationStatus = async (req, res) => {
  try {
    const { jobId } = req.params;
    const applicantId = req.user.id;

    // Check if the user has applied for this job
    const existingApplication = await JobApplication.findOne({
      job: jobId,
      applicant: applicantId,
    });

    res.status(200).json({
      hasApplied: !!existingApplication,
      applicationId: existingApplication ? existingApplication._id : null,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server error" });
  }
};
const handleGetAllJobApplications = async (req, res) => {
  try {
    const jobApplications = await JobApplication.find({
      applicant: req.user.id,
    })
      .populate({
        path: "job",
        populate: {
          path: "company",
          populate: {
            path: "industry",
          },
        },
      })
      .sort({ createdAt: -1 });
    res.status(200).json(jobApplications);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

const handleGetJobPostingById = async (req, res) => {
  try {
    const { id } = req.params;

    const jobPosting = await JobPosting.findById(id).populate({
      path: "company",

      populate: {
        path: "industry",
      },
    });

    if (!jobPosting) {
      return res.status(404).json({ message: "Job posting not found" });
    }

    res.status(200).json(jobPosting);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Get all job applications for a job posting
const handleGetJobApplicationsByJob = async (req, res) => {
  try {
    const { jobId } = req.params;

    const jobApplications = await JobApplication.aggregate([
      {
        $match: { job: new mongoose.Types.ObjectId(jobId) }, // Match jobId
      },
      {
        $lookup: {
          from: "users", // Collection for users
          localField: "applicant", // Field in JobApplication referring to applicant
          foreignField: "_id", // Field in users collection
          as: "applicant", // Alias for applicant data
        },
      },
      {
        $unwind: "$applicant", // Flatten the applicant array since $lookup returns an array
      },
      {
        $lookup: {
          from: "profiles", // Collection for profiles
          localField: "applicant._id", // Match user's _id
          foreignField: "userId", // Field in profiles referencing userId
          as: "applicant.profile", // Alias for profile data
        },
      },
      {
        $lookup: {
          from: "experiences", // Collection for experiences
          localField: "applicant._id", // Match user's _id
          foreignField: "userId",
          as: "applicant.experiences",
        },
      },
      {
        $lookup: {
          from: "documents", // Collection for documents
          localField: "applicant._id",
          foreignField: "userId",
          as: "applicant.documents",
        },
      },
      {
        $lookup: {
          from: "trainings", // Collection for trainings
          localField: "applicant._id",
          foreignField: "userId",
          as: "applicant.trainings",
        },
      },
      {
        $lookup: {
          from: "socialaccounts", // Collection for social accounts
          localField: "applicant._id",
          foreignField: "userId",
          as: "applicant.socialaccounts",
        },
      },
      {
        $lookup: {
          from: "references", // Collection for references
          localField: "applicant._id",
          foreignField: "userId",
          as: "applicant.references",
        },
      },
      {
        $lookup: {
          from: "languages", // Collection for languages
          localField: "applicant._id",
          foreignField: "userId",
          as: "applicant.languages",
        },
      },
      {
        $lookup: {
          from: "educations", // Collection for educations
          localField: "applicant._id",
          foreignField: "userId",
          as: "applicant.educations",
        },
      },
      {
        $lookup: {
          from: "emergencycontacts", // Collection for emergency contacts
          localField: "applicant._id",
          foreignField: "userId",
          as: "applicant.emergencycontacts",
        },
      },
      // Optionally, you can use $project to exclude sensitive fields like passwords
      {
        $project: {
          "applicant.password": 0,
          "applicant._id": 0,

          "applicant.profile._id": 0,
          "applicant.experiences._id": 0, // Exclude sensitive fields from subcollections
          "applicant.documents._id": 0,
          "applicant.trainings._id": 0,
          "applicant.socialaccounts._id": 0,
          "applicant.references._id": 0,
          "applicant.languages._id": 0,
          "applicant.educations._id": 0,
          "applicant.emergencycontacts._id": 0,
        },
      },
      {
        $lookup: {
          from: "jobpostings", // Populate job details from the job postings collection
          localField: "job", // Field in JobApplication
          foreignField: "_id", // Field in JobPosting
          as: "job", // Alias for job data
        },
      },
      {
        $unwind: "$job", // Flatten the job data
      },
    ]);

    if (jobApplications.length === 0) {
      return res
        .status(404)
        .json({ message: "No applications found for this job" });
    }

    res.status(200).json(jobApplications);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server error" });
  }
};

// Get job applications by applicant
const handleGetJobApplicationsByApplicant = async (req, res) => {
  try {
    const applicantId = req.user.id;
    const { status } = req.query;

    // Build the query object
    let query = { applicant: applicantId };

    if (status) {
      query.status = status;
    }

    const jobApplications = await JobApplication.find(query)
      .populate("job", "title description")
      .select("job coverLetter status")
      .exec();

    if (jobApplications.length === 0) {
      return res
        .status(404)
        .json({ message: "No applications found for this applicant" });
    }

    res.status(200).json(jobApplications);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server error" });
  }
};

// Update job application status
const handleUpdateJobApplicationStatus = async (req, res) => {
  try {
    const { applicationId } = req.params;
    const { status } = req.body;

    if (
      !["pending", "shortlisted", "rejected", "hired", "withdrawn"].includes(
        status
      )
    ) {
      return res.status(400).json({ message: "Invalid status" });
    }

    const jobApplication = await JobApplication.findById(applicationId);
    if (!jobApplication) {
      return res.status(404).json({ message: "Job application not found" });
    }

    jobApplication.status = status;
    jobApplication.updatedAt = Date.now();
    await jobApplication.save();

    res.status(200).json(jobApplication);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server error" });
  }
};

// Add note to job application
const handleAddNoteToJobApplication = async (req, res) => {
  try {
    const { applicationId } = req.params;
    const { addedBy, content } = req.body;

    const jobApplication = await JobApplication.findById(applicationId);
    if (!jobApplication) {
      return res.status(404).json({ message: "Job application not found" });
    }

    jobApplication.notes.push({
      addedBy,
      content,
    });

    await jobApplication.save();
    res.status(200).json(jobApplication);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server error" });
  }
};

// Add feedback to job application
const handleAddFeedbackToJobApplication = async (req, res) => {
  try {
    const { applicationId } = req.params;
    const { feedback } = req.body;

    const jobApplication = await JobApplication.findById(applicationId);
    if (!jobApplication) {
      return res.status(404).json({ message: "Job application not found" });
    }

    jobApplication.feedback = feedback;
    jobApplication.updatedAt = Date.now();
    await jobApplication.save();

    res.status(200).json(jobApplication);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server error" });
  }
};

// Delete a job application
const handleDeleteJobApplication = async (req, res) => {
  try {
    const { applicationId } = req.params;

    const jobApplication = await JobApplication.findByIdAndDelete(
      applicationId
    );
    if (!jobApplication) {
      return res.status(404).json({ message: "Job application not found" });
    }

    res.status(200).json({ message: "Job application deleted successfully" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server error" });
  }
};

module.exports = {
  handleAddFeedbackToJobApplication,
  handleGetAllJobApplications,
  handleAddNoteToJobApplication,
  handleCreateJobApplication,
  handleDeleteJobApplication,
  handleUpdateJobApplicationStatus,
  handleGetJobApplicationsByJob,
  handleGetJobApplicationsByApplicant,
  handleCheckJobApplicationStatus,
};
