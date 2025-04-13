// const Aedes = require("aedes");
// const net = require("net");

// const PORT = 1883; // Port MQTT Broker
// const aedes = Aedes();

// const server = net.createServer(aedes.handle);

// server.listen(PORT, function () {
//     console.log(`🚀 Aedes MQTT Broker đang chạy trên cổng ${PORT}`);
// });

// // Lắng nghe sự kiện khi có thiết bị kết nối
// aedes.on("client", function (client) {
//     console.log(`📡 Thiết bị kết nối: ${client.id}`);
// });

// // Xử lý khi có tin nhắn đến
// aedes.on("publish", function (packet, client) {
//     if (client) {
//         console.log(`📨 Tin nhắn từ ${client.id}:`, packet.topic, packet.payload.toString());
//     }
// });

// module.exports = aedes;






// const Aedes = require("aedes");
// const net = require("net");
// const pool = require("../config/db"); // Import kết nối DB

// const PORT = 1883;
// const aedes = Aedes();
// const server = net.createServer(aedes.handle);

// server.listen(PORT, function () {
//     console.log(`🚀 Aedes MQTT Broker đang chạy trên cổng ${PORT}`);
// });

// aedes.on("client", function (client) {
//     console.log(`📡 Thiết bị kết nối: ${client.id}`);
// });

// aedes.on("publish", async function (packet, client) {
//     if (client) {
//         const topic = packet.topic;
//         const message = packet.payload.toString();
//         console.log(`📨 Tin nhắn từ ${client.id}:`, topic, message);

//         // Ghi vào PostgreSQL
//         try {
//             await pool.query(
//                 "INSERT INTO mqtt_messages(topic, message) VALUES ($1, $2)",
//                 [topic, message]
//             );
//             console.log("✅ Đã lưu vào PostgreSQL");
//         } catch (error) {
//             console.error("❌ Lỗi ghi DB:", error.message);
//         }
//     }
// });

// module.exports = aedes;





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
        console.log(`📨 Tin nhắn từ ${client.id}:`, topic, message);

        // Ghi lại tin nhắn mới nhất
        latestMessage = {
            topic,
            message,
        };
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
