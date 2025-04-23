const express = require("express");
const router = express.Router();
const deviceController = require('../controllers/deviceController');

// // API: Lấy danh sách thiết bị từ Firestore
// router.get("/", async (req, res) => {
//     try {
//       const snapshot = await db.collection("DEVICE").get();
//       const devices = snapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() }));
  
//       res.json(devices);
//     } catch (error) {
//       res.status(500).json({ error: error.message });
//     }
//   });

//   router.post("/getById", async (req, res) => {
//     try {
//       const { id } = req.body;
  
//       if (!id) {
//         return res.status(400).json({ error: "Vui lòng cung cấp ID thiết bị" });
//       }
  
//       const docRef = db.collection("DEVICE").doc(id);
//       const docSnap = await docRef.get();
  
//       if (!docSnap.exists) {
//         return res.status(404).json({ error: "Không tìm thấy thiết bị" });
//       }
  
//       // res.json({ id: docSnap.id, ...docSnap.data() });
//       // Lấy danh sách device_location bên trong document này
//     const locationsSnap = await docRef.collection("device_locations").get();
//     const locations = locationsSnap.docs.map((doc) => ({
//       id: doc.id,
//       ...doc.data(),
//     }));

//     res.json({
//       id: docSnap.id,
//       ...docSnap.data(),
//       device_location: locations, // Gộp collection vào kết quả trả về
//     });
//     } catch (error) {
//       res.status(500).json({ error: error.message });
//     }
//   });

// router.get("/users", (req, res) => {
//   res.json([{ id: 201, name: "Laptop" }, { id: 202, name: "Phone" }]);
// });

// API: GET /
router.get('/devices', deviceController.getAllDevices);
router.get('/devices/:id', deviceController.getDeviceById);
router.get('/locations/:id', deviceController.getDeviceLocations)
router.post('/create-request', deviceController.createBorrowRequest);
router.patch('/borrow-date/:id', deviceController.updateBorrowDate);
router.patch('/return-date/:id', deviceController.updateReturnDate);

module.exports = router;
