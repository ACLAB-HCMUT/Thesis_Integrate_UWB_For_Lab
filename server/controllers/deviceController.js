const pool = require('../config/db');

// controllers/deviceController.js
const deviceService = require('../services/deviceService');

exports.getAllDevices = async (req, res) => {
  try {
    const devices = await deviceService.fetchAllDevices();
    res.json(devices);
  } catch (error) {
    console.error("❌ Lỗi lấy thiết bị:", error.message);
    res.status(500).json({ message: 'Lỗi server' });
  }
};

exports.getDeviceById = async (req, res) => {
  const deviceId = req.params.id;

  try {
    const device = await deviceService.fetchDeviceById(deviceId);
    res.json(device);
  } catch (error) {
    console.error('❌ Lỗi khi lấy chi tiết thiết bị:', error.message);
    res.status(500).json({ message: 'Lỗi server' });
  }
};

// exports.createBorrowRequest = async (req, res) => {
//   const {
//     device_id,
//     detail,
//     status,
//     appointment_date,
//     expected_return,
//     client_id,
//   } = req.body;

//   try {
//     const result = await pool.query(
//       `INSERT INTO borrow_request (
//         device_id, detail, status, appointment_date, expected_return, client_id
//       ) VALUES ($1, $2, $3, $4, $5, $6)
//       RETURNING *`,
//       [device_id, detail, status, appointment_date, expected_return, client_id]
//     );

//     res.status(201).json(result.rows[0]);
//   } catch (error) {
//     console.error('❌ Lỗi khi tạo borrow request:', error.message);
//     res.status(500).json({ message: 'Lỗi server khi tạo borrow request' });
//   }
// };

// // ✅ Cập nhật borrow_date
// exports.updateBorrowDate = async (req, res) => {
//   const id = req.params.id;
//   const borrowDate = req.body.borrow_date || new Date();

//   try {
//     const result = await pool.query(
//       `UPDATE borrow_request 
//        SET borrow_date = $1 
//        WHERE request_id = $2 
//        RETURNING *`,
//       [borrowDate, id]
//     );

//     if (result.rows.length === 0) {
//       return res.status(404).json({ message: "Borrow request không tồn tại" });
//     }

//     res.json({ message: "Đã cập nhật borrow_date", data: result.rows[0] });
//   } catch (err) {
//     console.error("❌ Lỗi khi cập nhật borrow_date:", err.message);
//     res.status(500).json({ message: "Lỗi server" });
//   }
// };

// // ✅ Cập nhật return_date
// exports.updateReturnDate = async (req, res) => {
//   const id = req.params.id;
//   const returnDate = req.body.return_date || new Date();

//   try {
//     const result = await pool.query(
//       `UPDATE borrow_request 
//        SET return_date = $1 
//        WHERE request_id = $2 
//        RETURNING *`,
//       [returnDate, id]
//     );

//     if (result.rows.length === 0) {
//       return res.status(404).json({ message: "Borrow request không tồn tại" });
//     }

//     res.json({ message: "Đã cập nhật return_date", data: result.rows[0] });
//   } catch (err) {
//     console.error("❌ Lỗi khi cập nhật return_date:", err.message);
//     res.status(500).json({ message: "Lỗi server" });
//   }
// };