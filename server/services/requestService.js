const requestModel = require('../models/requestModel');

async function createRequest(data) {
  try {
    const newRequest = await requestModel.createRequest(data);
    return newRequest;
  } catch (error) {
    throw new Error('Error creating borrow request');
  }
}

async function changeBorrowDate(requestId, borrowDate = new Date()) {
  try {
    const updatedRequest = await requestModel.changeBorrowDate(requestId, borrowDate);
    if (!updatedRequest) {
      throw new Error('Borrow request not found');
    }
    return updatedRequest;
  } catch (error) {
    throw new Error('Error updating borrow_date');
  }
}

async function changeReturnDate(requestId, returnDate = new Date()) {
  try {
    const updatedRequest = await requestModel.changeReturnDate(requestId, returnDate);
    if (!updatedRequest) {
      throw new Error('Borrow request not found');
    }
    return updatedRequest;
  } catch (error) {
    throw new Error('Error updating return_date');
  }
}

async function getAllRequests() {
  try {
    const requests = await requestModel.getAllRequests();
    return requests;
  } catch (error) {
    throw new Error('Error fetching borrow requests');
  }
}

async function getRequestsById(userId) {
  try {
    const requests = await requestModel.getRequestsById(userId);
    return requests;
  } catch (error) {
    throw new Error('Error fetching borrow requests by user');
  }
}

async function updateStatus(requestId, status) {
  try {
    const updatedRequest = await requestModel.changeStatus(requestId, status);
    if (!updatedRequest) {
      throw new Error('Borrow request not found');
    }
    return updatedRequest;
  } catch (error) {
    throw new Error('Error updating request status');
  }
}

module.exports = {
  createRequest,
  changeBorrowDate,
  changeReturnDate,
  getAllRequests,
  updateStatus,
  getRequestsById,
};
