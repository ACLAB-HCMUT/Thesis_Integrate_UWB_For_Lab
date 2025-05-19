import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uwb_positioning/models/borrow_request.dart';
import 'package:uwb_positioning/services/borrow_request_service.dart';

class UserBorrowRequestPage extends StatefulWidget {
  const UserBorrowRequestPage({super.key});
  static const nameRoute = '/user-request';
  @override
  State<UserBorrowRequestPage> createState() => _UserBorrowRequestPageState();
}

class _UserBorrowRequestPageState extends State<UserBorrowRequestPage> {
  late BorrowRequestService _service;
  late Future<List<BorrowRequests>> _borrowRequestsFuture;
  String formatDate(DateTime? date) {
    if (date == null) return 'Chưa cập nhật';
    return DateFormat('yyyy-MM-dd').format(date);
  }
  @override
  void initState() {
    super.initState();
    _service = Provider.of<BorrowRequestService>(context, listen: false);
    _borrowRequestsFuture = _service.fetchRequestsById();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Yêu cầu mượn của bạn')),
      body: FutureBuilder<List<BorrowRequests>>(
        future: _borrowRequestsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Không có yêu cầu nào.'));
          }

          final requests = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final req = requests[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  title: Text('Yêu cầu ID: ${req.requestId}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Thiết bị ID: ${req.deviceId}'),
                      Text('Chi tiết: ${req.detail}'),
                      Text('Ngày hẹn: ${formatDate(req.appointmentDate)}'),
                      Text('Ngày trả dự kiến: ${formatDate(req.expectedReturn)}'),
                      Text('Trạng thái: ${req.status ?? 'Chưa xác định'}'),
                      Text('Mượn: ${formatDate(req.borrowDate)}'),
                      Text('Trả: ${formatDate(req.returnDate)}'),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Xử lý nếu muốn xem chi tiết hơn
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
