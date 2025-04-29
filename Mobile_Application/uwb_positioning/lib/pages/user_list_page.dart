// import 'package:flutter/material.dart';
//
// class UserListPage extends StatelessWidget {
//   const UserListPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // Dữ liệu mẫu
//     final List<String> users = ['User A', 'User B', 'User C'];
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Danh sách Người dùng'),
//       ),
//       body: ListView.builder(
//         itemCount: users.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(users[index]),
//             trailing: IconButton(
//               icon: const Icon(Icons.edit),
//               onPressed: () {
//                 Navigator.pushNamed(context, '/user/update');
//               },
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pushNamed(context, '/user/create');
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dữ liệu giả
    final List<Map<String, String>> users = [
      {
        'username': 'khoi',
        'fullName': 'Hồ Chí Anh Khôi',
        'email': 'khoi.hota1602@hcmut.edu.vn',
        'role': 'Admin',
        'status': 'Active',
      },
      {
        'username': 'duyen',
        'fullName': 'Lê Thị Kỳ Duyên',
        'email': 'lethikyduyen@gmail.com',
        'role': 'User',
        'status': 'Active',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách Người dùng'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // <-- Nút trở về
          },
        ),
      ),
      body: ListView.separated(
        itemCount: users.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(user['username']![0].toUpperCase()),
            ),
            title: Text(user['fullName']!),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email: ${user['email']}'),
                Text('Role: ${user['role']}'),
                Text('Status: ${user['status']}'),
              ],
            ),
            isThreeLine: true,
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // Bạn có thể thay đổi hành động khi nhấn vào nút sửa.
                print('Sửa thông tin người dùng ${user['fullName']}');
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Hành động tạo người dùng mới
          print('Tạo người dùng mới');
        },
        child: const Icon(Icons.add),
        tooltip: 'Tạo người dùng mới',
      ),
    );
  }
}
