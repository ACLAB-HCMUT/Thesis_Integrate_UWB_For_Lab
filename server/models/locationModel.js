const pool = require('../config/db');

async function getLocations(deviceId, type) {
    const sql = `
      SELECT devicerec_id, tag_x, tag_y, tag_z, record_time, record_type
      FROM device_location
      WHERE device_id = $1 AND record_type = $2
      ORDER BY devicerec_id`;
    const { rows } = await pool.query(sql, [deviceId, type]);
    return rows;
  }

async function getAnchors(roomId) {
    const result = await pool.query(
      `SELECT anchorrec_id, anchor_id, anchor_x, anchor_y, anchor_z, record_time
       FROM anchor_location
       WHERE room_id = $1`,
      [roomId]
    );
    return result.rows;
  }

async function getRoomId(deviceId) {
    const result = await pool.query(
      `SELECT room_id FROM device WHERE device_id = $1`,
      [deviceId]
    );
    return result.rows[0] ? result.rows[0].room_id : null;
}
  
  
module.exports = { 
    getLocations, 
    getAnchors, 
    getRoomId
};