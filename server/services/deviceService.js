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

async function updateDevice(id, updateFields) {
  try {
    const updatedDevice = await deviceModel.updateById(id, updateFields);
    if (!updatedDevice) {
      throw new Error('Device not found');
    }
    return updatedDevice;
  } catch (error) {
    throw new Error(error.message || 'Error updating device');
  }
}

module.exports = {
  fetchAllDevices,
  fetchDeviceById,
  updateDevice,
};
