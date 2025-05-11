const mqtt = require("mqtt");

const TOPIC = "uwb/tagposition";

// Kết nối đến MQTT Broker (Thay IP nếu cần)
const client = mqtt.connect("mqtt://localhost:1883");

client.on("connect", () => {
    console.log("✅ Đã kết nối MQTT Broker");

    // Subscribe để nhận dữ liệu từ topic "uwb/position"
    client.subscribe(TOPIC, (err) => {
        if (!err) {
            console.log(`📡 Đã subscribe vào topic: "${TOPIC}"`);
        }
    });
});

// Nhận dữ liệu từ MQTT
client.on("message", (topic, message) => {
    console.log(`📥 Nhận tin nhắn từ ${topic}: ${message.toString()}`);
});
