import 'package:flutter/material.dart';
import 'package:uwb_positioning/pages/change_password_page.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import 'package:provider/provider.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});
  static const nameRoute = '/user-info';

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  late Future<User> _futureUser;

  @override
  void initState() {
    super.initState();
    _futureUser = context.read<AuthService>().fetchClientDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thông tin người dùng')),
      body: FutureBuilder<User>(
        future: _futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final user = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                InfoTile(label: 'Email', value: user.email),
                InfoTile(label: 'Họ tên', value: user.fullName),
                InfoTile(label: 'Số điện thoại', value: user.phoneNumber),
                InfoTile(label: 'Vai trò', value: user.role),
                InfoTile(label: 'Trạng thái', value: user.status),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      ChangePasswordPage.nameRoute, // hoặc BorrowRequestPage.nameRoute nếu đã import
                    );
                  },
                  child: const Text('Đổi mật khẩu'),
                ),
              ],
            );
          } else {
            return const Center(child: Text('Không tìm thấy người dùng'));
          }
        },
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final String label;
  final String value;
  const InfoTile({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      subtitle: Text(value),
    );
  }
}
