const Document = require("../../models/User/Document");
const cloudinary = require("../../utils/cloudinary");

const handleAddDocument = async (req, res) => {
  const userId = req.user.id;

  try {
    if (!req.file) {
      return res
        .status(400)
        .json({ status: false, message: "No file provided." });
    }

    // Upload file to Cloudinary using a Promise
    const uploadFileToCloudinary = (fileBuffer) => {
      return new Promise((resolve, reject) => {
        const uploadStream = cloudinary.uploader.upload_stream(
          { folder: "documents", resource_type: "raw" }, // 'raw' for non-image files
          (error, result) => {
            if (error) {
              reject(error);
            } else {
              resolve(result);
            }
          }
        );
        uploadStream.end(fileBuffer); // Send file buffer to the stream
      });
    };

    const uploadResult = await uploadFileToCloudinary(req.file.buffer);

    // Create a new document with the Cloudinary URL
    const newDocument = new Document({
      userId: userId,
      title: req.body.title,
      category: req.body.category,
      file: uploadResult.secure_url, // Store the Cloudinary URL
      uploadDate: req.body.uploadDate || new Date(),
    });

    await newDocument.save();

    return res.status(201).json({
      status: true,
      message: "Document added!",
      document: newDocument,
    });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ status: false, message: error.message });
  }
};



const handleUpdateDocument = async (req, res) => {
  const id = req.params.id;
  const { title, category } = req.body; // Destructure relevant fields
  const file = req.file; // File from multer
  try {
    // Check if the document exists
    const document = await Document.findById(id);
    if (!document) {
      return res
        .status(404)
        .json({ status: false, message: "Document not found" });
    }

    let updatedFields = { title, category };

    // If a new file is provided, upload it to Cloudinary
    if (file) {
      const uploadResult = await new Promise((resolve, reject) => {
        const uploadStream = cloudinary.uploader.upload_stream(
          {
            resource_type: "auto", // Automatically detect file type
            folder: "documents",
          },
          (error, result) => {
            if (error) {
              return reject(new Error("Failed to upload file to Cloudinary"));
            }
            resolve(result);
          }
        );
        uploadStream.end(file.buffer); // Use the buffer from multer's memory storage
      });

      updatedFields.file = uploadResult.secure_url; // Update the file URL
    }

    // Update the document
    const updatedDocument = await Document.findByIdAndUpdate(
      id,
      { $set: updatedFields },
      { new: true, runValidators: true }
    );

    return res.status(200).json({
      status: true,
      message: "Document updated successfully!",
      document: updatedDocument,
    });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleDeleteDocument = async (req, res) => {
  const id = req.params.id;
  try {
    const document = await Document.findById(id);
    if (!document) {
      return res
        .status(404)
        .json({ status: false, message: "Document not found" });
    }
    await Document.findByIdAndDelete(id);
    return res
      .status(200)
      .json({ status: true, message: "Document deleted successfully!" });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleGetDocument = async (req, res) => {
  const userId = req.user.id;
  try {
    const document = await Document.find(
      { userId: userId },
      { __v: 0, createdAt: 0, updatedAt: 0 }
    );
    if (!document.length) {
      return res
        .status(404)
        .json({ status: false, message: "Document not found" });
    }

    return res.status(200).json(document);
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

module.exports = {
  handleAddDocument,
  handleDeleteDocument,
  handleUpdateDocument,
  handleGetDocument,
};
