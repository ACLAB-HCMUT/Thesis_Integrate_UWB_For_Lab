const Aedes = require("aedes");
const net = require("net");
const pool = require("../config/db");
const dotenv = require("dotenv");

dotenv.config();

const PORT = process.env.MQTT_PORT || 1883;
const aedes = Aedes();
const server = net.createServer(aedes.handle);

let latestMessage = null; // Biến lưu tin nhắn cuối

server.listen(PORT, () => {
    console.log(`🚀 Aedes MQTT Broker đang chạy trên cổng ${PORT}`);
});

aedes.on("client", (client) => {
    console.log(`📡 Thiết bị kết nối: ${client.id}`);
});

aedes.on("publish", (packet, client) => {
    if (client) {
        const topic = packet.topic;
        const message = packet.payload.toString();
        const time = new Date();
        console.log(`📨 Tin nhắn từ ${client.id}:`, topic, message);

        // Ghi lại tin nhắn mới nhất
        latestMessage = {
            topic,
            message,
            time,
        };
    }
});

// // Lưu tin nhắn cuối mỗi 10 giây
// setInterval(async () => {
//     if (latestMessage) {
//         try {
//             await pool.query(
//                 "INSERT INTO mqtt_messages(topic, message) VALUES ($1, $2)",
//                 [latestMessage.topic, latestMessage.message]
//             );
//             console.log("🕒 Đã lưu tin nhắn mới nhất vào PostgreSQL");
//             latestMessage = null; // Đặt lại sau khi lưu
//         } catch (err) {
//             console.error("❌ Lỗi khi lưu DB:", err.message);
//         }
//     }
// }, 10000); // 10000 ms = 10 giây

// ⏱ Lưu dữ liệu HOURLY mỗi giờ
setInterval(async () => {
    if (latestMessage) {
      const data = JSON.parse(latestMessage.message);
      const time = latestMessage.time;
  
      try {
        const result = await pool.query(
          `SELECT * FROM device_location 
           WHERE device_id = $1 AND record_type = 'hourly' AND record_time = $2`,
          [data.device_id, time]
        );
  
        if (result.rows.length === 0) {
          await pool.query(
            `INSERT INTO device_location (
                device_id, tag_x, tag_y, tag_z,
                an1rec_id, an2rec_id, an3rec_id, an4rec_id,
                record_time, record_type
            ) VALUES ($1, $2, $3, $4, 1, 2, 3, 4, $5, 'hourly')`,
            [data.device_id, data.x, data.y, data.z, time]
          );
          console.log("🕐 Đã lưu bản ghi HOURLY cho device:", data.device_id);
        } else {
          console.log("⚠️ Đã tồn tại bản ghi HOURLY cho device:", data.device_id);
        }
      } catch (err) {
        console.error("❌ Lỗi khi lưu HOURLY:", err.message);
      }
    }
  }, 60 * 60 * 1000); // mỗi giờ
  
  // ⏱ Lưu dữ liệu DAILY mỗi ngày
  setInterval(async () => {
    if (latestMessage) {
      const data = JSON.parse(latestMessage.message);
      const time = latestMessage.time;

      try {
        const result = await pool.query(
          `SELECT * FROM device_location 
           WHERE device_id = $1 AND record_type = 'daily' AND record_time = $2`,
          [data.device_id, time]
        );
  
        if (result.rows.length === 0) {
          await pool.query(
            `INSERT INTO device_location (
                device_id, tag_x, tag_y, tag_z,
                an1rec_id, an2rec_id, an3rec_id, an4rec_id,
                record_time, record_type
            ) VALUES ($1, $2, $3, $4, 1, 2, 3, 4, $5, 'daily')`,
            [data.device_id, data.x, data.y, data.z, time]
          );
          console.log("📅 Đã lưu bản ghi DAILY cho device:", data.device_id);
        } else {
          console.log("⚠️ Đã tồn tại bản ghi DAILY cho device:", data.device_id);
        }
      } catch (err) {
        console.error("❌ Lỗi khi lưu DAILY:", err.message);
      }
    }
  }, 24 * 60 * 60 * 1000); // mỗi ngày

module.exports = aedes;