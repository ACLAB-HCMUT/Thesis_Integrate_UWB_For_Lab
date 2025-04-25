import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwb_positioning/services/device_location_service.dart';

class DeviceHistoryTextPage extends StatefulWidget {
  const DeviceHistoryTextPage({super.key});
  static const nameRoute = '/HistoryText';

  @override
  State<DeviceHistoryTextPage> createState() => _DeviceHistoryTextPageState();
}

class _DeviceHistoryTextPageState extends State<DeviceHistoryTextPage> {
  bool isDailyView = false; // Chế độ xem theo ngày hay theo giờ

  late Future<void> _deviceHistoryFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;
    final deviceId = args is String ? args : args?.toString() ?? 'unknown';

    // Mặc định là chế độ xem theo giờ
    _deviceHistoryFuture =
        Provider.of<DeviceLocationService>(context, listen: false)
            .fetchHistoryHourly(deviceId);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final deviceId = args is String ? args : args?.toString() ?? 'unknown';
    final deviceLocationService = Provider.of<DeviceLocationService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(isDailyView ? 'Text Daily History' : 'Text Hourly History'),
        actions: [
          IconButton(
            icon: Icon(isDailyView ? Icons.calendar_today : Icons.access_time),
            onPressed: () {
              setState(() {
                isDailyView = !isDailyView; // Chuyển đổi chế độ xem
                if (isDailyView) {
                  _deviceHistoryFuture =
                      deviceLocationService.fetchHistoryDaily(deviceId);
                } else {
                  _deviceHistoryFuture =
                      deviceLocationService.fetchHistoryHourly(deviceId);
                }
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: _deviceHistoryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            final deviceData = isDailyView
                ? deviceLocationService.deviceLocsDaily
                : deviceLocationService.deviceLocs;

            return ListView.builder(
              itemCount: deviceData.length,
              itemBuilder: (context, index) {
                final device = deviceData.values.toList()[index];

                // Chuyển thông tin thiết bị thành text để hiển thị
                return ListTile(
                  title: Text('Device ID: $deviceId'),
                  subtitle: Text(
                    'Location: (${device.tagX}, ${device.tagY}, ${device.tagZ})\n'
                    'Time: ${device.recordTime}\n'
                    'Record Type: ${device.recordType}',
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
