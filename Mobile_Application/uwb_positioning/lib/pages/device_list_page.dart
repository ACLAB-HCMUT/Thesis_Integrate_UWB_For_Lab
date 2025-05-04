import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwb_positioning/pages/device_detail_page.dart';
import 'package:provider/provider.dart';
import 'package:uwb_positioning/pages/notification_list_page.dart';
import 'package:uwb_positioning/services/auth_service.dart';
import 'package:uwb_positioning/services/device_service.dart';

class DeviceListPage extends StatefulWidget {
  const DeviceListPage({super.key});
  static const nameRoute = '/devices';
  @override
  State<DeviceListPage> createState() => _DeviceListPageState();
}

class _DeviceListPageState extends State<DeviceListPage> {
  @override
  Widget build(BuildContext context) {
    final deviceService = Provider.of<DeviceService>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Device List"),
          leading: BackButton(onPressed: () => Navigator.pop(context)),
          // actions: [
          //   // Hiển thị tên người dùng trong AppBar
          //   user != null
          //       ? Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Text(user.name),  // Hiển thị tên người dùng
          //   )
          //       : Container(), // Nếu chưa có người dùng thì không hiển thị gì
          // ],
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.notifications),
          //     tooltip: "Notifications",
          //     onPressed: () {
          //       Navigator.pushNamed(context, NotificationListPage.nameRoute);
          //     },
          //   ),
          // ],
        ),
        body: FutureBuilder(
            future: deviceService.fetchDeviceGeneral(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (deviceService.devices.isEmpty) {
                return const Center(child: Text('There are no devices'));
              } else {
                final devices = deviceService.devices;

                return ListView.builder(
                    itemCount: devices.length,
                    itemBuilder: (context, index) {
                      final deviceId = devices.keys.elementAt(index);
                      final device = devices[deviceId]!;

                      return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              DeviceDetailPage.nameRoute,
                              arguments: deviceId,
                            );
                          },
                          child: Container(
                            height: 100,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ), // Add space around
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .cardColor, // Background color
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 5.0,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                  child: Image.network(
                                    device.image,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        device.deviceName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: device.isActive
                                              ? Colors.black
                                              : Colors.grey,
                                        ),
                                      ),
                                      Text('Device ID: $deviceId',
                                          style: TextStyle(
                                            color: device.isActive
                                                ? Colors.black
                                                : Colors.grey,
                                          )),
                                      Text(
                                        device.isActive
                                            ? (device.isInRoom
                                                ? 'In Room'
                                                : 'Out of Room')
                                            : 'Inactive',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: device.isActive
                                              ? (device.isInRoom
                                                  ? Colors.green
                                                  : Colors.red)
                                              : Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ));
                    });
              }
            }));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Check for updates every time you reopen the screen
    final deviceService = Provider.of<DeviceService>(context, listen: false);
    deviceService.checkAndFetchUpdates();
  }
}
