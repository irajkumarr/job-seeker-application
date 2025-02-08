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

// const handleFilterJobPostings = async (req, res) => {
//   try {
//     const {
//       location,
//       categories, // Category from the `Company` model
//       education,
//       salary,
//       experience,
//       category, // Filter by industry title
//     } = req.query;

//     // Build the query dynamically
//     const query = {};

//     if (location) {
//       // If location is provided, we will assume it's the district and filter based on that.
//       query["location.district"] = location.trim(); // Directly match the district
//     }

//     // Filter by education
//     if (education) {
//       query["basicInformation.education"] = education;
//     }

//     // Filter by salary (greater than or equal to specified salary)
//     if (salary) {
//       query.salary = { $gte: parseFloat(salary) }; // Ensure salary is greater than or equal to the specified value
//     }

//     // Filter by experience (greater than or equal to specified experience)
//     if (experience) {
//       query["basicInformation.experience"] = { $gte: parseInt(experience) }; // Ensure experience is greater than or equal to the specified value
//     }

//     // Fetch and filter job postings with company category and industry title if provided
//     const filteredJobs = await JobPosting.find(query).populate({
//       path: "company",
//       match: {
//         ...(categories ? { categories } : {}), // Filter by company category if specified
//       },
//       populate: {
//         path: "industry", // Populate the industry reference
//         match: category ? { name: category } : {}, // Filter by industry title if specified
//       },
//     });

//     // Remove jobs where the company or industry filter did not match
//     const result = filteredJobs.filter(
//       (job) => job.company && job.company.industry
//     );

//     res.status(200).json(result);
//   } catch (error) {
//     res.status(500).json({ message: error.message });
//   }
// };

const handleFilterJobPostings = async (req, res) => {
  try {
    const {
      location,
      categories, // Category from the `Company` model
      education,
      salary,
      experience,
      category, // Filter by industry title
      employmentForWomen,
      urgentJobs,
      jobsWithoutExperience,
    } = req.query;

    // Build the query dynamically
    const query = {};

    if (location) {
      query["location.district"] = location.trim(); // Directly match the district
    }

    if (education) {
      query["basicInformation.education"] = education;
    }

    if (salary) {
      query.salary = { $gte: parseFloat(salary) };
    }

    if (experience) {
      query["basicInformation.experience"] = { $gte: parseInt(experience) };
    }

    // ✅ Employment for Women
    if (employmentForWomen === "true") {
      query["basicInformation.gender"] = "Female";
    }

    // ✅ Urgent Jobs with Expiry Date Check
    if (urgentJobs === "true") {
      // query["isUrgent"] = true;
      query["expiryDate"] = { $gte: new Date() }; // Only fetch jobs where expiryDate is in the future
    }

    // ✅ Jobs Without Experience
    if (jobsWithoutExperience === "true") {
      query["basicInformation.experience"] = 0;
    }

    // Fetch and filter job postings
    const filteredJobs = await JobPosting.find(query).populate({
      path: "company",
      match: {
        ...(categories ? { categories } : {}), // Filter by company category if specified
      },
      populate: {
        path: "industry",
        match: category ? { name: category } : {}, // Filter by industry title if specified
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

//handle search product
// const handleSearchJob = async (req, res) => {
//   const search = req.params.search;

//   try {
//     const results = await JobPosting.aggregate([
//       {
//         $search: {
//           index: "jobs",
//           compound: {
//             should: [
//               {
//                 text: {
//                   query: search,
//                   path: ["title"],
//                   fuzzy: {
//                     maxEdits: 2,
//                     prefixLength: 1,
//                   },
//                 },
//               },
//             ],
//           },
//         },
//       },
//       {
//         $project: {
//           createdAt: 0,
//           updatedAt: 0,
//           __v: 0,
//         },
//       },
//       {
//         $limit: 15,
//       },
//     ]);
//     // if (!results.length) {
//     //   return res.status(404).json({
//     //     status: false,
//     //     message: "No products found matching your search query.",
//     //   });
//     // }

//     res.status(200).json(results);
//   } catch (error) {
//     return res.status(500).json({ status: false, message: error.message });
//   }
// };

// const handleSearchJob = async (req, res) => {
//   const search = req.params.search;

//   try {
//     const results = await JobPosting.aggregate([
//       {
//         $search: {
//           index: "jobs",
//           compound: {
//             should: [
//               {
//                 text: {
//                   query: search,
//                   path: ["title"],
//                   fuzzy: {
//                     maxEdits: 2,
//                     prefixLength: 1,
//                   },
//                 },
//               },
//             ],
//           },
//         },
//       },
//       {
//         $lookup: {
//           from: "companies", // Name of the company collection
//           localField: "company", // Field in JobPosting referencing Company
//           foreignField: "_id", // Field in Company collection
//           as: "company",
//         },
//       },
//       {
//         $unwind: {
//           path: "$companyDetails",
//           preserveNullAndEmptyArrays: true, // Keep job postings even if no company is found
//         },
//       },
//       {
//         $project: {
//           createdAt: 0,
//           updatedAt: 0,
//           __v: 0,
//           "companyDetails.__v": 0, // Exclude unnecessary fields from the company
//         },
//       },
//       {
//         $limit: 15,
//       },
//     ]);

//     res.status(200).json(results);
//   } catch (error) {
//     return res.status(500).json({ status: false, message: error.message });
//   }
// };
const handleSearchJob = async (req, res) => {
  const search = req.params.search;

  try {
    const results = await JobPosting.aggregate([
      {
        $search: {
          index: "jobs",
          compound: {
            should: [
              {
                text: {
                  query: search,
                  path: ["title"],
                  fuzzy: {
                    maxEdits: 2,
                    prefixLength: 1,
                  },
                },
              },
            ],
          },
        },
      },
      {
        $lookup: {
          from: "companies", // Collection name of companies
          localField: "company", // Field in JobPosting referencing Company
          foreignField: "_id", // Field in Company collection
          as: "company",
        },
      },
      {
        $unwind: {
          path: "$company",
          preserveNullAndEmptyArrays: true, // Keeps job even if no company is found
        },
      },
      {
        $lookup: {
          from: "industries", // Collection name of industries
          localField: "company.industry", // Field in Company referencing Industry
          foreignField: "_id", // Field in Industry collection
          as: "company.industry",
        },
      },
      {
        $unwind: {
          path: "$company.industry",
          preserveNullAndEmptyArrays: true, // Keeps company even if no industry is found
        },
      },
      // {
      //   $project: {
      //     createdAt: 0,
      //     updatedAt: 0,
      //     __v: 0,
      //     "companyDetails.__v": 0,
      //     "companyDetails.createdAt": 0,
      //     "companyDetails.updatedAt": 0,
      //     "companyDetails.industry.__v": 0, // Exclude unnecessary fields from Industry
      //     "companyDetails.industry.createdAt": 0,
      //     "companyDetails.industry.updatedAt": 0,
      //   },
      // },
      {
        $limit: 15,
      },
    ]);

    res.status(200).json(results);
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
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
  handleSearchJob,
};
