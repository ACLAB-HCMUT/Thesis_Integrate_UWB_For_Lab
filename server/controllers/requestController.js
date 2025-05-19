const requestService = require('../services/requestService');

exports.createBorrowRequest = async (req, res) => {
  const {
    device_id,
    detail,
    status,
    appointment_date,
    expected_return,
    client_id,
  } = req.body;

  try {
    const newRequest = await requestService.createRequest({
      device_id,
      detail,
      status,
      appointment_date,
      expected_return,
      client_id,
    });
    res.status(201).json(newRequest);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.updateBorrowDate = async (req, res) => {
  const id = req.params.id;
  const borrowDate = req.body.borrow_date;

  try {
    const updatedRequest = await requestService.changeBorrowDate(id, borrowDate);
    res.json({ message: 'Đã cập nhật borrow_date', data: updatedRequest });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.updateReturnDate = async (req, res) => {
  const id = req.params.id;
  const returnDate = req.body.return_date;

  try {
    const updatedRequest = await requestService.changeReturnDate(id, returnDate);
    res.json({ message: 'Đã cập nhật return_date', data: updatedRequest });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.getAllBorrowRequests = async (req, res) => {
  try {
    const requests = await requestService.getAllRequests();
    res.status(200).json(requests);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.getBorrowRequestsByUser = async (req, res) => {
  try {
    const userId = req.params.id;
    const requests = await requestService.getRequestsById(userId);
    res.status(200).json(requests);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.updateBorrowRequestStatus = async (req, res) => {
  const { id } = req.params;
  const { status } = req.body;

  try {
    const updatedRequest = await requestService.updateStatus(id, status);
    res.status(200).json(updatedRequest);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};