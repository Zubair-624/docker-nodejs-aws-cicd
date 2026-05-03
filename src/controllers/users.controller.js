const users = require("../data/users.data");

const getAllUsers = (req, res) => {
  res.status(200).json({
    success: true,
    total: users.length,
    users,
  });
};

const getUserById = (req, res) => {
  const user = users.find((u) => u.id === parseInt(req.params.id));
  if (!user) {
    return res.status(404).json({ success: false, message: "User not found" });
  }
  res.status(200).json({ success: true, user });
};

const createUser = (req, res) => {
  const { name, email, role, age, location } = req.body;
  if (!name || !email) {
    return res.status(400).json({ success: false, message: "Name and email are required" });
  }
  const newUser = {
    id: users.length + 1,
    name,
    email,
    role: role || "user",
    age: age || null,
    location: location || "Unknown",
    joinedAt: new Date().toISOString().split("T")[0],
  };
  users.push(newUser);
  res.status(201).json({ success: true, message: "User created successfully", user: newUser });
};

module.exports = { getAllUsers, getUserById, createUser };