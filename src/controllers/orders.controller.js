const orders = require("../data/orders.data");
const users = require("../data/users.data");
const products = require("../data/products.data");

const getAllOrders = (req, res) => {
  const enriched = orders.map((order) => ({
    ...order,
    user: users.find((u) => u.id === order.userId)?.name || "Unknown",
    product: products.find((p) => p.id === order.productId)?.name || "Unknown",
  }));

  res.status(200).json({ success: true, total: enriched.length, orders: enriched });
};

const createOrder = (req, res) => {
  const { userId, productId, quantity } = req.body;
  if (!userId || !productId || !quantity) {
    return res.status(400).json({ success: false, message: "userId, productId and quantity are required" });
  }
  const product = products.find((p) => p.id === parseInt(productId));
  if (!product) {
    return res.status(404).json({ success: false, message: "Product not found" });
  }
  const newOrder = {
    id: orders.length + 1,
    userId: parseInt(userId),
    productId: parseInt(productId),
    quantity: parseInt(quantity),
    totalPrice: parseFloat((product.price * quantity).toFixed(2)),
    status: "pending",
    orderedAt: new Date().toISOString().split("T")[0],
  };
  orders.push(newOrder);
  res.status(201).json({ success: true, message: "Order placed successfully", order: newOrder });
};

module.exports = { getAllOrders, createOrder };