// import 'package:flutter/material.dart';
// import 'package:uwb_positioning/services/auth_service.dart';
//
// class UserUpdatePage extends StatefulWidget {
//   const UserUpdatePage({Key? key}) : super(key: key);
//
//   @override
//   State<UserUpdatePage> createState() => _UserUpdatePageState();
// }
//
// class _UserUpdatePageState extends State<UserUpdatePage> {
//   // final TextEditingController _passwordController = TextEditingController(text: 'anhkhoi2003');
//   // final TextEditingController _fullNameController = TextEditingController(text: 'Hồ Chí Anh Khôi');
//   // final TextEditingController _emailController = TextEditingController(text: 'khoi.hota1602@hcmut.edu.vn');
//   // final TextEditingController _phoneNumberController = TextEditingController(text: '0939406884');
//   //
//   // String _selectedRole = 'Client';
//   // String _selectedStatus = 'Active';
//   //
//   // final List<String> _roles = ['Admin', 'Client'];
//   // final List<String> _statuses = ['Active', 'Inactive'];
//   final _fullName = TextEditingController();
//   final _email = TextEditingController();
//   final _phone = TextEditingController();
//   String _role = 'Client', _status = 'Active';
//   @override
//   void initState() {
//     super.initState();
//     _loadCurrentUser();
//   }
//
//   Future<void> _loadCurrentUser() async {
//     final userId =
//         Provider.of<AuthProvider>(context, listen: false).user!.id;
//     final data =
//     await AuthService.fetchUserDetail(context, userId);
//     setState(() {
//       _fullName.text = data['full_name'];
//       _email.text = data['email'];
//       _phone.text = data['phone_number'] ?? '';
//       _role = data['role'];
//       _status = data['status'];
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cập nhật Người dùng'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context); // <-- Nút trở về
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             TextField(
//               controller: _fullNameController,
//               decoration: const InputDecoration(
//                 labelText: 'Full Name',
//               ),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _emailController,
//               decoration: const InputDecoration(
//                 labelText: 'Email',
//               ),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _passwordController,
//               decoration: const InputDecoration(
//                 labelText: 'Password',
//               ),
//               readOnly: true, // Username thường không cho chỉnh sửa
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _phoneNumberController,
//               decoration: const InputDecoration(
//                 labelText: 'Phone Number',
//               ),
//               keyboardType: TextInputType.phone,
//             ),
//             const SizedBox(height: 16),
//             DropdownButtonFormField<String>(
//               value: _selectedRole,
//               items: _roles.map((role) {
//                 return DropdownMenuItem<String>(
//                   value: role,
//                   child: Text(role),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedRole = value!;
//                 });
//               },
//               decoration: const InputDecoration(
//                 labelText: 'Role',
//               ),
//             ),
//             const SizedBox(height: 16),
//             DropdownButtonFormField<String>(
//               value: _selectedStatus,
//               items: _statuses.map((status) {
//                 return DropdownMenuItem<String>(
//                   value: status,
//                   child: Text(status),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedStatus = value!;
//                 });
//               },
//               decoration: const InputDecoration(
//                 labelText: 'Status',
//               ),
//             ),
//             const SizedBox(height: 24),
//             ElevatedButton(
//               onPressed: () {
//                 // Submit cập nhật thông tin
//                 print('Cập nhật người dùng:');
//                 print('Username: ${_passwordController.text}');
//                 print('Full Name: ${_fullNameController.text}');
//                 print('Email: ${_emailController.text}');
//                 print('Role: $_selectedRole');
//                 print('Status: $_selectedStatus');
//               },
//               child: const Text('Cập nhật'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';

class UserUpdatePage extends StatefulWidget {
  const UserUpdatePage({super.key});

  @override
  State<UserUpdatePage> createState() => _UserUpdatePageState();
}

class _UserUpdatePageState extends State<UserUpdatePage> {
  late final int userId;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String _selectedRole = 'Client';
  String _selectedStatus = 'Active';

  final List<String> _roles = ['Admin', 'Client'];
  final List<String> _statuses = ['Active', 'Inactive'];

  bool _loading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userId = ModalRoute.of(context)!.settings.arguments as int;
    _fetchUserDetail();
  }

  Future<void> _fetchUserDetail() async {
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final user = await authService.fetchUserDetail(userId);

      setState(() {
        _fullNameController.text = user.fullName;
        _emailController.text = user.email;
        _phoneController.text = user.phoneNumber;
        _selectedRole = user.role == 'admin' ? 'Admin' : 'Client';
        _selectedStatus = user.status == 'inactive' ? 'Inactive' : 'Active';
        _loading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Lỗi tải thông tin: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> _submitUpdate() async {
    final body = {
      'full_name': _fullNameController.text,
      'email': _emailController.text,
      'phone_number': _phoneController.text,
      'role': _selectedRole.toLowerCase(),
      'status': _selectedStatus.toLowerCase(),
    };

    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      await authService.updateUser(userId, body);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Cập nhật thành công'),
          backgroundColor: Colors.green,
        ));
        Navigator.pop(context); // Quay lại list
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Cập nhật thất bại: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cập nhật người dùng')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _fullNameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedRole,
              items: _roles.map((role) {
                return DropdownMenuItem(value: role, child: Text(role));
              }).toList(),
              onChanged: (val) {
                setState(() => _selectedRole = val!);
              },
              decoration: const InputDecoration(labelText: 'Role'),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              items: _statuses.map((status) {
                return DropdownMenuItem(value: status, child: Text(status));
              }).toList(),
              onChanged: (val) {
                setState(() => _selectedStatus = val!);
              },
              decoration: const InputDecoration(labelText: 'Status'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitUpdate,
              child: const Text('Cập nhật'),
            ),
          ],
        ),
      ),
    );
  }
}
