const express = require("express");
const router = express.Router();
const deviceController = require('../controllers/deviceController');
const authMiddleware = require("../middlewares/authMiddleware");

// API: devices

router.get('/', authMiddleware.verifyToken, deviceController.getAllDevices);
router.get('/:id', authMiddleware.verifyToken, deviceController.getDeviceById);

module.exports = router;
