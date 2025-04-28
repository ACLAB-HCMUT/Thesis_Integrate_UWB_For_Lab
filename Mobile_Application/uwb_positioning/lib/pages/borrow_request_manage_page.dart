import 'package:flutter/material.dart';

class BorrowRequestManagePage extends StatelessWidget {
  const BorrowRequestManagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quản lý yêu cầu mượn thiết bị')),
      body: ListView.builder(
        itemCount: 5, // TODO: Thay bằng số lượng yêu cầu thực tế
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text('Yêu cầu mượn #$index'),
              subtitle: const Text('Thông tin thiết bị và người mượn...'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: () {
                      // TODO: Xác nhận duyệt yêu cầu
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      // TODO: Từ chối yêu cầu
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
