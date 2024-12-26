import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwb_positioning/pages/device_detail_page.dart';
import 'package:uwb_positioning/pages/notification_list_page.dart';
import 'package:uwb_positioning/services/mqtt_service.dart';

class DeviceListPage extends StatefulWidget {
  const DeviceListPage({super.key});

  @override
  State<DeviceListPage> createState() => _DeviceListPageState();
}

class _DeviceListPageState extends State<DeviceListPage> {
  @override
  Widget build(BuildContext context) {
    final mqttService = Provider.of<MqttService>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Device List"),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              tooltip: "Notifications",
              onPressed: () {
                Navigator.pushNamed(context, NotificationListPage.nameRoute);
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: mqttService.deviceData.length,
          itemBuilder: (context, index) {
            final deviceId = mqttService.deviceData.keys.elementAt(index);

            return ListTile(
              leading: const Icon(Icons.online_prediction),
              title: Text('Device ID: $deviceId'),
              trailing: const Icon(Icons.public),
              onTap: () {
                Navigator.pushNamed(context, DeviceDetailPage.nameRoute,
                    arguments: deviceId);
              },
            );
          },
        ));
  }
}
