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

// const mqtt = require("mqtt");
// const readline = require("readline");

// // Thay đổi IP theo broker của bạn
// const BROKER_URL = "mqtt://localhost:1883"; // hoặc "mqtt://192.168.x.x:1883"
// const TOPIC = "uwb/tagposition";

// const client = mqtt.connect(BROKER_URL);

// // Tạo giao diện nhập từ terminal
// const rl = readline.createInterface({
//     input: process.stdin,
//     output: process.stdout,
// });

// client.on("connect", () => {
//     console.log("✅ Đã kết nối tới MQTT Broker");
//     console.log(`📤 Nhập tin nhắn để gửi lên topic "${TOPIC}"`);
//     promptInput();
// });

// function promptInput() {
//     rl.question("> Tin nhắn JSON (hoặc 'exit' để thoát): ", (input) => {
//         if (input.toLowerCase() === "exit") {
//             rl.close();
//             client.end();
//             return;
//         }

//         try {
//             const json = JSON.parse(input); // Kiểm tra nếu là JSON hợp lệ
//             client.publish(TOPIC, JSON.stringify(json));
//             console.log("📨 Tin nhắn đã gửi!");
//         } catch (e) {
//             console.log("❌ Vui lòng nhập một JSON hợp lệ.");
//         }

//         promptInput(); // Gọi lại để nhập tiếp
//     });
// }

const mqtt = require("mqtt");
const readline = require("readline");

// Tạo kết nối với MQTT broker đang chạy tại localhost:1883
const client = mqtt.connect("mqtt://localhost:1883");

// Tạo interface để nhập liệu
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

// Hàm hỏi người dùng
function askQuestion(query) {
  return new Promise((resolve) => rl.question(query, resolve));
}

// Khi kết nối thành công
client.on("connect", async () => {
  console.log("✅ Đã kết nối tới MQTT broker");

  try {
    const tagId = await askQuestion("🔷 Nhập tag_id: ");
    const tagX = parseFloat(await askQuestion("🔷 Nhập tag_x: "));
    const tagY = parseFloat(await askQuestion("🔷 Nhập tag_y: "));
    const tagZ = parseFloat(await askQuestion("🔷 Nhập tag_z: "));
    const dataUwb = await askQuestion("🔷 Nhập data_uwb: ");

    const payload = {
      tag_id: tagId,
      timestamp: Date.now(),
      tag_x: tagX,
      tag_y: tagY,
      tag_z: tagZ,
      data: dataUwb,
    };

    const topic = "uwb/tagposition";

    client.publish(topic, JSON.stringify(payload), { qos: 0 }, (err) => {
      if (err) {
        console.error("❌ Gửi thất bại:", err.message);
      } else {
        console.log("📤 Đã gửi lên topic", topic);
        console.log("📦 Payload:", payload);
      }

      rl.close();
      client.end();
    });
  } catch (err) {
    console.error("❌ Lỗi khi nhập/gửi:", err.message);
    rl.close();
    client.end();
  }
});
