class Anchor {
  final String anchorRecId;
  final int anchorId;
  final double anchorX;
  final double anchorY;
  final double anchorZ;
  final DateTime recordTime;
  final String roomNumber;

  Anchor({
    required this.anchorRecId,
    required this.anchorId,
    required this.anchorX,
    required this.anchorY,
    required this.anchorZ,
    required this.recordTime,
    required this.roomNumber,
  });

  // Method to convert from JSON to Anchor object
  factory Anchor.fromJson(Map<String, dynamic> json) {
    return Anchor(
      anchorRecId: json['anchorrec_id'],
      anchorId: json['anchor_id'],
      anchorX: json['anchor_x'].toDouble(),
      anchorY: json['anchor_y'].toDouble(),
      anchorZ: json['anchor_z'].toDouble(),
      recordTime: DateTime.parse(json['record_time']),
      roomNumber: json['room_number'],
    );
  }

  // Method to convert from Anchor object to JSON
  Map<String, dynamic> toJson() {
    return {
      'anchorrec_id': anchorRecId,
      'anchor_id': anchorId,
      'anchor_x': anchorX,
      'anchor_y': anchorY,
      'anchor_z': anchorZ,
      'record_time': recordTime.toIso8601String(),
      'room_number': roomNumber,
    };
  }
}