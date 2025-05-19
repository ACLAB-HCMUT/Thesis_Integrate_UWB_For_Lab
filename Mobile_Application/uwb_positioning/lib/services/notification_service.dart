import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uwb_positioning/models/notification.dart';
import 'package:uwb_positioning/services/auth_service.dart';
import 'package:uwb_positioning/services/config.dart';
import 'package:logging/logging.dart';

class NotificationService {
  static final postUri = baseUri.replace(path: '/notifications');
  static Uri getUri(int id) => baseUri.replace(path: '/notifications/$id');
  final AuthProvider userProvider;
  NotificationService(this.userProvider);
  static final Logger _logger = Logger('NotificationService');

  Future<List<AppNotification>> fetchNotifications() async {
    try {
      final token = userProvider.user?.token;
      final userId = userProvider.user?.id;
      if (token == null) throw Exception('Token không tồn tại');
      if (userId == null) throw Exception('User ID không hợp lệ');
      final response = await http.get(getUri(userId));
      _logger.warning(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['data'] != null && data['data'] is List) {
          // Chuyển các phần tử trong 'data' thành danh sách thông báo
          return (data['data'] as List)
              .map((json) => AppNotification.fromJson(json))
              .toList();
        } else {
          throw Exception('Dữ liệu không đúng định dạng');
        }
      } else {
        throw Exception('Failed to load notifications');
      }
    } catch (e) {
      print('Error fetching notifications: $e');
      throw Exception('Failed to load notifications');
    }
  }
}
