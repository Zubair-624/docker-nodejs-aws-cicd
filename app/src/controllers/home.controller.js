const getHome = (req, res) => {
  res.status(200).json({
    success: true,
    message: "Welcome to the Docker Node.js AWS API!",
    version: "1.0.0",
    description: "A production-ready REST API containerized with Docker and deployed via GitHub Actions to AWS EC2.",
    developer: "Zubair Mazumder",
    github: "https://github.com/Zubair-624",
    endpoints: {
      health: "GET /health",
      about: "GET /about",
      contact: "GET /contact",
      users: "GET /users",
      products: "GET /products",
      orders: "GET /orders",
      dashboard: "GET /dashboard/stats",
      auth: "POST /auth/login",
    },
  });
};

module.exports = { getHome };