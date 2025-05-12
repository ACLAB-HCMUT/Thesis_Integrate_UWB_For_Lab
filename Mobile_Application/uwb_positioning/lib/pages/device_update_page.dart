// import 'package:flutter/material.dart';
//
// class DeviceUpdatePage extends StatefulWidget {
//   const DeviceUpdatePage({super.key});
//   static const nameRoute = "/device-update";
//   @override
//   State<DeviceUpdatePage> createState() => _DeviceUpdatePageState();
// }
//
// class _DeviceUpdatePageState extends State<DeviceUpdatePage> {
//   final _formKey = GlobalKey<FormState>();
//
//   final TextEditingController _nameCtl = TextEditingController(text: 'UWB Tag 1');
//   final TextEditingController _descCtl = TextEditingController(text: 'UWB is a Unit which integrates the UWB(Ultra Wide Band) communication protocol which uses nanosecond pulses to locate objects and define position and orientation. The design uses the Ai-ThinkerBU01 Transceiver module which is based on Decawave\'s DW1000 design. The internal STM32 chip with its integrated ranging algorithm,is capable of 10cm positioning accuracy and also supports AT command control. Applications include: Indoor wireless tracking/range finding of assets,which works by triangulating the position of the base station/s and tag (the base station resolves the position information and outputs it to the tag).');
//   final TextEditingController _serialCtl = TextEditingController(text: 'SKU:U100');
//   final TextEditingController _manufacturerCtl = TextEditingController(text: 'M5Stack');
//   final TextEditingController _specCtl = TextEditingController(text: 'Data transfer rate: 10 kbit/s, 850 kbit/s and 6.8 Mbit/s');
//   final TextEditingController _imageCtl = TextEditingController(text: 'https://static-cdn.m5stack.com/resource/docs/products/unit/uwb/uwb_02.webp');
//
//   int? _selectedTypeId;
//   bool _isActive = true;
//   bool _isAvailable = true;
//
//   // Dữ liệu giả cho loại thiết bị
//   final List<Map<String, dynamic>> deviceTypes = [
//     {'id': 1, 'name': 'UWB unit'},
//     {'id': 2, 'name': 'Tablet'},
//     {'id': 3, 'name': 'Camera'},
//   ];
//
//   void _submit() {
//     if (_formKey.currentState!.validate()) {
//       // Gửi dữ liệu cập nhật lên server
//       print('Cập nhật thiết bị:');
//       print('Tên: ${_nameCtl.text}');
//       print('Mô tả: ${_descCtl.text}');
//       print('Serial: ${_serialCtl.text}');
//       print('Hãng: ${_manufacturerCtl.text}');
//       print('Thông số: ${_specCtl.text}');
//       print('Ảnh: ${_imageCtl.text}');
//       print('Loại: $_selectedTypeId');
//       print('Hoạt động: $_isActive');
//       print('Sẵn sàng: $_isAvailable');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final args = ModalRoute.of(context)?.settings.arguments;
//     final deviceId = args is String ? args : args?.toString() ?? 'unknown';
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cập nhật thiết bị'),
//         leading: BackButton(onPressed: () => Navigator.pop(context)),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: ListView(children: [
//             TextFormField(
//               controller: _nameCtl,
//               decoration: const InputDecoration(labelText: 'Tên thiết bị'),
//               validator: (v) => v == null || v.isEmpty ? 'Không được bỏ trống' : null,
//             ),
//             TextFormField(
//               controller: _descCtl,
//               decoration: const InputDecoration(labelText: 'Mô tả'),
//             ),
//             TextFormField(
//               controller: _serialCtl,
//               decoration: const InputDecoration(labelText: 'Serial'),
//             ),
//             TextFormField(
//               controller: _manufacturerCtl,
//               decoration: const InputDecoration(labelText: 'Hãng sản xuất'),
//             ),
//             TextFormField(
//               controller: _specCtl,
//               decoration: const InputDecoration(labelText: 'Thông số kỹ thuật'),
//             ),
//             DropdownButtonFormField<int>(
//               value: _selectedTypeId,
//               items: deviceTypes
//                   .map((e) => DropdownMenuItem<int>(
//                 value: e['id'] as int, // ép kiểu rõ ràng
//                 child: Text(e['name'] as String),
//               ))
//                   .toList(),
//               decoration: const InputDecoration(labelText: 'Loại thiết bị'),
//               onChanged: (v) => setState(() => _selectedTypeId = v),
//               validator: (v) => v == null ? 'Chọn loại thiết bị' : null,
//             ),
//             TextFormField(
//               controller: _imageCtl,
//               decoration: const InputDecoration(labelText: 'Đường dẫn ảnh'),
//             ),
//             SwitchListTile(
//               title: const Text('Đang hoạt động'),
//               value: _isActive,
//               onChanged: (v) => setState(() => _isActive = v),
//             ),
//             SwitchListTile(
//               title: const Text('Sẵn sàng cho mượn'),
//               value: _isAvailable,
//               onChanged: (v) => setState(() => _isAvailable = v),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _submit,
//               child: const Text('Cập nhật'),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/device_service.dart'; // Đổi thành import đúng của bạn

