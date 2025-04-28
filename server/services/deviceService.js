// services/deviceService.js
const deviceModel = require('../models/deviceModel');

async function fetchAllDevices() {
  try {
    const devices = await deviceModel.getAll();
    return devices;
  } catch (error) {
    throw new Error("Error fetching devices from database");
  }
}

async function fetchDeviceById(deviceId) {
  try {
    const device = await deviceModel.getById(deviceId);
    if (!device) {
      throw new Error("Device not found");
    }
    return device;
  } catch (error) {
    throw new Error("Error fetching device by ID");
  }
}

module.exports = {
  fetchAllDevices,
  fetchDeviceById,
};
