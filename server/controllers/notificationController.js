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

async function markNotificationAsRead(req, res) {
  try {
    const notifyId = req.params.id;

    const updatedNotification = await notificationService.markNotificationAsRead(notifyId);

    if (!updatedNotification) {
      return res.status(404).json({
        success: false,
        message: 'Không tìm thấy thông báo để cập nhật',
      });
    }

    res.json({
      success: true,
      message: 'Đã đánh dấu thông báo là đã đọc',
      data: updatedNotification,
    });
  } catch (error) {
    console.error('Error marking notification as read:', error);
    res.status(500).json({
      success: false,
      message: 'Lỗi server khi đánh dấu thông báo là đã đọc',
    });
  }
}

async function deleteNotification(req, res) {
  try {
    const notifyId = req.params.id;
    const success = await notificationService.deleteNotification(notifyId);

    if (success) {
      res.json({ success: true, message: 'Xóa thông báo thành công' });
    } else {
      res.status(404).json({ success: false, message: 'Không tìm thấy thông báo' });
    }
  } catch (error) {
    console.error('Lỗi khi xóa thông báo:', error);
    res.status(500).json({
      success: false,
      message: 'Lỗi server khi xóa thông báo',
    });
  }
}

module.exports = {
  getAllNotifications,
  sendNotification,
  markNotificationAsRead,
  deleteNotification,
};
