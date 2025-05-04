// services/authService.js
const bcrypt = require('bcrypt');
const authModel = require('../models/authModel');
const jwt = require('jsonwebtoken')

const jwtSecret = process.env.JWT_SECRET || 'mySecretKey';

const registerUser = async (userData) => {
  const existingUser = await authModel.findUserByEmail(userData.email);
  if (existingUser) throw new Error('Email already exists');

  const hashedPassword = await bcrypt.hash(userData.password, 10);

  const newUser = await authModel.createUser({
    ...userData,
    password: hashedPassword
  });

  return newUser;
};

const loginUser = async (email, password) => {
    const user = await authModel.findUserByEmail(email);
  
    if (!user) throw new Error('Email không tồn tại');

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) throw new Error('Sai mật khẩu');
  
    const payload = {
      userId: user.user_id,
      role: user.role,
    };
  
    const token = jwt.sign(payload, jwtSecret, {
      expiresIn: '1d',
    });
  
    return { token, user: { user_id: user.user_id, full_name: user.full_name, role: user.role } };
    // return user;
};

const getUser = async(id) => {
  const user = await authModel.findUserById(id);
  if (!user) throw new Error('User not found');
  return user;
};

const updateUser = async (id, data) => {
    const updatedData = { ...data };
  
    if (data.password) {
      const salt = await bcrypt.genSalt(10);
      updatedData.password = await bcrypt.hash(data.password, salt);
    }
  
    return await authModel.updateUserById(id, updatedData);
}

const getAllUsers = async () => {
  const users = await authModel.getAllUsers();
  return users;
}

module.exports = {
  registerUser,
  loginUser,
  updateUser,
  getAllUsers,
  getUser,
};
