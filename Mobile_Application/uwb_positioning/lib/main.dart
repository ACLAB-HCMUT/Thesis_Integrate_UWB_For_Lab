import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:logging/logging.dart';
import 'package:uwb_positioning/pages/admin_home_page.dart';

import 'package:uwb_positioning/pages/device_list_page.dart';
import 'package:uwb_positioning/pages/device_detail_page.dart';
import 'package:uwb_positioning/pages/device_realtime_page.dart';
import 'package:uwb_positioning/pages/device_update_page.dart';
import 'package:uwb_positioning/pages/notification_list_page.dart';
import 'package:uwb_positioning/pages/device_history_page.dart';
import 'package:uwb_positioning/pages/device_history_text_page.dart';
import 'package:uwb_positioning/pages/borrow_request_page.dart';
import 'package:uwb_positioning/pages/login_page.dart';
import 'package:uwb_positioning/pages/user_list_page.dart';
import 'package:uwb_positioning/pages/user_update_page.dart';
import 'package:uwb_positioning/pages/user_create_page.dart';
import 'package:uwb_positioning/pages/borrow_request_manage_page.dart';

import 'package:uwb_positioning/services/alert_service.dart';
import 'package:uwb_positioning/services/device_service.dart';
import 'package:uwb_positioning/services/device_location_service.dart';
import 'package:uwb_positioning/services/mqtt_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  Logger.root.level = Level.ALL; // Log all levels (DEBUG, INFO, WARNING, ERROR)
  Logger.root.onRecord.listen((record) {
    print(
        '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
  });

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => DeviceService()),
    ChangeNotifierProvider(create: (_) => DeviceLocationService()),
    Provider<GlobalKey<NavigatorState>>(create: (_) => navigatorKey),
    ChangeNotifierProvider(create: (_) => AlertService(navigatorKey)),
    ChangeNotifierProvider(
        create: (_) =>
            MqttService(navigatorKey: navigatorKey)..connectAndSubscribe()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey, // Add navigatorKey
      home: const DeviceListPage(),
      routes: {
        DeviceDetailPage.nameRoute: (context) => const DeviceDetailPage(),
        DeviceRealtimePage.nameRoute: (context) => const DeviceRealtimePage(),
        DeviceHistoryPage.nameRoute: (context) => const DeviceHistoryPage(),
        DeviceHistoryTextPage.nameRoute: (context) =>
            const DeviceHistoryTextPage(),
        NotificationListPage.nameRoute: (context) =>
            const NotificationListPage(),
        BorrowRequestPage.nameRoute: (context) => const BorrowRequestPage(),
        // Các page mới thêm:
        '/login': (context) => const LoginPage(),
        '/users': (context) => const UserListPage(),
        '/user/update': (context) => const UserUpdatePage(),
        '/user/create': (context) => const UserCreatePage(),
        '/borrow_request_manage': (context) => const BorrowRequestManagePage(),
        '/admin_home': (context) => const AdminHomePage(),
        '/device/update': (context) => const DeviceUpdatePage(),
      },
      title: 'UWB Device Manager',
      theme: ThemeData.light(),
    );
  }
}
