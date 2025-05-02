import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uwb_positioning/services/config.dart';
import 'package:flutter/material.dart';
import 'package:uwb_positioning/models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}

class AuthService {
  static final loginUri = baseUri.replace(path: '/auth/login');

  static Future<User> login(String email, String password) async {
    final response = await http.post(
      loginUri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final user = User.fromJson(data);
      //
      // final prefs = await SharedPreferences.getInstance();
      // // await prefs.setString('token', user.token);
      // await prefs.setString('role', user.role);
      // await prefs.setInt('user_id', user.id);
      //
      return user;
    } else {
      throw Exception('Sai email hoặc mật khẩu');
    }
  }
}