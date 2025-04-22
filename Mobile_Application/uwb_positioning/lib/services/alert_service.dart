import 'package:flutter/material.dart';

class AlertService with ChangeNotifier {
  final GlobalKey<NavigatorState> navigatorKey;

  AlertService(this.navigatorKey);
  void showAlert(String message) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

// import 'package:flutter/material.dart';
//
// class AlertService with ChangeNotifier {
//   final GlobalKey<NavigatorState> navigatorKey;
//
//   AlertService(this.navigatorKey);
//
//   void showAlert(String message) {
//     final context = navigatorKey.currentContext;
//     if (context != null) {
//       // Trì hoãn để đảm bảo MaterialApp đã được dựng
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         showDialog(
//           context: context,
//           barrierDismissible: true, // Ngăn người dùng tương tác với background
//           builder: (context) {
//             return Dialog(
//               backgroundColor: Colors.transparent,
//               child: Stack(
//                 children: [
//                   Positioned(
//                     top: 0,
//                     left: 0,
//                     right: 0,
//                     child: Material(
//                       color: Colors.transparent,
//                       child: Container(
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color: Colors.red,
//                           borderRadius: BorderRadius.circular(8),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.2),
//                               blurRadius: 10,
//                               offset: const Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: Text(
//                           message,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ).then((_) {
//           // Đóng Dialog sau 3 giây
//           Future.delayed(const Duration(seconds: 3), () {
//             Navigator.of(context).pop();
//           });
//         });
//       });
//     }
//   }
// }

