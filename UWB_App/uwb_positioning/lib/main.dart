import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:logging/logging.dart';
import 'package:uwb_positioning/pages/device_list_page.dart';
import 'package:uwb_positioning/pages/device_detail_page.dart';
import 'package:uwb_positioning/pages/device_realtime_page.dart';
import 'package:uwb_positioning/pages/device_history_page.dart';
import 'package:uwb_positioning/pages/device_history_text_page.dart';

import 'package:uwb_positioning/services/device_service.dart';
import 'package:uwb_positioning/services/device_location_service.dart';

import 'package:uwb_positioning/services/mqtt_service.dart';

void main() {
  Logger.root.level = Level.ALL; // Log all levels (DEBUG, INFO, WARNING, ERROR)
  Logger.root.onRecord.listen((record) {
    print(
        '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
  });

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => DeviceService()),
    ChangeNotifierProvider(create: (_) => DeviceLocationService()),
    ChangeNotifierProvider(create: (_) => MqttService()..connectAndSubscribe()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const DeviceListPage(),
      routes: {
        DeviceDetailPage.nameRoute: (context) => const DeviceDetailPage(),
        DeviceRealtimePage.nameRoute: (context) => const DeviceRealtimePage(),
        DeviceHistoryPage.nameRoute: (context) => const DeviceHistoryPage(),
        DeviceHistoryTextPage.nameRoute: (context) => const DeviceHistoryTextPage(),
      },
      title: 'UWB Device Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
