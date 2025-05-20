import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwb_positioning/models/device.dart';
import 'package:uwb_positioning/pages/borrow_request_page.dart';
import 'package:uwb_positioning/pages/device_realtime_page.dart';
import 'package:uwb_positioning/pages/device_history_page.dart';
import 'package:uwb_positioning/pages/device_update_page.dart';
import 'package:uwb_positioning/services/auth_service.dart';
import 'package:uwb_positioning/services/device_service.dart';

class DeviceDetailPage extends StatefulWidget {
  const DeviceDetailPage({super.key});
  static const nameRoute = '/Detail';

  @override
  State<DeviceDetailPage> createState() => _DeviceDetailPageState();
}

class _DeviceDetailPageState extends State<DeviceDetailPage> {
  late Future<void> _deviceDetailFuture;
  late String deviceId;
  late DeviceService deviceService;
  Device? _device;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    deviceId = ModalRoute.of(context)!.settings.arguments as String;
    deviceService = Provider.of<DeviceService>(context, listen: false);
    _fetchDeviceDetail();
  }

  void _fetchDeviceDetail() {
    _deviceDetailFuture = deviceService.fetchInfoDevice(deviceId).then((data) {
      final device = Device.createDevice(data);
      _device = device;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('[DEBUG] build: Device Detail');
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Device Detail"),
      ),
      body: FutureBuilder(
        future: _deviceDetailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            // final device = deviceService.devices[deviceId];
            final device = _device;
            return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        device!.image,
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Text(
                          device.deviceName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        device.description,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Manufacturer',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        device.manufacturer,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Serial Number',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        device.serial,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Specification',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        device.specification,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Status',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        device.isActive ? 'Active' : 'Inactive',
                        style: TextStyle(
                          fontSize: 18,
                          color: device.isActive ? Colors.green : Colors.red,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Availability',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        device.isAvailable ? 'Available' : 'Not Available',
                        style: TextStyle(
                          fontSize: 18,
                          color: device.isAvailable ? Colors.green : Colors.red,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  DeviceRealtimePage.nameRoute,
                                  arguments: device.deviceId,
                                );
                              },
                              child: const Text('View Real-Time Location'),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  DeviceHistoryPage.nameRoute,
                                  arguments: device.deviceId,
                                );
                              },
                              child: const Text('View Location History'),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                if (authProvider.user?.role == 'admin') {
                                  Navigator.pushNamed(
                                    context,
                                    DeviceUpdatePage.nameRoute,
                                    arguments: device.deviceId,
                                  ).then((_) {
                                    // Sau khi sửa xong quay lại thì fetch lại
                                    setState(() {
                                      _fetchDeviceDetail();
                                    });
                                  });
                                } else {
                                  Navigator.pushNamed(
                                    context,
                                    BorrowRequestPage.nameRoute,
                                    arguments: device.deviceId,
                                  );
                                }
                              },
                              child: Text(
                                authProvider.user?.role == 'admin'
                                    ? 'Change Infomation'
                                    : 'Create Borrow Request',
                              ),
                            ),
                          ],
                        ),
                      )
                    ]));
          }
        },
      ),
    );
  }
}
