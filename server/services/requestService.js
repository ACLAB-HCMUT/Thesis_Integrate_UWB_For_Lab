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

module.exports = {
  createRequest,
  changeBorrowDate,
  changeReturnDate,
};
