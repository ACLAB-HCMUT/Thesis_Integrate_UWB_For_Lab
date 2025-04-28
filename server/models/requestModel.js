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

module.exports = {
  createRequest,
  changeBorrowDate,
  changeReturnDate,
};
