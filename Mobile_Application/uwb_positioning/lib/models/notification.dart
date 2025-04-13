class AppNotification {
  final String description;
  final bool isRead;
  final DateTime notifyTime;
  final String type;

  AppNotification({
    required this.description,
    required this.isRead,
    required this.notifyTime,
    required this.type,
  });

  AppNotification copyWith({
    String? description,
    bool? isRead,
    DateTime? notifyTime,
    String? type,
  }) {
    return AppNotification(
      description: description ?? this.description,
      isRead: isRead ?? this.isRead,
      notifyTime: notifyTime ?? this.notifyTime,
      type: type ?? this.type,
    );
  }

  // Hàm tạo từ Map (JSON -> Object)
  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      description: json['description'] as String,
      isRead: json['is_read'] as bool,
      notifyTime: DateTime.parse(json['notify_time'] as String),
      type: json['type'] as String,
    );
  }

  // Chuyển Object thành Map (Object -> JSON)
  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'is_read': isRead,
      'notify_time': notifyTime.toIso8601String(),
      'type': type,
    };
  }
}