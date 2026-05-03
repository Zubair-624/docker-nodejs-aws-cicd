const express = require("express");
const morgan = require("morgan");

const router = require("./routes/index");
const notFound = require("./middleware/notFound.middleware");
const errorHandler = require("./middleware/errorHandler.middleware");
const logger = require("./middleware/logger.middleware");

const app = express();

//----------Global Middleware ----------
app.use(logger);                              
app.use(express.json());                      
app.use(express.urlencoded({ extended: true }));

//----------Routes----------
app.use("/", router);

//----------404 Handler----------
app.use(notFound);

//----------Global Error Handler----------
app.use(errorHandler);

module.exports = app;