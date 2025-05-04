import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:logging/logging.dart';
// import 'package:shared_preferences/shared_preferences.dart';
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
import 'package:uwb_positioning/pages/user_home_page.dart';
import 'package:uwb_positioning/pages/user_list_page.dart';
import 'package:uwb_positioning/pages/user_update_page.dart';
import 'package:uwb_positioning/pages/user_create_page.dart';
import 'package:uwb_positioning/pages/borrow_request_manage_page.dart';

import 'package:uwb_positioning/services/alert_service.dart';
import 'package:uwb_positioning/services/auth_service.dart';
import 'package:uwb_positioning/services/device_service.dart';
import 'package:uwb_positioning/services/device_location_service.dart';
import 'package:uwb_positioning/services/mqtt_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  Logger.root.level = Level.ALL; // Log all levels (DEBUG, INFO, WARNING, ERROR)
  Logger.root.onRecord.listen((record) {
    print(
        '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
  });


  // final prefs = await SharedPreferences.getInstance();
  // final token = prefs.getString('token');
  // final role = prefs.getString('role');

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProxyProvider<AuthProvider, DeviceService>(
      create: (context) => DeviceService(context.read<AuthProvider>()),
      update: (context, userProv, previous) => DeviceService(userProv),
    ),
    ChangeNotifierProxyProvider<AuthProvider, AuthService>(
      create: (context) => AuthService(context.read<AuthProvider>()),
      update: (context, userProv, previous) => AuthService(userProv),
    ),
    ChangeNotifierProvider(create: (_) => DeviceLocationService()),
    Provider<GlobalKey<NavigatorState>>(create: (_) => navigatorKey),
    ChangeNotifierProvider(create: (_) => AlertService(navigatorKey)),
    ChangeNotifierProvider(
        create: (_) =>
            MqttService(navigatorKey: navigatorKey)..connectAndSubscribe()),
  ],
      child: const MyApp()));
  //   child: MyApp(initialRoute: token != null
  // ? (role == 'admin' ? AdminHomePage.nameRoute : '/users')
  // : '/login'),
  // ),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // final String initialRoute;

  // const MyApp({super.key, required this.initialRoute});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey, // Add navigatorKey
      home: const LoginPage(),
      // initialRoute: initialRoute,

      routes: {
        DeviceListPage.nameRoute:(context) => const DeviceListPage(),
        DeviceDetailPage.nameRoute: (context) => const DeviceDetailPage(),
        DeviceRealtimePage.nameRoute: (context) => const DeviceRealtimePage(),
        DeviceHistoryPage.nameRoute: (context) => const DeviceHistoryPage(),
        DeviceHistoryTextPage.nameRoute: (context) =>
            const DeviceHistoryTextPage(),
        NotificationListPage.nameRoute: (context) =>
            const NotificationListPage(),
        BorrowRequestPage.nameRoute: (context) => const BorrowRequestPage(),
        // Các page mới thêm:
        LoginPage.nameRoute: (context) => const LoginPage(),
        '/users': (context) => const UserListPage(),
        '/user/update': (context) => const UserUpdatePage(),
        '/user/create': (context) => const UserCreatePage(),
        '/borrow_request_manage': (context) => const BorrowRequestManagePage(),
        UserHomePage.nameRoute: (context) => const UserHomePage(),
        AdminHomePage.nameRoute: (context) => const AdminHomePage(),
        '/device/update': (context) => const DeviceUpdatePage(),
      },
      title: 'UWB Device Manager',
      theme: ThemeData.light(),
    );
  }
}
