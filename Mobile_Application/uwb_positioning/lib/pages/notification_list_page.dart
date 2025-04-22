import 'package:flutter/material.dart';
import 'package:uwb_positioning/models/notification.dart';
import 'package:intl/intl.dart';
import 'package:uwb_positioning/pages/notification_detail_page.dart';

class NotificationListPage extends StatefulWidget {
  const NotificationListPage({Key? key}) : super(key: key);
  static const String nameRoute = '/NotificationList';

  @override
  State<NotificationListPage> createState() => _NotificationListPageState();
}

class _NotificationListPageState extends State<NotificationListPage> {
  // Danh sách thông báo mẫu
  final List<AppNotification> _notifications = [
    AppNotification(
      description: 'Tag 1 is not in the correct position',
      isRead: false,
      notifyTime: DateTime.parse('2024-12-24T13:29:30+07:00'),
      type: 'warning',
    ),
    AppNotification(
      description: 'Device disconnected',
      isRead: true,
      notifyTime: DateTime.parse('2024-12-23T10:15:00+07:00'),
      type: 'update',
    ),
    AppNotification(
      description: 'New firmware update available',
      isRead: false,
      notifyTime: DateTime.parse('2024-12-22T09:45:00+07:00'),
      type: 'update',
    ),
    AppNotification(
      description: 'New firmware update available',
      isRead: false,
      notifyTime: DateTime.parse('2024-12-22T09:45:00+07:00'),
      type: 'update',
    ),
  ];

  // Đánh dấu thông báo là đã đọc
  void _markAsRead(int index) {
    setState(() {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
    });
  }

  // Xóa thông báo
  void _deleteNotification(int index) {
    setState(() {
      _notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification List'),
      ),
      body: _notifications.isEmpty
          ? const Center(
              child: Text(
                'No notification available',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            )
          : ListView.builder(
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 3,
                  child: ListTile(
                    leading: Icon(
                      notification.type == 'warning'
                          ? Icons.warning
                          : Icons.info,
                      color: notification.type == 'warning'
                          ? Colors.yellow
                          : Colors.blue,
                    ),
                    title: Text(
                      notification.type == 'warning'
                          ? 'Warning'
                          : 'Notification',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: notification.isRead ? Colors.grey : Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMMd()
                          .add_jms()
                          .format(notification.notifyTime),
                      style: const TextStyle(fontSize: 12),
                    ),
                    onTap: () {
                      // Mark the notification as read when tapped
                      _markAsRead(index);
                      // Navigate to detail page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationDetailPage(
                            notification: notification,
                          ),
                        ),
                      );
                    },
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'mark_as_read') {
                          _markAsRead(index);
                        } else if (value == 'delete') {
                          _deleteNotification(index);
                        }
                      },
                      itemBuilder: (context) => [
                        if (!notification.isRead)
                          const PopupMenuItem(
                            value: 'mark_as_read',
                            child: Text('Mark as Read'),
                          ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
