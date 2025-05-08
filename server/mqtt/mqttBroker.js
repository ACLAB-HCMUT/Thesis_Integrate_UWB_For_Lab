const Aedes = require("aedes");
const net = require("net");
const pool = require("../config/db");
const dotenv = require("dotenv");
const tagManager = require("./tagManager");

dotenv.config();

const PORT = process.env.MQTT_PORT || 1883;
const aedes = Aedes();
const server = net.createServer(aedes.handle);

let latestMessage = null; // Biến lưu tin nhắn cuối
let latestMessages = {}; // Biến lưu tin nhắn cuối

server.listen(PORT, () => {
    console.log(`🚀 Aedes MQTT Broker đang chạy trên cổng ${PORT}`);
});

aedes.on("client", (client) => {
    console.log(`📡 Thiết bị kết nối: ${client.id}`);
});

// aedes.on("publish", (packet, client) => {
//     if (client) {
//         const topic = packet.topic;
//         const message = packet.payload.toString();
//         const time = new Date();
//         console.log(`📨 Tin nhắn từ ${client.id}:`, topic, message);

//         // Ghi lại tin nhắn mới nhất
//         try {
//           const data = JSON.parse(message);
//           const deviceId = data.device_id;
//           latestMessages[deviceId] = {
//               topic,
//               message,
//               time,
//           };
//         } catch (err) {
//             console.error("❌ Lỗi parse JSON:", err.message);
//         }
//     }
// });
aedes.on("publish", (packet, client) => {
  if (client) {
      const topic = packet.topic;
      const message = packet.payload.toString();
      console.log(`Tin nhắn từ ${client.id}:`, topic, message);

      // Ghi lại tin nhắn mới nhất
      latestMessage = {
          topic,
          message,
      };

      if (topic === "uwb/register") {
          let data;

          try {
              data = JSON.parse(message);
          } catch (err) {
              console.error("❌ Không parse được JSON từ message:", message);
              return;
          }

          const tagId = data.tag_id;

          if (tagId) {
              tagManager.handleRegister(tagId, aedes);
          } else {
              console.error("❌ JSON hợp lệ nhưng không có trường 'id':", data);
          }
      }

      // Ngoài ra, nếu tag gửi định kỳ để duy trì "seen"

      if (topic === "uwb/tagposition") {
          const data = JSON.parse(message);
          const tagId = data.tag_id;
          if (tagId) {
              // Cập nhật thời gian cuối cùng thấy tag
              tagManager.lastSeen[tagId] = Date.now();
              console.log(`🕒 Cập nhật thời gian cuối cùng thấy tag ${tagId}:`, new Date(tagManager.lastSeen[tagId]));
          } else {
              console.error("❌ Không tìm thấy ID tag trong tin nhắn:", message);
          }
      }

      if (topic.startsWith("uwb/timeout")) {
          const data = JSON.parse(message);
          const tagId = data.tag_id;
          tagManager.handleTimeoutMessage(tagId, aedes);
      }
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
    for (const deviceId in latestMessages) {
      const latestMessage = latestMessages[deviceId];
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
                record_time, record_type
            ) VALUES ($1, $2, $3, $4, $5, 'hourly')`,
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
    for (const deviceId in latestMessages) {
      const latestMessage = latestMessages[deviceId];
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
                record_time, record_type
            ) VALUES ($1, $2, $3, $4, $5, 'daily')`,
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
  }, 24 * 1000); // mỗi ngày

module.exports = aedes;