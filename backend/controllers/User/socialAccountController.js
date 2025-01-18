const SocialAccount = require("../../models/User/SocialAccount");

const handleAddSocialAccount = async (req, res) => {
  const socialAccount = req.body;
  const userId = req.user.id;
  try {
    const newSocialAccount = new SocialAccount({
      userId: userId,
      platform: socialAccount.platform,
      url: socialAccount.url,
    });
    await newSocialAccount.save();
    return res
      .status(201)
      .json({ status: true, message: "SocialAccount added!" });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleUpdateSocialAccount = async (req, res) => {
  const updatedSocialAccount = req.body;
  const id = req.params.id;
  try {
    const socialAccount = await SocialAccount.findById(id);
    if (!socialAccount) {
      return res
        .status(404)
        .json({ status: false, message: "SocialAccount not found" });
    }
    await SocialAccount.findByIdAndUpdate(
      id,
      {
        $set: updatedSocialAccount,
      },
      { new: true, runValidators: true }
    );
    return res
      .status(200)
      .json({ status: true, message: "SocialAccount updated successfully!" });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleDeleteSocialAccount = async (req, res) => {
  const id = req.params.id;
  try {
    const socialAccount = await SocialAccount.findById(id);
    if (!socialAccount) {
      return res
        .status(404)
        .json({ status: false, message: "SocialAccount not found" });
    }
    await SocialAccount.findByIdAndDelete(id);
    return res
      .status(200)
      .json({ status: true, message: "SocialAccount deleted successfully!" });
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

const handleGetSocialAccount = async (req, res) => {
  const userId = req.user.id;
  try {
    const socialAccount = await SocialAccount.find(
      { userId: userId },
      { __v: 0, createdAt: 0, updatedAt: 0 }
    );
    if (!socialAccount.length) {
      return res
        .status(404)
        .json({ status: false, message: "SocialAccount not found" });
    }

    return res.status(200).json(socialAccount);
  } catch (error) {
    return res.status(500).json({ status: false, message: error.message });
  }
};

module.exports = {
  handleAddSocialAccount,
  handleDeleteSocialAccount,
  handleUpdateSocialAccount,
  handleGetSocialAccount,
};
