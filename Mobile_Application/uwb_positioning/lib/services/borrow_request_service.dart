import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uwb_positioning/services/auth_service.dart';
import 'package:uwb_positioning/services/config.dart';
import 'package:uwb_positioning/models/borrow_request.dart';
import 'package:provider/provider.dart';

class BorrowRequestService {
  static final getAllRequestUri = baseUri.replace(path: '/request');
  static final createUri = baseUri.replace(path: '/request/create');
  static Uri getRequestByIdUri(int id) => baseUri.replace(path: '/request/$id');
  static Uri changeBorrowUri(int id) => baseUri.replace(path: '/request/borrow-date/$id');
  static Uri changeReturnUri(int id) => baseUri.replace(path: '/request/return-date/$id');
  static Uri changeStatusUri(int id) => baseUri.replace(path: '/request/status/$id');
  final AuthProvider userProvider;
  BorrowRequestService(this.userProvider);

  Future<bool> createRequest(BorrowRequest request) async {
    final token = userProvider.user?.token;
    final userId = userProvider.user?.id;
    if (token == null) throw Exception('Token không tồn tại');
    if (userId == null) throw Exception('User ID không hợp lệ');

    final requestBody = request.toJson()
      ..['client_id'] = userId;

    final response = await http.post(
      createUri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody), // Convert BorrowRequest to JSON
    );
    return response.statusCode == 201;
  }

  Future<List<BorrowRequests>> fetchRequests() async {
    final res = await http.get(getAllRequestUri);

    if (res.statusCode == 200) {
      final List<dynamic> data = jsonDecode(res.body);
      return data.map((json) => BorrowRequests.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load borrow requests');
    }
  }

  Future<List<BorrowRequests>> fetchRequestsById() async {
    final token = userProvider.user?.token;
    final userId = userProvider.user?.id;
    if (token == null) throw Exception('Token không tồn tại');
    if (userId == null) throw Exception('User ID không hợp lệ');

    final response = await http.get(getRequestByIdUri(userId));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => BorrowRequests.fromJson(e)).toList();
    } else {
      throw Exception('Lỗi khi tải yêu cầu mượn');
    }
  }

  Future<void> changeBorrowDate(int requestId, DateTime borrowDate) async {
    final response = await http.patch(
      changeBorrowUri(requestId),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'borrow_date': borrowDate.toIso8601String()}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update borrow date');
    }
  }

  Future<void> changeReturnDate(int requestId, DateTime returnDate) async {
    final response = await http.patch(
      changeReturnUri(requestId),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'return_date': returnDate.toIso8601String()}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update return date');
    }
  }

  Future<void> updateRequestStatus(int requestId, String status) async {
    final response = await http.patch(
      changeStatusUri(requestId),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'status': status}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update status');
    }
  }
}
