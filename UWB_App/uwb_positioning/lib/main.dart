import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:logging/logging.dart';
import 'package:uwb_positioning/pages/device_list_page.dart';
import 'package:uwb_positioning/pages/device_detail_page.dart';
import 'package:uwb_positioning/pages/device_realtime_page.dart';
import 'package:uwb_positioning/pages/notification_list_page.dart';
import 'package:uwb_positioning/services/alert_service.dart';
import 'package:uwb_positioning/services/mqtt_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  Logger.root.level = Level.ALL; // Log all levels (DEBUG, INFO, WARNING, ERROR)
  Logger.root.onRecord.listen((record) {
    print(
        '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
  });

  runApp(MultiProvider(providers: [
    Provider<GlobalKey<NavigatorState>>(create: (_) => navigatorKey),
    ChangeNotifierProvider(create: (_) => AlertService(navigatorKey)),
    ChangeNotifierProvider(create: (_) => MqttService(navigatorKey: navigatorKey)..connectAndSubscribe()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey, // Thêm navigatorKey
      home: const DeviceListPage(),
      routes: {
        DeviceDetailPage.nameRoute: (context) => const DeviceDetailPage(),
        DeviceRealtimePage.nameRoute: (context) => const DeviceRealtimePage(),
        NotificationListPage.nameRoute: (context) => const NotificationListPage(),
      },
      title: 'UWB Device Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
