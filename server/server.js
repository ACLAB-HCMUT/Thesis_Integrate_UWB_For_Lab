const express = require("express");
const dotenv = require("dotenv");

dotenv.config();

const deviceRoutes = require("./routes/deviceRoute");
const locationRoutes = require("./routes/locationRoute");
const requestRoutes = require("./routes/requestRoute");
const authRoutes = require("./routes/authRoute")

// Tạo server Express
const app = express();

// Import routes
require("./mqtt/mqttBroker");

app.use(express.json());
app.use("/devices", deviceRoutes);
app.use("/locations", locationRoutes);
app.use("/request", requestRoutes);
app.use("/auth", authRoutes);

// Khởi động server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
