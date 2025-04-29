import 'package:flutter/material.dart';

class UserUpdatePage extends StatefulWidget {
  const UserUpdatePage({Key? key}) : super(key: key);

  @override
  State<UserUpdatePage> createState() => _UserUpdatePageState();
}

class _UserUpdatePageState extends State<UserUpdatePage> {
  final TextEditingController _passwordController = TextEditingController(text: 'anhkhoi2003');
  final TextEditingController _fullNameController = TextEditingController(text: 'Hồ Chí Anh Khôi');
  final TextEditingController _emailController = TextEditingController(text: 'khoi.hota1602@hcmut.edu.vn');
  final TextEditingController _phoneNumberController = TextEditingController(text: '0939406884');

  String _selectedRole = 'Admin';
  String _selectedStatus = 'Active';

  final List<String> _roles = ['Admin', 'Client'];
  final List<String> _statuses = ['Active', 'Inactive'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cập nhật Người dùng'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // <-- Nút trở về
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _fullNameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              readOnly: true, // Username thường không cho chỉnh sửa
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedRole,
              items: _roles.map((role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedRole = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Role',
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              items: _statuses.map((status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Status',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Submit cập nhật thông tin
                print('Cập nhật người dùng:');
                print('Username: ${_passwordController.text}');
                print('Full Name: ${_fullNameController.text}');
                print('Email: ${_emailController.text}');
                print('Role: $_selectedRole');
                print('Status: $_selectedStatus');
              },
              child: const Text('Cập nhật'),
            ),
          ],
        ),
      ),
    );
  }
}
