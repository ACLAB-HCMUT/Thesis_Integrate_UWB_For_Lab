class AppNotification {
  final int notifyId;
  final String description;
  final bool isRead;
  final DateTime notifyTime;
  final String type;

  AppNotification({
    required this.notifyId,
    required this.description,
    required this.isRead,
    required this.notifyTime,
    required this.type,
  });

  AppNotification copyWith({
    int? notifyId,
    String? description,
    bool? isRead,
    DateTime? notifyTime,
    String? type,
  }) {
    return AppNotification(
      notifyId: notifyId ?? this.notifyId,
      description: description ?? this.description,
      isRead: isRead ?? this.isRead,
      notifyTime: notifyTime ?? this.notifyTime,
      type: type ?? this.type,
    );
  }

  // Hàm tạo từ Map (JSON -> Object)
  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      notifyId: json['notify_id'] as int,
      description: json['description'] as String,
      isRead: json['is_read'] as bool,
      notifyTime: DateTime.parse(json['notify_time'] as String),
      type: json['type'] as String,
    );
  }

  // Chuyển Object thành Map (Object -> JSON)
  Map<String, dynamic> toJson() {
    return {
      'notify_id': notifyId,
      'description': description,
      'is_read': isRead,
      'notify_time': notifyTime.toIso8601String(),
      'type': type,
    };
  }
}