class DeviceUpdatePage extends StatefulWidget {
  const DeviceUpdatePage({super.key});
  static const nameRoute = "/device-update";

  @override
  State<DeviceUpdatePage> createState() => _DeviceUpdatePageState();
}

class _DeviceUpdatePageState extends State<DeviceUpdatePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameCtl = TextEditingController();
  final TextEditingController _descCtl = TextEditingController();
  final TextEditingController _serialCtl = TextEditingController();
  final TextEditingController _manufacturerCtl = TextEditingController();
  final TextEditingController _specCtl = TextEditingController();
  final TextEditingController _imageCtl = TextEditingController();

  int? _selectedTypeId;
  bool _isActive = true;
  bool _isAvailable = true;
  bool _isLoading = true;
  bool _isSubmitting = false;

  late String deviceId;

  final List<Map<String, dynamic>> deviceTypes = [
    {'id': 1, 'name': 'UWB unit'},
    {'id': 2, 'name': 'Tablet'},
    {'id': 3, 'name': 'Camera'},
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    deviceId = args is String ? args : args?.toString() ?? 'unknown';
    fetchDeviceInfo();
  }

  Future<void> fetchDeviceInfo() async {
    try {
      final deviceService = Provider.of<DeviceService>(context, listen: false);
      final data = await deviceService.fetchInfoDevice(deviceId);
      setState(() {
        _nameCtl.text = data['device_name'] ?? '';
        _descCtl.text = data['description'] ?? '';
        _serialCtl.text = data['serial'] ?? '';
        _manufacturerCtl.text = data['manufacturer'] ?? '';
        _specCtl.text = data['specification'] ?? '';
        _imageCtl.text = data['image'] ?? '';
        _selectedTypeId = data['type_id'];
        _isActive = data['is_active'] ?? true;
        _isAvailable = data['is_available'] ?? true;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lỗi tải thông tin thiết bị: $e')));
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);

    try {
      final deviceService = Provider.of<DeviceService>(context, listen: false);
      await deviceService.updateDevice(
        deviceId,
        {
          'device_name': _nameCtl.text,
          'description': _descCtl.text,
          'serial': _serialCtl.text,
          'manufacturer': _manufacturerCtl.text,
          'specification': _specCtl.text,
          'image': _imageCtl.text,
          'type_id': _selectedTypeId,
          'is_active': _isActive,
          'is_available': _isAvailable,
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cập nhật thành công')));
      Navigator.pop(context, true); // Trả về kết quả thành công
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lỗi cập nhật: $e')));
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cập nhật thiết bị'),
        leading: BackButton(onPressed: () => Navigator.pop(context)),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameCtl,
                decoration: const InputDecoration(labelText: 'Tên thiết bị'),
                validator: (v) => v == null || v.isEmpty ? 'Không được bỏ trống' : null,
              ),
              TextFormField(
                controller: _descCtl,
                decoration: const InputDecoration(labelText: 'Mô tả'),
              ),
              TextFormField(
                controller: _serialCtl,
                decoration: const InputDecoration(labelText: 'Serial'),
              ),
              TextFormField(
                controller: _manufacturerCtl,
                decoration: const InputDecoration(labelText: 'Hãng sản xuất'),
              ),
              TextFormField(
                controller: _specCtl,
                decoration: const InputDecoration(labelText: 'Thông số kỹ thuật'),
              ),
              // DropdownButtonFormField<int>(
              //   value: _selectedTypeId,
              //   items: deviceTypes
              //       .map((e) => DropdownMenuItem<int>(
              //     value: e['id'] as int,
              //     child: Text(e['name'] as String),
              //   ))
              //       .toList(),
              //   decoration: const InputDecoration(labelText: 'Loại thiết bị'),
              //   onChanged: (v) => setState(() => _selectedTypeId = v),
              //   validator: (v) => v == null ? 'Chọn loại thiết bị' : null,
              // ),
              TextFormField(
                controller: _imageCtl,
                decoration: const InputDecoration(labelText: 'Đường dẫn ảnh'),
              ),
              SwitchListTile(
                title: const Text('Đang hoạt động'),
                value: _isActive,
                onChanged: (v) => setState(() => _isActive = v),
              ),
              SwitchListTile(
                title: const Text('Sẵn sàng cho mượn'),
                value: _isAvailable,
                onChanged: (v) => setState(() => _isAvailable = v),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const SizedBox(
                    height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Cập nhật'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
