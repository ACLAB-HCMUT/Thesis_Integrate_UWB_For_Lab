const pool = require('../config/db');

async function createRequest({ device_id, detail, status, appointment_date, expected_return, client_id }) {
  const result = await pool.query(
    `INSERT INTO borrow_request (
      device_id, detail, status, appointment_date, expected_return, client_id
    ) VALUES ($1, $2, $3, $4, $5, $6)
    RETURNING *`,
    [device_id, detail, status, appointment_date, expected_return, client_id]
  );
  return result.rows[0];
}

async function changeBorrowDate(requestId, borrowDate) {
  const result = await pool.query(
    `UPDATE borrow_request 
     SET borrow_date = $1 
     WHERE request_id = $2 
     RETURNING *`,
    [borrowDate, requestId]
  );
  return result.rows[0];
}

async function changeReturnDate(requestId, returnDate) {
  const result = await pool.query(
    `UPDATE borrow_request 
     SET return_date = $1 
     WHERE request_id = $2 
     RETURNING *`,
    [returnDate, requestId]
  );
  return result.rows[0];
}

// async function getAllRequests() {
//   const result = await pool.query(`
//     SELECT 
//       br.*,
//       u.full_name,
//       u.email,
//       u.phone_number,
//       u.role,
//       u.status AS user_status,
//       d.device_name,
//       d.is_available,
//       d.is_active
//     FROM borrow_request br
//     JOIN "user" u ON br.client_id = u.user_id
//     JOIN device d ON br.device_id = d.device_id
//     ORDER BY br.request_id DESC
//   `);
//   return result.rows;
// }

async function getAllRequests() {
  const result = await pool.query(`
    SELECT 
      br.*,
      u.full_name,
      u.email,
      u.phone_number,
      u.role,
      u.status AS user_status,
      d.device_name,
      d.is_available,
      d.is_active,
      rr.request_id AS received_request_id,
      rr.expected_return AS received_expected_return,
      rr.borrow_date AS received_borrow_date
    FROM borrow_request br
    JOIN "user" u ON br.client_id = u.user_id
    JOIN device d ON br.device_id = d.device_id
    LEFT JOIN LATERAL (
      SELECT request_id, expected_return, borrow_date
      FROM borrow_request 
      WHERE device_id = d.device_id AND status = 'received'
      ORDER BY borrow_date DESC
      LIMIT 1
    ) rr ON TRUE
    ORDER BY br.request_id DESC
  `);
  return result.rows;
}

async function getRequestsById(userId) {
  const result = await pool.query(`
    SELECT 
      br.*,
      u.full_name,
      u.email,
      u.phone_number,
      u.role,
      u.status AS user_status
    FROM borrow_request br
    JOIN "user" u ON br.client_id = u.user_id
    WHERE br.client_id = $1
    ORDER BY br.request_id DESC
  `, [userId]);
  return result.rows;
}

async function getRequestById(requestId) {
  const result = await pool.query(`
    SELECT 
      br.*,
      (
        SELECT br2.request_id 
        FROM borrow_request br2 
        WHERE br2.device_id = br.device_id 
          AND br2.status = 'received'
        ORDER BY br2.request_id DESC 
        LIMIT 1
      ) AS received_id
    FROM borrow_request br
    WHERE br.request_id = $1
  `, [requestId]);

  return result.rows[0];
}

async function changeStatus(requestId, status) {
  const result = await pool.query(
    `UPDATE borrow_request 
     SET status = $1 
     WHERE request_id = $2 
     RETURNING *`,
    [status, requestId]
  );
  return result.rows[0];
}

module.exports = {
  createRequest,
  changeBorrowDate,
  changeReturnDate,
  getAllRequests,
  changeStatus,
  getRequestsById,
  getRequestById,
};
