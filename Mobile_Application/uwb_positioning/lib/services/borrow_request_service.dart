import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uwb_positioning/services/config.dart';
import 'package:uwb_positioning/models/borrow_request.dart';  // Import model BorrowRequest

class BorrowRequestService {
  static final createUri = baseUri.replace(path: '/create-request');
  Future<bool> createRequest(BorrowRequest request) async {
    final response = await http.post(
      createUri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()), // Convert BorrowRequest to JSON
    );
    return response.statusCode == 201;
  }

  Future<List<BorrowRequest>> fetchRequests() async {
    final uri = Uri.parse('baseUrl/borrow-request');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => BorrowRequest.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
