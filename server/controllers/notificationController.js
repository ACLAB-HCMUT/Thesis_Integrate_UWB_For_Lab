const notificationService = require('../services/notificationService');

// Controller: GET /notifications/:id
async function getAllNotifications(req, res) {
  try {
    const userId = req.params.id;

    const notifications = await notificationService.getAllNotifications(userId);

    res.json({
      success: true,
      data: notifications,
    });
  } catch (error) {
    console.error('Error getting notifications:', error);
    res.status(500).json({
      success: false,
      message: 'Lỗi server khi lấy thông báo',
    });
  }
}

async function sendNotification(req, res) {
  try {
    const { user_id, description, type, notify_time } = req.body;
    if (!user_id || !description || !type || !notify_time) {
      return res.status(400).json({ message: 'Thiếu thông tin bắt buộc' });
    }

    const newNotification = await notificationService.sendNotification({
      user_id,
      description,
      type,
      notify_time,
    });

    res.status(201).json({
      success: true,
      data: newNotification,
      message: 'Gửi thông báo thành công',
    });
  } catch (error) {
    console.error('Error sending notification:', error);
    res.status(500).json({
      success: false,
      message: 'Lỗi server khi gửi thông báo',
    });
  }
}

module.exports = {
  getAllNotifications,
  sendNotification,
};
