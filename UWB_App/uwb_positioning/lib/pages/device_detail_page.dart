import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwb_positioning/models/device.dart';
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
                // } else if (snapshot.hasError) {
                //   return Center(
                //       child: Text('An error occurred: ${snapshot.error}'));
                // } else if (!snapshot.hasData) {
                //   return const Center(
                //       child: Text('Device information not found'));
              } else {
                final device = deviceService.devices[deviceId];

                return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tên thiết bị: ${device!.deviceName}',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Mô tả: ${device.description}',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Vị trí: ${device.serial}',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, DeviceRealtimePage.nameRoute,
                                  arguments: device
                                      .deviceId); // Truyền deviceId cho trang real-time
                            },
                            child: const Text('View real-time location'),
                          ),
                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, DeviceHistoryPage.nameRoute,
                                  arguments: device
                                      .deviceId); // Truyền deviceId cho trang real-time
                            },
                            child: const Text('View location history'),
                          ),
                        ]));
              }
            }));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final deviceId = ModalRoute.of(context)!.settings.arguments as String;
    final deviceService = Provider.of<DeviceService>(context, listen: false);
    _deviceDetailFuture = deviceService.fetchDeviceDetail(deviceId);
  }
}
