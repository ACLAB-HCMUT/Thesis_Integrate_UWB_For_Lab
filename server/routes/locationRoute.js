const express = require("express");
const router = express.Router();
const locationController = require('../controllers/locationController');

//API: locations

router.get('/hourly/:id', locationController.getHourlyLocations)
router.get('/daily/:id', locationController.getDailyLocations)
router.get('/anchor/:id', locationController.getAnchorsLocations)

module.exports = router;