import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:uwb_positioning/services/config.dart';
import 'package:flutter/material.dart';
import 'package:uwb_positioning/models/user.dart';

class AuthProvider with ChangeNotifier {
  Auth? _user;

  Auth? get user => _user;

  void setUser(Auth user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}

class AuthService with ChangeNotifier {
  static final getAllUsersUri = baseUri.replace(path: '/auth');
  static final loginUri = baseUri.replace(path: '/auth/login');
  static Uri updateUri(int id) => baseUri.replace(path: '/auth/$id');
  final AuthProvider userProvider;
  static final Logger _logger = Logger('UserService');

  AuthService(this.userProvider);
  Future<List<User>> fetchAllUsers() async {
    final token = userProvider.user?.token;

    if (token == null) {
      throw Exception('Token không tồn tại');
    }
    final response = await http.get(
      getAllUsersUri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Không thể tải danh sách người dùng');
    }
  }

  Future<User> fetchUserDetail(int userId) async {
    final token = userProvider.user?.token;
    if (token == null) throw Exception('Token không tồn tại');

    final uri = updateUri(userId);
    final resp = await http.get(uri, headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });
    if (resp.statusCode != 200) {
      throw Exception('Không lấy được thông tin user');
    }
    final data =  jsonDecode(resp.body);
    return User.fromJson(data);
  }

  Future<void> updateUser(int userId, Map<String, dynamic> updates) async {
    // Lấy token từ AuthProvider
    final token = userProvider.user?.token;
    if (token == null) throw Exception('Token không tồn tại');

    // Tạo URL: /auth/:id
    final uri = updateUri(userId);

    // Gửi PATCH
    final resp = await http.patch(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(updates),
    );

    if (resp.statusCode != 200) {
      throw Exception('Cập nhật thất bại: ${resp.statusCode}');
    }
  }

  static Future<Auth> login(String email, String password) async {
    final response = await http.post(
      loginUri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final user = Auth.fromJson(data);
      return user;
    } else {
      throw Exception('Sai email hoặc mật khẩu');
    }
  }

  static Future<void> logout(BuildContext context) async {
    Provider.of<AuthProvider>(context, listen: false).clearUser();
  }
}