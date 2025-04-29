import 'package:flutter/material.dart';

class UserCreatePage extends StatefulWidget {
  const UserCreatePage({Key? key}) : super(key: key);

  @override
  State<UserCreatePage> createState() => _UserCreatePageState();
}

class _UserCreatePageState extends State<UserCreatePage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  String _selectedRole = 'User';
  String _selectedStatus = 'Active';

  final List<String> _roles = ['Admin', 'User', 'Manager'];
  final List<String> _statuses = ['Active', 'Inactive', 'Pending'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo Người dùng'),
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
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _fullNameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
              ),
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
            // const SizedBox(height: 16),
            // DropdownButtonFormField<String>(
            //   value: _selectedStatus,
            //   items: _statuses.map((status) {
            //     return DropdownMenuItem<String>(
            //       value: status,
            //       child: Text(status),
            //     );
            //   }).toList(),
            //   onChanged: (value) {
            //     setState(() {
            //       _selectedStatus = value!;
            //     });
            //   },
            //   decoration: const InputDecoration(
            //     labelText: 'Status',
            //   ),
            // ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Submit tạo người dùng mới
                print('Tạo người dùng mới:');
                print('Username: ${_passwordController.text}');
                print('Full Name: ${_fullNameController.text}');
                print('Email: ${_emailController.text}');
                print('Phone: ${_phoneNumberController.text}');
                print('Role: $_selectedRole');
                print('Status: $_selectedStatus');
              },
              child: const Text('Tạo Người dùng'),
            ),
          ],
        ),
      ),
    );
  }
}
