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

async function updateById(id, updateFields) {
  // Xây dựng câu SQL động theo các trường có trong updateFields
  const keys = Object.keys(updateFields);
  if (keys.length === 0) {
    throw new Error('No fields provided for update');
  }

  const setClause = keys.map((key, index) => `${key} = $${index + 1}`).join(', ');
  const values = Object.values(updateFields);

  const result = await pool.query(
    `
    UPDATE device
    SET ${setClause}
    WHERE device_id = $${keys.length + 1}
    RETURNING *
    `,
    [...values, id]
  );

  return result.rows[0];
}

module.exports = {
  getAll,
  getById,
  updateById,
};
