const express = require("express");
const dotenv = require("dotenv");

dotenv.config();

const apiRoutes = require("./routes/api");

// Tạo server Express
const app = express();

// Import routes
require("./routes/mqtt");

app.use(express.json());
app.use("/", apiRoutes);

// Khởi động server
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
