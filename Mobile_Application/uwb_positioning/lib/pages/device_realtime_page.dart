import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwb_positioning/components/grid_point_painter.dart';
import 'package:uwb_positioning/services/mqtt_service.dart';

class DeviceRealtimePage extends StatefulWidget {
  const DeviceRealtimePage({super.key});
  static const nameRoute = '/Realtime';

  @override
  State<DeviceRealtimePage> createState() => _DeviceRealtimePageState();
}

class _DeviceRealtimePageState extends State<DeviceRealtimePage> {
  Map<String, Map<String, dynamic>> anchorData = {};
  Map<String, dynamic> tagData = {};
  double _scale = 1.0;
  Offset _gridOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final deviceId = args is String ? args : args?.toString() ?? 'unknown';

    return Consumer<MqttService>(builder: (context, mqttService, child) {
      // Check number of anchors
      if (!mqttService.hasAtLeastThreeAnchors()) {
        return const Center(
          child: Text('Not enough anchors available (at least 3 required)'),
        );
      }

      // Get device data from MqttService
      final deviceData = mqttService.deviceData[deviceId];
      if (deviceData == null) {
        return const Text('No real-time data available');
      }

      return Scaffold(
        appBar: AppBar(title: const Text('Device Real-time Position')),
        body: Center(
          child: GestureDetector(
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
              painter: GridPointPainter(
                anchorPoints: mqttService.anchorData,
                tagPoints: deviceData,
                scale: _scale,
                gridOffset: _gridOffset,
              ),
            ),
          ),
        ),
      );
    });
  }
}
