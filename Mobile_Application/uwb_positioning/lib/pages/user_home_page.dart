import 'package:flutter/material.dart';
import 'package:uwb_positioning/pages/device_list_page.dart';
import 'package:uwb_positioning/pages/login_page.dart';
import 'package:uwb_positioning/pages/notification_list_page.dart';
import 'package:provider/provider.dart';
import 'package:uwb_positioning/services/auth_service.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({Key? key}) : super(key: key);
  static const nameRoute = '/user-home';

  void _logout(BuildContext context) async {
    await AuthService.logout(context);
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginPage.nameRoute,
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            tooltip: "Notifications",
            onPressed: () {
              Navigator.pushNamed(context, NotificationListPage.nameRoute);
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Đăng xuất",
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, DeviceListPage.nameRoute),
              child: const Text('Danh sách thiết bị'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/borrow_request_manage'),
              child: const Text('Danh sách yêu cầu mượn'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/borrow_request_manage'),
              child: const Text('Thông tin tài khoản'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
