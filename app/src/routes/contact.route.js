const express = require("express");
const router = express.Router();
const { getContact } = require("../controllers/contact.controller");

router.get("/", getContact);

module.exports = router;