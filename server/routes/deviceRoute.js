const express = require("express");
const router = express.Router();
const deviceController = require('../controllers/deviceController');

// API: devices

router.get('/', deviceController.getAllDevices);
router.get('/:id', deviceController.getDeviceById);

// router.post('/create-request', deviceController.createBorrowRequest);
// router.patch('/borrow-date/:id', deviceController.updateBorrowDate);
// router.patch('/return-date/:id', deviceController.updateReturnDate);

module.exports = router;
