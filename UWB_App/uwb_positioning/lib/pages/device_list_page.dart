import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwb_positioning/pages/device_detail_page.dart';
import 'package:uwb_positioning/pages/notification_list_page.dart';
import 'package:uwb_positioning/services/device_service.dart';

class DeviceListPage extends StatefulWidget {
  const DeviceListPage({super.key});

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
                              horizontal: 10,
                              vertical: 5,
                            ), // Add space around
                            decoration: BoxDecoration(
                              color: Colors.grey[200], // Background color
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.3), // Shadow color
                                  blurRadius: 5, // Glossiness
                                  offset: const Offset(0, 3), // Shadow position
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
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text('Device ID: $deviceId'),
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
