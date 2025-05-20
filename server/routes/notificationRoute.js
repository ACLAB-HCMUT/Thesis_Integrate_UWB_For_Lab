const express = require('express');
const router = express.Router();
const notificationController = require('../controllers/notificationController');
const { verifyToken } = require('../middlewares/authMiddleware');

// GET /notifications/:id - Lấy tất cả thông báo cho 1 user
router.get('/:id', notificationController.getAllNotifications);
router.post('/', notificationController.sendNotification);
router.patch('/read/:id', notificationController.markNotificationAsRead);
router.delete('/:id', notificationController.deleteNotification);

module.exports = router;
