const express = require("express");
const dotenv = require("dotenv");

dotenv.config();

// Tạo server Express
const app = express();
app.use(express.json());

// Import routes
const mqttRoutes = require("./routes/mqtt");

// Sử dụng routes
app.use("/mqtt", mqttRoutes); // Routes cho MQTT

// API để Flutter lấy dữ liệu mới nhất
// app.get("/api/data", async (req, res) => {
//   try {
//     const adafruitData = await fetchDataFromAdafruit();
//     if (adafruitData) {
//       res.status(200).json(adafruitData);
//     } else {
//       res.status(500).json({ error: "Failed to fetch data from Adafruit IO" });
//     }
//   } catch (error) {
//     res.status(500).json({ error: error.message });
//   }
// });

// Khởi động server
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
