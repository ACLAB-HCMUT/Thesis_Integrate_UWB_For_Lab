import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uwb_positioning/services/config.dart';
import 'package:uwb_positioning/models/borrow_request.dart';  // Import model BorrowRequest

class BorrowRequestService {
  static final getAllRequestUri = baseUri.replace(path: '/request');
  static final createUri = baseUri.replace(path: '/request/create');
  static Uri changeBorrowUri(int id) => baseUri.replace(path: '/request/borrow-date/$id');
  static Uri changeReturnUri(int id) => baseUri.replace(path: '/request/return-date/$id');
  static Uri changeStatusUri(int id) => baseUri.replace(path: '/request/status/$id');

  Future<bool> createRequest(BorrowRequest request) async {
    final response = await http.post(
      createUri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()), // Convert BorrowRequest to JSON
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
