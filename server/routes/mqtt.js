const express = require("express");
const schedule = require("node-schedule");
const db = require("../config/firebase");
const { fetchDataFromAdafruit, saveDataToFirebase } = require("../controllers/mqttController");

const router = express.Router();

// Cấu hình Adafruit IO
const ADAFRUIT_API_KEY = process.env.ADAFRUIT_API_KEY;
const ADAFRUIT_API_URL = process.env.ADAFRUIT_API_URL;

// Lên lịch để tự động lấy và lưu dữ liệu vào HOURLY_LOCATION mỗi 1 giờ
// Đổi thành */5 * * * * * để test tác vụ chạy mỗi 5 giây
schedule.scheduleJob("0 * * * *", async () => {
    console.log("Scheduled hourly task running...");
    const data = await fetchDataFromAdafruit(ADAFRUIT_API_URL, ADAFRUIT_API_KEY);
    if (data) {
      const { value, created_at } = data;
      console.log(value)
      await saveDataToFirebase(db, value, created_at, "HOURLY_LOCATION");
    }
});

// Lên lịch để tự động lấy và lưu dữ liệu vào DAILY_LOCATION mỗi 7:00 mỗi ngày
schedule.scheduleJob("0 7 * * *", async () => {
    console.log("Scheduled daily task running...");
    const data = await fetchDataFromAdafruit(ADAFRUIT_API_URL, ADAFRUIT_API_KEY);
    if (data) {
      const { value, created_at } = data;
      await saveDataToFirebase(db, value, created_at, "DAILY_LOCATION");
    }
  });

module.exports = router;