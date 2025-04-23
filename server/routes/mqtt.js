// const express = require("express");
// const schedule = require("node-schedule");
// const db = require("../config/firebase");
// const { fetchDataFromAdafruit, saveDataToFirebase } = require("../controllers/mqttController");

// const router = express.Router();

// // Cấu hình Adafruit IO
// const ADAFRUIT_API_KEY = process.env.ADAFRUIT_API_KEY;
// const ADAFRUIT_API_URL = process.env.ADAFRUIT_API_URL;

// // Lên lịch để tự động lấy và lưu dữ liệu hourly_location mỗi 1 giờ
// // Đổi thành */5 * * * * * để test tác vụ chạy mỗi 5 giây
// schedule.scheduleJob("0 * * * *", async () => {
//     console.log("Scheduled hourly task running...");
//     const data = await fetchDataFromAdafruit(ADAFRUIT_API_URL, ADAFRUIT_API_KEY);
//     if (data) {
//       const { value, created_at } = data;
//       console.log(value)
//       await saveDataToFirebase(db, value, created_at, "hourly");
//     }
// });

// // Lên lịch để tự động lấy và lưu dữ liệu daily_location mỗi 7:00 mỗi ngày
// schedule.scheduleJob("0 7 * * *", async () => {
//     console.log("Scheduled daily task running...");
//     const data = await fetchDataFromAdafruit(ADAFRUIT_API_URL, ADAFRUIT_API_KEY);
//     if (data) {
//       const { value, created_at } = data;
//       await saveDataToFirebase(db, value, created_at, "daily");
//     }
//   });

// module.exports = router;

const Aedes = require("aedes");
const net = require("net");
const pool = require("../config/db");

const PORT = 1883;
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
           WHERE device_id = $1 AND record_type = 'HOURLY' AND record_time = $2`,
          [data.device_id, time]
        );
  
        if (result.rows.length === 0) {
          await pool.query(
            `INSERT INTO device_location (
                device_id, tag_x, tag_y, tag_z,
                an1rec_id, an2rec_id, an3rec_id, an4rec_id,
                record_time, record_type
            ) VALUES ($1, $2, $3, $4, 1, 2, 3, 4, $5, 'HOURLY')`,
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
  }, 6 * 1000); // mỗi giờ
  
  // ⏱ Lưu dữ liệu DAILY mỗi ngày
  setInterval(async () => {
    if (latestMessage) {
      const data = JSON.parse(latestMessage.message);
      const time = latestMessage.time;

      try {
        const result = await pool.query(
          `SELECT * FROM device_location 
           WHERE device_id = $1 AND record_type = 'DAILY' AND record_time = $2`,
          [data.device_id, time]
        );
  
        if (result.rows.length === 0) {
          await pool.query(
            `INSERT INTO device_location (
                device_id, tag_x, tag_y, tag_z,
                an1rec_id, an2rec_id, an3rec_id, an4rec_id,
                record_time, record_type
            ) VALUES ($1, $2, $3, $4, 1, 2, 3, 4, $5, 'DAILY')`,
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
  }, 10 * 1000); // mỗi ngày

module.exports = aedes;