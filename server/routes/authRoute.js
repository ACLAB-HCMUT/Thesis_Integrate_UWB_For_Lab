const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');
const authMiddleware = require("../middlewares/authMiddleware")

router.post('/register', authController.register);
router.post('/login', authController.login);
router.get('/', authMiddleware.verifyToken, authMiddleware.isAdmin, authController.getAllUsers);
router.patch('/:id', authMiddleware.verifyToken, authMiddleware.isAdmin, authController.update);
router.get('/:id', authController.getUserDetail);

module.exports = router;