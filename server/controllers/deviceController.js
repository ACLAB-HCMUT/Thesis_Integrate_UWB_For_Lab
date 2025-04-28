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

exports.getHourlyLocations = async (req, res) => {
  const deviceId = req.params.id;

  try {
    const result = await pool.query(`
      SELECT 
        devicerec_id,
        tag_x,
        tag_y,
        tag_z,
        record_time,
        record_type
      FROM device_location
      WHERE device_id = $1
        AND record_type = 'hourly'
      ORDER BY devicerec_id
    `, [deviceId]
    );

    res.json(result.rows);
  } catch (error) {
    console.error('❌ Lỗi khi lấy vị trí thiết bị:', error.message);
    res.status(500).json({ message: 'Lỗi server' });
  }
};

exports.getDailyLocations = async (req, res) => {
  const deviceId = req.params.id;

  try {
    const result = await pool.query(`
      SELECT 
        devicerec_id,
        tag_x,
        tag_y,
        tag_z,
        record_time,
        record_type
      FROM device_location
      WHERE device_id = $1
        AND record_type = 'daily'
      ORDER BY devicerec_id
    `, [deviceId]
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

exports.getAnchorLocations = async (req, res) => {
  const deviceId = req.params.id;

  try {
    // Tìm room_id gần nhất của device
    const deviceResult = await pool.query(
      'SELECT room_id FROM device WHERE device_id = $1',
      [deviceId]
    );

    if (deviceResult.rowCount === 0) {
      return res.status(404).json({ error: 'Device not found' });
    }

    const roomId = deviceResult.rows[0].room_id;

    // Lấy danh sách anchor theo room_id
    const anchorResult = await pool.query(
      'SELECT * FROM anchor_location WHERE room_id = $1',
      [roomId]
    );
    res.json(anchorResult.rows);
  } catch (error) {
    console.error('Error fetching anchors:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};