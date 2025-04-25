// const axios = require("axios")

// // 1. Hàm lấy dữ liệu từ Adafruit IO
// async function fetchDataFromAdafruit(ADAFRUIT_API_URL, ADAFRUIT_API_KEY) {
//     try {
//       const response = await axios.get(ADAFRUIT_API_URL, {
//         headers: {
//           "X-AIO-Key": ADAFRUIT_API_KEY,
//         },
//       });
//       const latestData = response.data[0]; // Lấy dữ liệu mới nhất
//       console.log("Fetched data:", latestData);
//       return latestData;
//     } catch (error) {
//       console.error("Error fetching data from Adafruit IO:", error.message);
//       return null;
//     }
// }
  
// // 2. Hàm lưu dữ liệu vào Firebase
// async function saveDataToFirebase(db, value, createdAt, type) {
//     try {
//         // Parse dữ liệu đầu vào
//         const { id, location } = JSON.parse(value);
//         const [tag_x, tag_y, tag_z] = location.split(',').map(coord => parseFloat(coord.trim()));
//         // Tạo các reference
//         const anchorRef = (anchorId) => db.collection("ANCHOR_LOCATION").doc(String(anchorId));
//         const deviceRef = db.collection("DEVICE").doc(String(id));

//         await db.collection("DEVICE_LOCATION").add({
//             anchor_1: anchorRef("1"),
//             anchor_2: anchorRef("2"),
//             anchor_3: anchorRef("3"),
//             anchor_4: anchorRef("4"),
//             device_id: deviceRef,
//             record_time: new Date(createdAt),
//             record_type: type,
//             tag_x,
//             tag_y,
//             tag_z,
//         });
//       console.log(`${type} data saved to DEVICE_LOCATION:`, { value, createdAt });
//     } catch (error) {
//       console.error(`Error saving ${type} data to DEVICE_LOCATION:`, error.message);
//     }
// }

// module.exports = {
//     fetchDataFromAdafruit,
//     saveDataToFirebase,
// };

const pool = require('../config/db');

// Lấy toàn bộ thiết bị, kèm loại thiết bị
exports.getAllDevices = async (req, res) => {
  try {
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
    res.json(result.rows);
  } catch (error) {
    console.error("❌ Lỗi lấy thiết bị:", error.message);
    res.status(500).json({ message: 'Lỗi server' });
  }
};

exports.getDeviceById = async (req, res) => {
  const deviceId = req.params.id;

  try {
    const result = await pool.query(
      `SELECT
        d.description,
        d.serial,
        d.manufacturer,
        d.specification,
        d.is_active,
        d.is_available
       FROM device d
       WHERE d.device_id = $1`,
      [deviceId]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ message: 'Thiết bị không tồn tại' });
    }

    res.json(result.rows[0]);
  } catch (error) {
    console.error('❌ Lỗi khi lấy chi tiết thiết bị:', error.message);
    res.status(500).json({ message: 'Lỗi server' });
  }
};

exports.getDeviceLocations = async (req, res) => {
  const deviceId = req.params.id;

  try {
    const result = await pool.query(
      `SELECT dl.*, 
              a1.anchor_x AS a1_x, a1.anchor_y AS a1_y, a1.anchor_z AS a1_z,
              a2.anchor_x AS a2_x, a2.anchor_y AS a2_y, a2.anchor_z AS a2_z,
              a3.anchor_x AS a3_x, a3.anchor_y AS a3_y, a3.anchor_z AS a3_z,
              a4.anchor_x AS a4_x, a4.anchor_y AS a4_y, a4.anchor_z AS a4_z
       FROM device_location dl
       LEFT JOIN anchor_location a1 ON dl.an1rec_id = a1.anchorrec_id
       LEFT JOIN anchor_location a2 ON dl.an2rec_id = a2.anchorrec_id
       LEFT JOIN anchor_location a3 ON dl.an3rec_id = a3.anchorrec_id
       LEFT JOIN anchor_location a4 ON dl.an4rec_id = a4.anchorrec_id
       WHERE dl.device_id = $1
       ORDER BY dl.record_time DESC`,  // sắp xếp theo thời gian gần nhất
      [deviceId]
    );

    res.json(result.rows);
  } catch (error) {
    console.error('❌ Lỗi khi lấy vị trí thiết bị:', error.message);
    res.status(500).json({ message: 'Lỗi server' });
  }
};

exports.createBorrowRequest = async (req, res) => {
  const {
    device_id,
    detail,
    status,
    appointment_date,
    expected_return,
    client_id,
  } = req.body;

  try {
    const result = await pool.query(
      `INSERT INTO borrow_request (
        device_id, detail, status, appointment_date, expected_return, client_id
      ) VALUES ($1, $2, $3, $4, $5, $6)
      RETURNING *`,
      [device_id, detail, status, appointment_date, expected_return, client_id]
    );

    res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error('❌ Lỗi khi tạo borrow request:', error.message);
    res.status(500).json({ message: 'Lỗi server khi tạo borrow request' });
  }
};

// ✅ Cập nhật borrow_date
exports.updateBorrowDate = async (req, res) => {
  const id = req.params.id;
  const borrowDate = req.body.borrow_date || new Date();

  try {
    const result = await pool.query(
      `UPDATE borrow_request 
       SET borrow_date = $1 
       WHERE request_id = $2 
       RETURNING *`,
      [borrowDate, id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ message: "Borrow request không tồn tại" });
    }

    res.json({ message: "Đã cập nhật borrow_date", data: result.rows[0] });
  } catch (err) {
    console.error("❌ Lỗi khi cập nhật borrow_date:", err.message);
    res.status(500).json({ message: "Lỗi server" });
  }
};

// ✅ Cập nhật return_date
exports.updateReturnDate = async (req, res) => {
  const id = req.params.id;
  const returnDate = req.body.return_date || new Date();

  try {
    const result = await pool.query(
      `UPDATE borrow_request 
       SET return_date = $1 
       WHERE request_id = $2 
       RETURNING *`,
      [returnDate, id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ message: "Borrow request không tồn tại" });
    }

    res.json({ message: "Đã cập nhật return_date", data: result.rows[0] });
  } catch (err) {
    console.error("❌ Lỗi khi cập nhật return_date:", err.message);
    res.status(500).json({ message: "Lỗi server" });
  }
};