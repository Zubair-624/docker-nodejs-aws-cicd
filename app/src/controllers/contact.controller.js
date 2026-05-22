const getContact = (req, res) => {
  res.status(200).json({
    success: true,
    developer: {
      name: "Zubair Mazumder",
      github: "https://github.com/Zubair-624",
      location: "Dhaka, Bangladesh",
      role: "Backend Developer",
      skills: ["Node.js", "Docker", "AWS", "GitHub Actions", "REST APIs"],
    },
    message: "Feel free to reach out via GitHub!",
  });
};

module.exports = { getContact };