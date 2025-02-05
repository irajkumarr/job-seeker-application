const JobPosting = require("../../models/job_posting/JobPosting");
const { handleUpdateJobCount } = require("../industry/industryController");

const handleCreateJobPosting = async (req, res) => {
  try {
    const { company, ...jobData } = req.body;

    if (!company) {
      return res.status(400).json({ message: "Company reference is required" });
    }

    // Create the job posting
    const jobPosting = new JobPosting({ company, ...jobData });
    await jobPosting.save();

    // Populate the company field to access the industry
    const populatedJobPosting = await jobPosting.populate({
      path: "company",
      select: "industry",
    });

    const industryId = populatedJobPosting.company.industry;

    // Update job count in the industry metadata
    if (industryId) {
      await handleUpdateJobCount(industryId, 1); // Increment job count by 1
    }

    res
      .status(201)
      .json({ message: "Job posting created successfully", jobPosting });
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: error.message });
  }
};

const handleGetAllJobPostings = async (req, res) => {
  try {
    const jobPostings = await JobPosting.find()
      .populate("company")
      .sort({ createdAt: -1 });
    res.status(200).json(jobPostings);
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
const handleUpdateJobPosting = async (req, res) => {
  try {
    const { id } = req.params;

    const updatedJobPosting = await JobPosting.findByIdAndUpdate(id, req.body, {
      new: true,
      runValidators: true,
    });

    if (!updatedJobPosting) {
      return res.status(404).json({ message: "Job posting not found" });
    }

    res
      .status(200)
      .json({ message: "Job posting updated successfully", updatedJobPosting });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};
const handleDeleteJobPosting = async (req, res) => {
  try {
    const { id } = req.params;

    const deletedJobPosting = await JobPosting.findByIdAndDelete(id);

    if (!deletedJobPosting) {
      return res.status(404).json({ message: "Job posting not found" });
    }

    res.status(200).json({ message: "Job posting deleted successfully" });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

const handleFilterJobPostings = async (req, res) => {
  try {
    const {
      location,
      category, // Category from the `Company` model
      education,
      salary,
      experience,
      industryTitle, // Filter by industry title
    } = req.query;

    // Build the query dynamically
    const query = {};

    if (location) {
      // If location is provided, we will assume it's the district and filter based on that.
      query["location.district"] = location.trim(); // Directly match the district
    }

    // Filter by education
    if (education) {
      query["basicInformation.education"] = education;
    }

    // Filter by salary (greater than or equal to specified salary)
    if (salary) {
      query.salary = { $gte: parseFloat(salary) }; // Ensure salary is greater than or equal to the specified value
    }

    // Filter by experience (greater than or equal to specified experience)
    if (experience) {
      query["basicInformation.experience"] = { $gte: parseInt(experience) }; // Ensure experience is greater than or equal to the specified value
    }

    // Fetch and filter job postings with company category and industry title if provided
    const filteredJobs = await JobPosting.find(query).populate({
      path: "company",
      match: {
        ...(category ? { category } : {}), // Filter by company category if specified
      },
      populate: {
        path: "industry", // Populate the industry reference
        match: industryTitle ? { name: industryTitle } : {}, // Filter by industry title if specified
      },
    });

    // Remove jobs where the company or industry filter did not match
    const result = filteredJobs.filter(
      (job) => job.company && job.company.industry
    );

    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

const handleGetJobsByDistrict = async (req, res) => {
  const { district } = req.query; // Expecting the district name from query parameters

  if (!district) {
    return res.status(400).json({
      status: false,
      message: "District query parameter is required",
    });
  }

  try {
    // Find jobs that match the specified district
    const jobs = await JobPosting.find({ "location.district": district.trim() })
      .populate("company", "name industry") // Adjust fields as needed
      .exec();

    if (jobs.length === 0) {
      return res.status(404).json({
        status: false,
        message: `No jobs found in district: ${district}`,
      });
    }

    res.status(200).json({
      status: true,
      message: `Jobs retrieved successfully for district: ${district}`,
      jobs,
    });
  } catch (error) {
    res.status(500).json({
      status: false,
      message: "Failed to retrieve jobs",
      error: error.message,
    });
  }
};
const handleGetUniqueJobDistricts = async (req, res) => {
  try {
    // Aggregate to get unique districts
    const uniqueDistricts = await JobPosting.aggregate([
      {
        $group: {
          _id: "$location.district", // Group by district
        },
      },
      {
        $project: {
          _id: 0,
          district: "$_id", // Rename _id to district
        },
      },
      {
        $sort: { district: 1 }, // Optional: Sort districts alphabetically
      },
    ]);

    res.status(200).json({
      status: true,
      message: "Unique job districts retrieved successfully",
      districts: uniqueDistricts.map((d) => d.district),
    });
  } catch (error) {
    res.status(500).json({
      status: false,
      message: "Failed to retrieve unique job districts",
      error: error.message,
    });
  }
};

module.exports = {
  handleCreateJobPosting,
  handleGetAllJobPostings,
  handleGetJobPostingById,
  handleUpdateJobPosting,
  handleDeleteJobPosting,
  handleFilterJobPostings,
  handleGetJobsByDistrict,
  handleGetUniqueJobDistricts,
};
