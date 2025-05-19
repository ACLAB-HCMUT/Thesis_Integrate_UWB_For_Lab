const express = require("express");
const router = express.Router();
const requestController = require('../controllers/requestController');
const authMiddleware = require("../middlewares/authMiddleware");

// API: request

router.get('/', requestController.getAllBorrowRequests);
router.get('/:id', requestController.getBorrowRequestsByUser);
router.post('/create', requestController.createBorrowRequest);
router.patch('/borrow-date/:id', authMiddleware.verifyToken, requestController.updateBorrowDate);
router.patch('/return-date/:id', authMiddleware.verifyToken, requestController.updateReturnDate);
router.patch('/status/:id', authMiddleware.verifyToken, requestController.updateBorrowRequestStatus);

module.exports = router;