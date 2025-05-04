// controllers/authController.js
const authService = require('../services/authService');

const register = async (req, res) => {
  try {
    const user = await authService.registerUser(req.body);
    res.status(201).json({ message: 'User registered successfully', user });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

const login = async (req, res) => {
    try {
      const { email, password } = req.body;
      const result = await authService.loginUser(email, password);
      res.status(200).json({ message: 'Đăng nhập thành công', ...result });
    } catch (err) {
      res.status(401).json({ error: err.message });
    }
};

const update = async (req, res) => {
    try {
      const userId = req.params.id;
      const updates = req.body;
  
      const updatedUser = await authService.updateUser(userId, updates);

      if (!updatedUser) {
        return res.status(404).json({ error: 'Không tìm thấy người dùng để cập nhật' });
      }
      
      res.status(200).json({
        message: 'Cập nhật thành công',
        user: updatedUser,
      });
    } catch (err) {
      res.status(400).json({ error: err.message });
    }
}

const getAllUsers = async (req, res) => {
  try {
    const users = await authService.getAllUsers();
    res.status(200).json(users);
  } catch (error) {
    res.status(500).json({ message: 'Lỗi khi lấy danh sách người dùng', error: error.message });
  }
}

const getUserDetail = async (req, res) => {
  try {
    const id = req.params.id;
    const user = await authService.getUser(id);
    res.json(user);
  } catch (err) {
    res.status(404).json({ message: err.message });
  }
}

module.exports = {
  register,
  login,
  update,
  getAllUsers,
  getUserDetail,
};
