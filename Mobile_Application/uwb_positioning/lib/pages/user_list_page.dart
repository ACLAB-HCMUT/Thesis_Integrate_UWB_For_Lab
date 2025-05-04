// import 'package:flutter/material.dart';
//
// class UserListPage extends StatelessWidget {
//   const UserListPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // Dữ liệu giả
//     final List<Map<String, String>> users = [
//       {
//         'username': 'khoi',
//         'fullName': 'Hồ Chí Anh Khôi',
//         'email': 'khoi.hota1602@hcmut.edu.vn',
//         'role': 'Admin',
//         'status': 'Active',
//       },
//       {
//         'username': 'duyen',
//         'fullName': 'Lê Thị Kỳ Duyên',
//         'email': 'lethikyduyen@gmail.com',
//         'role': 'User',
//         'status': 'Active',
//       },
//     ];
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Danh sách Người dùng'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context); // <-- Nút trở về
//           },
//         ),
//       ),
//       body: ListView.separated(
//         itemCount: users.length,
//         separatorBuilder: (_, __) => const Divider(),
//         itemBuilder: (context, index) {
//           final user = users[index];
//           return ListTile(
//             leading: CircleAvatar(
//               child: Text(user['username']![0].toUpperCase()),
//             ),
//             title: Text(user['fullName']!),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Email: ${user['email']}'),
//                 Text('Role: ${user['role']}'),
//                 Text('Status: ${user['status']}'),
//               ],
//             ),
//             isThreeLine: true,
//             trailing: IconButton(
//               icon: const Icon(Icons.edit),
//               onPressed: () {
//                 // Bạn có thể thay đổi hành động khi nhấn vào nút sửa.
//                 print('Sửa thông tin người dùng ${user['fullName']}');
//               },
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Hành động tạo người dùng mới
//           print('Tạo người dùng mới');
//         },
//         child: const Icon(Icons.add),
//         tooltip: 'Tạo người dùng mới',
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwb_positioning/models/user.dart';
import 'package:uwb_positioning/services/auth_service.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);
  static const nameRoute = '/users';

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late Future<List<User>> _futureUsers;

  @override
  void initState() {
    super.initState();
    // Lấy instance của UserService và gọi fetchAllUsers()
    _futureUsers = context.read<AuthService>().fetchAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách Người dùng'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<User>>(
        future: _futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          }
          final users = snapshot.data!;
          if (users.isEmpty) {
            return const Center(child: Text('Không có người dùng nào.'));
          }
          return ListView.separated(
            itemCount: users.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                leading: CircleAvatar(child: Text(user.fullName[0])),
                title: Text(user.fullName),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email: ${user.email}'),
                    Text('Role: ${user.role}'),
                    Text('Status: ${user.status}'),
                  ],
                ),
                isThreeLine: true,
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // navigate to edit page, truyền user.userId
                    Navigator.pushNamed(context, '/user/update', arguments: user.userId);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/user/create');
        },
        child: const Icon(Icons.add),
        tooltip: 'Tạo người dùng mới',
      ),
    );
  }
}
