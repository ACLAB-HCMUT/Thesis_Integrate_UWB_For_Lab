const pool = require('../config/db');

// Lấy tất cả thông báo theo userId
async function getNotificationsByUserId(userId) {
  const result = await pool.query(
    `SELECT * FROM notification 
     WHERE user_id = $1 
     ORDER BY notify_time DESC`,
    [userId]
  );
  return result.rows;
}

async function createNotification({ user_id, description, type, notify_time }) {
  const result = await pool.query(
    `INSERT INTO notification (user_id, description, type, notify_time, is_read)
     VALUES ($1, $2, $3, $4, false)
     RETURNING *`,
    [user_id, description, type, notify_time]
  );
  return result.rows[0];
}

async function markAsRead(notifyId) {
  const result = await pool.query(
    `UPDATE notification SET is_read = true WHERE notify_id = $1 RETURNING *`,
    [notifyId]
  );
  return result.rows[0];
}

async function deleteById(notifyId) {
  const result = await pool.query(
    `DELETE FROM notification WHERE notify_id = $1`,
    [notifyId]
  );
  return result.rowCount > 0;
}

module.exports = {
  getNotificationsByUserId,
  createNotification,
  markAsRead,
  deleteById,
};
