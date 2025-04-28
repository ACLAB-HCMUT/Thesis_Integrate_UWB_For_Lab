import 'package:flutter/material.dart';

class UserCreatePage extends StatelessWidget {
  const UserCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tạo mới người dùng')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'Tên người dùng'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Gửi yêu cầu tạo mới
              },
              child: const Text('Tạo người dùng'),
            ),
          ],
        ),
      ),
    );
  }
}
