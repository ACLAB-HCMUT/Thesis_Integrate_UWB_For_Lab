const locationModel = require('../models/locationModel');

async function fetchHourly(deviceId) {
  try {
    const locations = await locationModel.getLocations(deviceId, 'hourly');
    return locations;
  } catch (error) {
    throw new Error('Error fetching hourly locations from database');
  }
}

async function fetchDaily(deviceId) {
  try {
    const locations = await locationModel.getLocations(deviceId, 'daily');
    return locations;
  } catch (error) {
    throw new Error('Error fetching daily locations from database');
  }
}

async function fetchAnchors(deviceId) {
  try {
    const roomId = await locationModel.getRoomId(deviceId);
    const anchors = await locationModel.getAnchors(roomId);
    return anchors;
  } catch (error) {
    throw new Error('Error fetching anchor locations from database');
  }
}

async function fetchAllRooms() {
  try {
    const rooms = await locationModel.getAllRooms();
    return rooms;
  } catch (error) {
    throw new Error('Error fetching rooms from database');
  }
}

async function fetchRoomById(deviceId) {
  try {
    const roomId = await locationModel.getRoomId(deviceId);
    const room = await locationModel.getRoomById(roomId);
    return room;
  } catch (error) {
    throw new Error('Error fetching rooms from database');
  }
}

module.exports = {
  fetchHourly,
  fetchDaily,
  fetchAnchors,
  fetchAllRooms,
  fetchRoomById,
};
