const express = require("express");
const router = express.Router();
const requestController = require('../controllers/requestController');

// API: request

router.get('/', requestController.getAllBorrowRequests);
router.post('/create', requestController.createBorrowRequest);
router.patch('/borrow-date/:id', requestController.updateBorrowDate);
router.patch('/return-date/:id', requestController.updateReturnDate);
router.patch('/status/:id', requestController.updateBorrowRequestStatus);

module.exports = router;