// models/deviceModel.js
const pool = require('../config/db');

async function getAll() {
  const result = await pool.query(`
    SELECT 
      d.device_id,
      d.device_name,
      d.image,
      d.is_active,
      d.is_available,
      dt.type_name
    FROM device d
    LEFT JOIN device_type dt ON d.type_id = dt.type_id
    ORDER BY d.device_id
  `);
  return result.rows;
}

async function getById(deviceId) {
  const result = await pool.query(`
    SELECT
      d.description,
      d.serial,
      d.manufacturer,
      d.specification,
      d.is_active,
      d.is_available
    FROM device d
    WHERE d.device_id = $1`, [deviceId]
  );
  return result.rows[0];
}

module.exports = {
  getAll,
  getById,
};
