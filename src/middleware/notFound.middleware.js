const { status } = require("express/lib/response")

const notFound = (req, res, next) => {
    res.status(404).json({
        success: false,
        status: 404,
        message: `Route not found: ${req.method} ${req.originalUrl}`,
        availableRoutes: [
            "GET /",
            "GET /health",
            "GET /about",
            "GET /contace",
            "GET /users", 
            "POST /users", 
            "GET /products",
            "GET /products/:id",
            "GET /orders",
            "POST /orders",
            "GET /profile/:id",
            "GET /dashboard/stats",
            "POST /auth/login",

        ],
    });
};

module.exports = notFound;