// const mqtt = require("mqtt");

// // Kết nối đến MQTT Broker (Thay IP nếu cần)
// const client = mqtt.connect("mqtt://192.168.1.2:1883");

// client.on("connect", () => {
//     console.log("✅ Đã kết nối MQTT Broker");

//     // Gửi tin nhắn mỗi 5 giây
//     setInterval(() => {
//         const message = JSON.stringify({ x: Math.random() * 10, y: Math.random() * 10, z: Math.random() * 5 });
//         client.publish("uwb/position", message);
//         console.log(`📤 Đã gửi: ${message}`);
//     }, 5000);
// });

const mqtt = require("mqtt");
const readline = require("readline");

// Thay đổi IP theo broker của bạn
const BROKER_URL = "mqtt://localhost:1883"; // hoặc "mqtt://192.168.x.x:1883"
const TOPIC = "uwb/tagposition";

const client = mqtt.connect(BROKER_URL);

// Tạo giao diện nhập từ terminal
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
});

client.on("connect", () => {
    console.log("✅ Đã kết nối tới MQTT Broker");
    console.log(`📤 Nhập tin nhắn để gửi lên topic "${TOPIC}"`);
    promptInput();
});

function promptInput() {
    rl.question("> Tin nhắn JSON (hoặc 'exit' để thoát): ", (input) => {
        if (input.toLowerCase() === "exit") {
            rl.close();
            client.end();
            return;
        }

        try {
            const json = JSON.parse(input); // Kiểm tra nếu là JSON hợp lệ
            client.publish(TOPIC, JSON.stringify(json));
            console.log("📨 Tin nhắn đã gửi!");
        } catch (e) {
            console.log("❌ Vui lòng nhập một JSON hợp lệ.");
        }

        promptInput(); // Gọi lại để nhập tiếp
    });
}
