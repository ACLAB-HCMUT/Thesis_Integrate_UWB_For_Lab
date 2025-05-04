// models/authModel.js
const pool = require('../config/db');

async function createUser (userData) {
    const result = await pool.query(
      `INSERT INTO "user" (email, password, full_name, phone_number, role, status)
       VALUES ($1, $2, $3, $4, $5, 'active') RETURNING *`,
      [userData.email, userData.password, userData.full_name, userData.phone_number, userData.role]
    );
    return result.rows[0];
  };

async function findUserByEmail (email) {
    const result = await pool.query(`SELECT * FROM "user" WHERE email = $1`, [email]);
    return result.rows[0];
};

async function findUserById(id) {
    const result = await pool.query(
      `SELECT user_id, email, full_name, phone_number, role, status
       FROM "user"
       WHERE user_id = $1`,
      [id]
    );
    return result.rows[0] || null;
}

async function updateUserById(id, updates) {
    const keys = Object.keys(updates);
    const values = Object.values(updates);
  
    if (keys.length === 0) {
      throw new Error('Không có dữ liệu để cập nhật');
    }
  
    const setClause = keys.map((key, index) => `${key} = $${index + 1}`).join(', ');
    const query = `UPDATE "user" SET ${setClause} WHERE user_id = $${keys.length + 1} RETURNING *`;
  
    const result = await pool.query(query, [...values, id]);
    return result.rows[0];
}

async function updateUserById(id, updates) {
    // const keys = Object.keys(updates);
    // const values = Object.values(updates);
  
    // if (keys.length === 0) {
    //   throw new Error('Không có dữ liệu để cập nhật');
    // }
  
    // const setClause = keys.map((key, index) => `${key} = $${index + 1}`).join(', ');
    // const query = `UPDATE "user" SET ${setClause} WHERE user_id = $${keys.length + 1} RETURNING *`;
  
    // const result = await pool.query(query, [...values, id]);
    // return result.rows[0];
    const allowedFields = ['password', 'full_name', 'phone_number', 'role', 'status'];
    const fields = [];
    const values = [];
    let index = 1;

    for (const key of allowedFields) {
        if (updates[key] !== undefined) {
        fields.push(`${key} = $${index}`);
        values.push(updates[key]);
        index++;
        }
    }

    if (fields.length === 0) {
        throw new Error('Không có trường hợp lệ để cập nhật');
    }

    values.push(id);

    const result = await pool.query(
        `UPDATE "user" SET ${fields.join(', ')} WHERE user_id = $${index} RETURNING *`,
        values
    );

    return result.rows.length > 0 ? result.rows[0] : null;
}

async function getAllUsers() {
    const result = await pool.query(
        `SELECT user_id, email, full_name, phone_number, role, status FROM "user" ORDER BY user_id ASC`
    );
    return result.rows;
}

module.exports = {
    createUser,
    findUserByEmail,
    findUserById,
    updateUserById,
    getAllUsers,
};