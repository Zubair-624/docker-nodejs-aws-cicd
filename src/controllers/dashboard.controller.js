const users = require("../data/users.data");
const products = require("../data/products.data");
const orders = require("../data/orders.data");

const getStats = (req, res) => {
  const totalRevenue = orders.reduce((sum, o) => sum + o.totalPrice, 0);
  const ordersByStatus = orders.reduce((acc, o) => {
    acc[o.status] = (acc[o.status] || 0) + 1;
    return acc;
  }, {});

  res.status(200).json({
    success: true,
    dashboard: {
      totalUsers: users.length,
      totalProducts: products.length,
      totalOrders: orders.length,
      totalRevenue: `$${totalRevenue.toFixed(2)}`,
      ordersByStatus,
      topProduct: products.reduce((a, b) => (a.rating > b.rating ? a : b)).name,
    },
  });
};

module.exports = { getStats };