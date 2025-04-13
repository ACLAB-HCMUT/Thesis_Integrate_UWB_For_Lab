const { Pool } = require('pg');

// Cấu hình kết nối PostgreSQL
const pool = new Pool({
  user: 'postgres',               // Tên người dùng PostgreSQL
  host: 'localhost',              // Hoặc IP nếu deploy server
  database: 'uwb',      // Tên database đã tạo
  password: 'anhkhoi2003',      // Mật khẩu PostgreSQL
  port: 5432,                     // Port mặc định
});

pool.connect()
  .then(() => console.log("✅ Đã kết nối đến PostgreSQL"))
  .catch(err => console.error("❌ Lỗi kết nối:", err));

module.exports = pool;