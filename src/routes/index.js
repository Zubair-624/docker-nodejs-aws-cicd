const express = require("express");
const router = express.Router();

const homeRoute = require("./home.route");
const healthRoute = require("./health.route");
const aboutRoute = require("./about.route");
const contactRoute = require("./contact.route");
const usersRoute = require("./users.route");
const productsRoute = require("./products.route");
const ordersRoute = require("./orders.route");
const authRoute = require("./auth.route");
const profileRoute = require("./profile.route");
const dashboardRoute = require("./dashboard.route");

router.use("/", homeRoute);
router.use("/health", healthRoute);
router.use("/about", aboutRoute);
router.use("/contact", contactRoute);
router.use("/users", usersRoute);
router.use("/products", productsRoute);
router.use("/orders", ordersRoute);
router.use("/auth", authRoute);
router.use("/profile", profileRoute);
router.use("/dashboard", dashboardRoute);

module.exports = router;