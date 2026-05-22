const users = require("../data/users.data");
const orders = require("../data/orders.data");

const getProfile = (req, res) => {
  const user = users.find((u) => u.id === parseInt(req.params.id));
  if (!user) {
    return res.status(404).json({ success: false, message: "Profile not found" });
  }
  const userOrders = orders.filter((o) => o.userId === user.id);
  res.status(200).json({
    success: true,
    profile: {
      ...user,
      totalOrders: userOrders.length,
      orders: userOrders,
    },
  });
};

module.exports = { getProfile };