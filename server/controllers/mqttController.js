const axios = require("axios")

// 1. Hàm lấy dữ liệu từ Adafruit IO
async function fetchDataFromAdafruit(ADAFRUIT_API_URL, ADAFRUIT_API_KEY) {
    try {
      const response = await axios.get(ADAFRUIT_API_URL, {
        headers: {
          "X-AIO-Key": ADAFRUIT_API_KEY,
        },
      });
      const latestData = response.data[0]; // Lấy dữ liệu mới nhất
      console.log("Fetched data:", latestData);
      return latestData;
    } catch (error) {
      console.error("Error fetching data from Adafruit IO:", error.message);
      return null;
    }
}
  
// 2. Hàm lưu dữ liệu vào Firebase
async function saveDataToFirebase(db, value, createdAt, collectionName) {
    try {
        // Parse dữ liệu đầu vào
        const { id, location } = JSON.parse(value);
        const [tag_x, tag_y, tag_z] = location.split(',').map(coord => parseFloat(coord.trim()));
        // Tạo các reference
        const anchorRef = (anchorId) => db.collection("ANCHOR_LOCATION").doc(String(anchorId));
        const deviceRef = db.collection("DEVICE").doc(String(id));

        await db.collection(collectionName).add({
            anchor_1: anchorRef("1"),
            anchor_2: anchorRef("2"),
            anchor_3: anchorRef("3"),
            anchor_4: anchorRef("4"),
            device_id: deviceRef,
            record_time: new Date(createdAt),
            tag_x,
            tag_y,
            tag_z,
        });
      console.log(`Data saved to ${collectionName}:`, { value, createdAt });
    } catch (error) {
      console.error(`Error saving data to ${collectionName}:`, error.message);
    }
}

module.exports = {
    fetchDataFromAdafruit,
    saveDataToFirebase,
};