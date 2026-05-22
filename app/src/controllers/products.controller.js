const products = require("../data/products.data");

const getAllProducts = (req, res) => {
  const { category } = req.query;
  const filtered = category
    ? products.filter((p) => p.category.toLowerCase() === category.toLowerCase())
    : products;

  res.status(200).json({
    success: true,
    total: filtered.length,
    products: filtered,
  });
};

const getProductById = (req, res) => {
  const product = products.find((p) => p.id === parseInt(req.params.id));
  if (!product) {
    return res.status(404).json({ success: false, message: "Product not found" });
  }
  res.status(200).json({ success: true, product });
};

module.exports = { getAllProducts, getProductById };