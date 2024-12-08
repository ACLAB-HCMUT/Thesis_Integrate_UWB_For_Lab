import 'package:flutter/material.dart';
import 'package:uwb_positioning/pages/device_realtime_page.dart';

class DeviceDetailPage extends StatefulWidget {
  const DeviceDetailPage({super.key});
  static const nameRoute = '/Detail';

  @override
  State<DeviceDetailPage> createState() => _DeviceDetailPageState();
}

class _DeviceDetailPageState extends State<DeviceDetailPage> {
  @override
  Widget build(BuildContext context) {
    final deviceId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Device Detail"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, DeviceRealtimePage.nameRoute,
                    arguments: deviceId);
              },
              child: const Text('View Real-time Position'))
        ],
      ),
    );
  }
}
