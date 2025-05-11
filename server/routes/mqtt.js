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
const tagManager = require("./tagManager"); // Import tagManager

const PORT = 1883;
const aedes = Aedes();
const server = net.createServer(aedes.handle);

let latestMessage = null; // Biến lưu tin nhắn cuối

server.listen(PORT, () => {
    console.log(`Aedes MQTT Broker đang chạy trên cổng ${PORT}`);
    tagManager.start(aedes);
});

aedes.on("client", (client) => {
    console.log(`Thiết bị kết nối: ${client.id}`);
});

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

            const tagId = data.id;

            if (tagId) {
                tagManager.handleRegister(tagId, aedes);
            } else {
                console.error("❌ JSON hợp lệ nhưng không có trường 'id':", data);
            }
        }

        // Ngoài ra, nếu tag gửi định kỳ để duy trì "seen"

        if (topic === "uwb/tagposition") {
            const data = JSON.parse(message);
            const tagId = data.id;
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
            const tagId = data.id;
            tagManager.handleTimeoutMessage(tagId, aedes);
        }
    }
});



// Lưu tin nhắn cuối mỗi 10 giây
setInterval(async () => {
    if (latestMessage) {
        try {
            await pool.query(
                "INSERT INTO mqtt_messages(topic, message) VALUES ($1, $2)",
                [latestMessage.topic, latestMessage.message]
            );
            console.log("🕒 Đã lưu tin nhắn mới nhất vào PostgreSQL");
            latestMessage = null; // Đặt lại sau khi lưu
        } catch (err) {
            console.error("❌ Lỗi khi lưu DB:", err.message);
        }
    }
}, 10000); // 10000 ms = 10 giây

module.exports = aedes;