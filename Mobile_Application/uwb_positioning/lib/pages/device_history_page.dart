import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwb_positioning/components/grid_multi_point_painter.dart';
import 'package:uwb_positioning/pages/device_history_text_page.dart';
import 'package:uwb_positioning/models/device_location.dart';
import 'package:uwb_positioning/models/anchor.dart';
import 'package:uwb_positioning/services/device_location_service.dart';

class DeviceHistoryPage extends StatefulWidget {
  const DeviceHistoryPage({super.key});
  static const nameRoute = '/History';

  @override
  State<DeviceHistoryPage> createState() => _DeviceHistoryPageState();
}

class _DeviceHistoryPageState extends State<DeviceHistoryPage> {
  Map<String, Anchor> anchorData = {};
  Map<String, DeviceLocation> tagData = {};
  double _scale = 1.0;
  Offset _gridOffset = Offset.zero;

  late Future<void> _deviceHistoryFuture;

  bool isDailyView = false;

  @override
  Widget build(BuildContext context) {
    final deviceId = ModalRoute.of(context)!.settings.arguments as String;
    final deviceLocationService = Provider.of<DeviceLocationService>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(isDailyView ? 'Map Daily History' : 'Map Hourly History'),
          actions: [
            IconButton(
              icon:
                  Icon(isDailyView ? Icons.calendar_today : Icons.access_time),
              onPressed: () {
                setState(() {
                  isDailyView = !isDailyView; // Switch view
                  // Reload the corresponding data
                  if (isDailyView) {
                    _deviceHistoryFuture =
                        deviceLocationService.fetchHistoryDaily();
                  } else {
                    _deviceHistoryFuture =
                        deviceLocationService.fetchHistoryHourly();
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
                final anchorData =
                    deviceLocationService.anchorLocs; // Lấy dữ liệu anchor
                final tagData = isDailyView
                    ? deviceLocationService.deviceLocsDaily // Dữ liệu theo ngày
                    : deviceLocationService.deviceLocs;

                print('anchor: ${anchorData}');
                print('tag: ${tagData}');

                return GestureDetector(
                  onScaleUpdate: (details) {
                    setState(() {
                      // Adjust zoom ratio
                      _scale = (_scale * details.scale).clamp(0.2, 2.0);

                      // Adjust the moving grid
                      _gridOffset += details.focalPointDelta;
                    });
                  },
                  child: CustomPaint(
                    size: Size(double.infinity, double.infinity),
                    painter: GridMultiPointPainter(
                      anchorPoints: anchorData,
                      tagPoints: tagData,
                      scale: _scale,
                      gridOffset: _gridOffset,
                    ),
                  ),
                );
              }
            }),
        bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.map),
                  onPressed: () {
                    // Ở đây, bạn không cần làm gì vì hiện tại bạn đã ở trong trang này
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.list),
                  onPressed: () {
                    // Chuyển sang màn hình lịch sử dạng văn bản
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DeviceHistoryTextPage()),
                    );
                  },
                ),
              ],
            )));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final deviceId = ModalRoute.of(context)!.settings.arguments as String;
    final deviceLocationService =
        Provider.of<DeviceLocationService>(context, listen: false);
    _deviceHistoryFuture = deviceLocationService.fetchHistoryHourly();
  }
}
