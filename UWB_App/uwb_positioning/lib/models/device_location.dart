class DeviceLocation {
  final int deviceRecId;
  final int deviceId;
  final double tagX;
  final double tagY;
  final double tagZ;
  final int an1RecId;
  final int an2RecId;
  final int an3RecId;
  final int an4RecId;
  final DateTime recordTime;
  final String recordType;

  DeviceLocation({
    required this.deviceRecId,
    required this.deviceId,
    required this.tagX,
    required this.tagY,
    required this.tagZ,
    required this.an1RecId,
    required this.an2RecId,
    required this.an3RecId,
    required this.an4RecId,
    required this.recordTime,
    required this.recordType,
  });

  // Method to convert from JSON to DeviceLocation object
  factory DeviceLocation.fromJson(Map<String, dynamic> json) {
    return DeviceLocation(
      deviceRecId: json['devicerec_id'],
      deviceId: json['device_id'],
      tagX: json['tag_x'],
      tagY: json['tag_y'],
      tagZ: json['tag_z'],
      an1RecId: json['an1rec_id'],
      an2RecId: json['an2rec_id'],
      an3RecId: json['an3rec_id'],
      an4RecId: json['an4rec_id'],
      recordTime: DateTime.parse(json['record_time']),
      recordType: json['record_type'],
    );
  }

  // Method to convert from DeviceLocation object to JSON
  Map<String, dynamic> toJson() {
    return {
      'devicerec_id': deviceRecId,
      'device_id': deviceId,
      'tag_x': tagX,
      'tag_y': tagY,
      'tag_z': tagZ,
      'an1rec_id': an1RecId,
      'an2rec_id': an2RecId,
      'an3rec_id': an3RecId,
      'an4rec_id': an4RecId,
      'record_time': recordTime.toIso8601String(),
      'record_type': recordType,
    };
  }
}
