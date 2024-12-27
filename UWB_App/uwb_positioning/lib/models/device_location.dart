class DeviceLocation {
  final double tagX;
  final double tagY;
  final double tagZ;
  final DateTime recordTime;
  final String recordType;
  final String roomId;

  DeviceLocation({
    required this.tagX,
    required this.tagY,
    required this.tagZ,
    required this.recordTime,
    required this.recordType,
    required this.roomId,
  });

  // Method to convert from JSON to DeviceLocation object
  factory DeviceLocation.fromJson(Map<String, dynamic> json) {
    return DeviceLocation(
      tagX: json['tag_x'].toDouble(),
      tagY: json['tag_y'].toDouble(),
      tagZ: json['tag_z'].toDouble(),
      recordTime: DateTime.parse(json['record_time']),
      recordType: json['record_type'],
      roomId: json['room_id'],
    );
  }

  // Method to convert from DeviceLocation object to JSON
  Map<String, dynamic> toJson() {
    return {
      'tag_x': tagX,
      'tag_y': tagY,
      'tag_z': tagZ,
      'record_time': recordTime.toIso8601String(),
      'record_type': recordType,
      'room_id': roomId,
    };
  }
}
