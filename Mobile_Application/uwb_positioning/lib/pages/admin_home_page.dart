// import 'package:flutter/material.dart';
//
// class AdminHomePage extends StatelessWidget {
//   const AdminHomePage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Trang chủ Admin'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ElevatedButton(
//               onPressed: () => Navigator.pushNamed(context, '/users'),
//               child: const Text('Quản lý người dùng'),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () => Navigator.pushNamed(context, '/borrow_request_manage'),
//               child: const Text('Quản lý yêu cầu mượn'),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () => Navigator.pushNamed(context, '/devices'),
//               child: const Text('Quản lý thiết bị'), // <-- NÚT MỚI NÈ
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 // TODO: Xử lý đăng xuất
//                 Navigator.pushReplacementNamed(context, '/login');
//               },
//               child: const Text('Đăng xuất'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:uwb_positioning/pages/notification_list_page.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            tooltip: "Notifications",
            onPressed: () {
              Navigator.pushNamed(context, NotificationListPage.nameRoute);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/users'),
              child: const Text('Quản lý Người dùng'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/borrow_request_manage'),
              child: const Text('Quản lý Yêu cầu Mượn'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/devices'),
              child: const Text('Quản lý Thiết bị'),
            ),
          ],
        ),
      ),
    );
  }
}
