const notificationModel = require('../models/notificationModel');

// Gọi hàm từ model để lấy tất cả thông báo theo userId
async function getAllNotifications(userId) {
  return await notificationModel.getNotificationsByUserId(userId);
}

async function sendNotification(notificationData) {
  return await notificationModel.createNotification(notificationData);
}

async function markNotificationAsRead(notifyId) {
  return await notificationModel.markAsRead(notifyId);
}

async function deleteNotification(notifyId) {
  return await notificationModel.deleteById(notifyId);
}

module.exports = {
  getAllNotifications,
  sendNotification,
  markNotificationAsRead,
  deleteNotification,
};
