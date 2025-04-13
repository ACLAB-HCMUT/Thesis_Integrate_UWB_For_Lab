import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwb_positioning/pages/device_realtime_page.dart';
import 'package:uwb_positioning/pages/device_history_page.dart';
import 'package:uwb_positioning/services/device_service.dart';

class DeviceDetailPage extends StatefulWidget {
  const DeviceDetailPage({super.key});
  static const nameRoute = '/Detail';

  @override
  State<DeviceDetailPage> createState() => _DeviceDetailPageState();
}

class _DeviceDetailPageState extends State<DeviceDetailPage> {
  late Future<void> _deviceDetailFuture;

  @override
  Widget build(BuildContext context) {
    final deviceId = ModalRoute.of(context)!.settings.arguments as String;
    final deviceService = Provider.of<DeviceService>(context);

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
            final device = deviceService.devices[deviceId];

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
                          ],
                        ),
                      )
                    ]));
          }
        },
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final deviceId = ModalRoute.of(context)!.settings.arguments as String;
    final deviceService = Provider.of<DeviceService>(context, listen: false);
    _deviceDetailFuture = deviceService.fetchDeviceDetail(deviceId);
  }
}
