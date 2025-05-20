const mqtt = require("mqtt");

// Cấu hình
const TAG_ID = "2";
const MQTT_BROKER = "mqtt://localhost:1883";
const MAX_TIMEOUT_RETRY_MS = 6000;
const position = [
    [1.0, 1.0, 0.0],
    [2.0, 1.0, 0.0],
    [2.0, 2.0, 0.0],
    [1.0, 2.0, 0.0],
];

let isAcknowledged = false;
let isActive = false;
let timeoutAckReceived = false;

let sendInterval = null;
let retryTimeoutInterval = null;
let timeoutRetryStart = null;

let client = null;
let idx = 0;

// Kết nối MQTT
function connectMQTT() {
    client = mqtt.connect(MQTT_BROKER);

    client.on("connect", () => {
        console.log("🔌 Đã kết nối đến MQTT Broker");
        client.subscribe(`uwb/ack/${TAG_ID}`);
        client.subscribe("uwb/control");
        sendRegisterRequest();
    });

    client.on("message", (topic, message) => {
        const payload = JSON.parse(message.toString());
        console.log(`📥 Nhận tin nhắn từ ${topic}:`, payload);

        if (topic === `uwb/ack/${TAG_ID}`) {
            if (payload.status === "register_ok" && !isAcknowledged) {
                isAcknowledged = true;
                console.log("✅ Đã được server chấp nhận");
            }

            if (payload.status === "timeout_ok") {
                timeoutAckReceived = true;
                console.log("✅ Server đã xác nhận timeout");
                clearInterval(retryTimeoutInterval);
            }
        }

        if (topic === "uwb/control") {
            handleControlMessage(payload);
        }
    });

    client.on("error", (err) => {
        console.error("❌ MQTT lỗi:", err.message);
    });

    client.on("close", () => {
        console.log("🔌 MQTT đã ngắt kết nối");
    });
}

// Gửi yêu cầu đăng ký tag
function sendRegisterRequest() {
    if (client && client.connected) {
        client.publish("uwb/register", JSON.stringify({ tag_id: TAG_ID }));

        setTimeout(() => {
            if (!isAcknowledged) {
                console.log("⏳ Không nhận được ack, gửi lại...");
                sendRegisterRequest();
            }
        }, 3000);
    }
}

// Xử lý phân quyền từ manager
function handleControlMessage(payload) {
    const { active_tag, duration } = payload;

    if (active_tag === TAG_ID) {
        console.log(`🚦 Tag ${TAG_ID} được kích hoạt trong ${duration}ms`);
        isActive = true;

        // Bắt đầu gửi dữ liệu định kỳ
        sendInterval = setInterval(sendTagData, 2000);

        // Hết thời gian → gửi timeout
        setTimeout(() => {
            isActive = false;
            clearInterval(sendInterval);
            console.log(`⛔ Tag ${TAG_ID} đã hết thời gian hoạt động`);

            // Bắt đầu gửi timeout và đợi ack
            notifyTimeoutWithRetry(TAG_ID);
        }, duration);
    }
}

// Gửi dữ liệu định kỳ
function sendTagData() {
    if (!isActive || !client.connected) return;

    if (idx >= 4) {
        idx = 0;
    }

    const data = {
        tag_id: TAG_ID,
        timestamp: Date.now(),
        tag_x: position[idx][0],
        tag_y: position[idx][1],
        tag_z: position[idx][2],
        info: "Dữ liệu từ tag đang hoạt động"
    };

    idx++;

    client.publish(`uwb/tagposition`, JSON.stringify(data));
    console.log("📤 Đã gửi dữ liệu:", data);
}

// Gửi timeout và thử lại trong 3 giây nếu chưa được xác nhận
function notifyTimeoutWithRetry(tagId) {
    timeoutAckReceived = false;
    timeoutRetryStart = Date.now();

    // Gửi ngay lần đầu
    sendTimeoutMessage(tagId);

    // Thử lại mỗi 1 giây trong tối đa MAX_TIMEOUT_RETRY_MS
    retryTimeoutInterval = setInterval(() => {
        const elapsed = Date.now() - timeoutRetryStart;

        if (timeoutAckReceived) {
            clearInterval(retryTimeoutInterval);
            return;
        }

        if (elapsed > MAX_TIMEOUT_RETRY_MS) {
            console.warn(`🛑 Không nhận được xác nhận timeout từ server sau ${MAX_TIMEOUT_RETRY_MS}ms. Dừng gửi`);
            clearInterval(retryTimeoutInterval);
            return;
        }

        sendTimeoutMessage(tagId);
    }, 1000);
}

function sendTimeoutMessage(tagId) {
    const message = JSON.stringify({ tag_id: tagId, status: "timeout" });
    client.publish("uwb/timeout", message);
    console.log("⏱️ Gửi timeout:", message);
}

// Khởi chạy
connectMQTT();
