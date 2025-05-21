const Aedes = require("aedes");
const net = require("net");
const pool = require("../config/db");
const dotenv = require("dotenv");
const tagManager = require("./tagManager");
const service = require("../services/locationService");
const { sendNotification } = require("../services/notificationService");
const { getAllAdmins } = require("../services/authService");

dotenv.config();

const PORT = process.env.MQTT_PORT || 1883;
const aedes = Aedes();
const server = net.createServer(aedes.handle);

const hourlyInterval = 6 * 1000;
const dailyInterval = 24 * 1000;
const alertInterval = 5 * 1000;
const NO_DATA_TIMEOUT = 30 * 1000;
// let latestMessage = null; // Biến lưu tin nhắn cuối
let latestMessages = {}; // Biến lưu tin nhắn cuối
// let rooms = {};

async function sendAlert(deviceId, message, timestamp) {
  const alertPayload = JSON.stringify({
    tag_id: deviceId,
    message,
    timestamp,
  });

  aedes.publish({
    topic: "uwb/alert",
    payload: alertPayload,
    qos: 0,
    retain: false,
  }, (err) => {
    if (err) {
      console.error("❌ Gửi cảnh báo thất bại:", err.message);
    } else {
      console.log("🚨 Gửi cảnh báo:", deviceId, message);
    }
  });

  const admins = await getAllAdmins();
  for (const admin of admins) {
    await sendNotification({
      user_id: admin.user_id,
      description: `${message} (Thiết bị: ${deviceId})`,
      type: "warning",
      // notify_time: timestamp,
      notify_time: new Date(Date.now() - 10 * 60 * 60 * 1000),
    });
  }
}

server.listen(PORT, async() => {
    console.log(`🚀 Aedes MQTT Broker đang chạy trên cổng ${PORT}`);
    // try {
    //   const roomList = await service.fetchAllRooms();
    //   for (const room of roomList) {
    //     rooms[room.room_id] = room;
    //   }
    //   console.log("📦 Rooms đã được load:", Object.keys(rooms));
    // } catch (err) {
    //   console.error("❌ Lỗi khi fetch rooms:", err.message);
    // }
    // tagManager.start(aedes);
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
      const time = new Date();
      console.log(`Tin nhắn từ ${client.id}:`, topic, message);

      // Ghi lại tin nhắn mới nhất
      // latestMessage = {
      //     topic,
      //     message,
      // };

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
              latestMessages[tagId] = {
                topic,
                message,
                time,
                isAlert: false,
              };
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
          [data.tag_id, time]
        );
  
        if (result.rows.length === 0) {
          await pool.query(
            `INSERT INTO device_location (
                device_id, tag_x, tag_y, tag_z,
                record_time, record_type
            ) VALUES ($1, $2, $3, $4, $5, 'hourly')`,
            [data.tag_id, data.tag_x, data.tag_y, data.tag_z, time]
          );
          console.log("🕐 Đã lưu bản ghi HOURLY cho device:", data.tag_id);
        } else {
          console.log("⚠️ Đã tồn tại bản ghi HOURLY cho device:", data.tag_id);
        }
      } catch (err) {
        console.error("❌ Lỗi khi lưu HOURLY:", err.message);
      }
    }
  }, hourlyInterval); // mỗi giờ
  
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
          [data.tag_id, time]
        );
  
        if (result.rows.length === 0) {
          await pool.query(
            `INSERT INTO device_location (
                device_id, tag_x, tag_y, tag_z,
                record_time, record_type
            ) VALUES ($1, $2, $3, $4, $5, 'daily')`,
            [data.tag_id, data.tag_x, data.tag_y, data.tag_z, time]
          );
          console.log("📅 Đã lưu bản ghi DAILY cho device:", data.tag_id);
        } else {
          console.log("⚠️ Đã tồn tại bản ghi DAILY cho device:", data.tag_id);
        }
      } catch (err) {
        console.error("❌ Lỗi khi lưu DAILY:", err.message);
      }
    }
  }, dailyInterval); // mỗi ngày

  setInterval(async () => {
    for (const deviceId in latestMessages) {
      const latestMessage = latestMessages[deviceId];
      const data = JSON.parse(latestMessage.message);
      const room = await service.fetchRoomById(data.tag_id)
      const time = latestMessage.time;
      const isAlert = latestMessage.isAlert;
      const now = new Date();
      try {
        const isInRoom = 
          data.tag_x >= 0 && data.tag_x <= room.room_max_x &&
          data.tag_y >= 0 && data.tag_y <= room.room_max_y;

        const hasRecentData = now - time <= NO_DATA_TIMEOUT;
        // --- Nếu thiết bị KHÔNG gửi dữ liệu ---
        if (!hasRecentData) {
          sendAlert(deviceId, "Thiết bị không gửi dữ liệu", now);

          // Xoá thiết bị khỏi latestMessages để dừng xử lý tiếp theo
          delete latestMessages[deviceId];
          continue;
        }
        if (isInRoom) {
        console.log(`✅ Tag ${data.tag_id} đang trong phòng ${room.room_id}`);
        } else {
          console.log(`❌ Tag ${data.tag_id} nằm ngoài phòng ${room.room_id}`);
          if (!isAlert) {
            sendAlert(deviceId, "Thiết bị nằm ngoài phòng", time);
            latestMessages[deviceId].isAlert = true;
          }
          // // Gửi tín hiệu cảnh báo qua MQTT
          // const alertPayload = JSON.stringify({
          //   tag_id: data.tag_id,
          //   message: "Thiết bị nằm ngoài phòng",
          //   timestamp: time,
          // });

          // aedes.publish({
          //   topic: "uwb/alert",
          //   payload: alertPayload,
          //   qos: 0,
          //   retain: false,
          // }, (err) => {
          //   if (err) {
          //     console.error("❌ Lỗi khi gửi MQTT alert:", err.message);
          //   } else {
          //     console.log("🚨 Đã gửi MQTT alert cho tag:", data.tag_id);
          //   }
          // });
        }
      } catch (err) {
        console.error("❌ Lỗi khi lưu HOURLY:", err.message);
      }
    }
  }, alertInterval);

module.exports = aedes;