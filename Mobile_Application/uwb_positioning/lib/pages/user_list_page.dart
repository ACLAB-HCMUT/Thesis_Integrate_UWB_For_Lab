import 'package:flutter/material.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Danh sách người dùng')),
      body: ListView.builder(
        itemCount: 10, // TODO: Thay bằng số lượng người dùng thực tế
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Người dùng $index'),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // TODO: Điều hướng sang trang cập nhật người dùng
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Điều hướng sang trang tạo người dùng
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
