const users = require("../data/users.data");

const login = (req, res) => {
  const { email, password } = req.body;
  if (!email || !password) {
    return res.status(400).json({ success: false, message: "Email and password are required" });
  }
  const user = users.find((u) => u.email === email);
  if (!user) {
    return res.status(401).json({ success: false, message: "Invalid email or password" });
  }
  res.status(200).json({
    success: true,
    message: "Login successful",
    token: `mock-jwt-token-${user.id}-${Date.now()}`,
    user: { id: user.id, name: user.name, email: user.email, role: user.role },
  });
};

const logout = (req, res) => {
  res.status(200).json({ success: true, message: "Logged out successfully" });
};

module.exports = { login, logout };