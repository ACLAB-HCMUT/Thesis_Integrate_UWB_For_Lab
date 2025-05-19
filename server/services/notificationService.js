const notificationModel = require('../models/notificationModel');

// Gọi hàm từ model để lấy tất cả thông báo theo userId
async function getAllNotifications(userId) {
  return await notificationModel.getNotificationsByUserId(userId);
}

async function sendNotification(notificationData) {
  return await notificationModel.createNotification(notificationData);
}

module.exports = {
  getAllNotifications,
  sendNotification,
};
