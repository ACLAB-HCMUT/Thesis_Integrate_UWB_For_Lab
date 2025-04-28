const express = require("express");
const dotenv = require("dotenv");

dotenv.config();

const deviceRoutes = require("./routes/deviceRoute");
const locationRoutes = require("./routes/locationRoute");
const requestRoutes = require("./routes/requestRoute");

// Tạo server Express
const app = express();

// Import routes
require("./mqtt/mqttBroker");

app.use(express.json());
app.use("/devices", deviceRoutes);
app.use("/locations", locationRoutes);
app.use("/request", requestRoutes);

// Khởi động server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
