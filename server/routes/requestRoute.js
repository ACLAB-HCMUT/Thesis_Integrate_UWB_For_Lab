const express = require("express");
const router = express.Router();
const requestController = require('../controllers/requestController');

// API: request

router.post('/create', requestController.createBorrowRequest);
router.patch('/borrow-date/:id', requestController.updateBorrowDate);
router.patch('/return-date/:id', requestController.updateReturnDate);

module.exports = router;