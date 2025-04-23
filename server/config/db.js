const { Pool } = require('pg');
const dotenv = require("dotenv");

dotenv.config();
// Cấu hình kết nối PostgreSQL
const pool = new Pool({
  host: process.env.PG_HOST,
  port: process.env.PG_PORT,
  database: process.env.PG_DATABASE,
  user: process.env.PG_USER,
  password: process.env.PG_PASSWORD,
});

pool.connect()
  .then(() => console.log("✅ Đã kết nối đến PostgreSQL"))
  .catch(err => console.error("❌ Lỗi kết nối:", err));

module.exports = pool;