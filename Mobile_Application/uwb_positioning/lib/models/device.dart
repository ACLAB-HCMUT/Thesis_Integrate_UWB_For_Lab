import 'package:logging/logging.dart';

class Device {
  final int deviceId;
  final String deviceName;
  String description = '';
  String manufacturer = '';
  String serial = '';
  String specification = '';
  final String image;
  final bool isActive;
  final bool isAvailable;
  final String typeName;
  late bool isInRoom;

  // Logger instance
  static final Logger _logger = Logger('Device');

  // Constructor
  Device({
    required this.deviceId,
    required this.deviceName,
    required this.image,
    required this.isActive,
    required this.isAvailable,
    required this.typeName,
    required this.isInRoom,
  });

  // Method to assign general data from JSON to object
  factory Device.createDevice(Map<String, dynamic> json) {
    try {
      _logger.info("Create Device from JSON: $json");

      return Device(
        deviceId: json['device_id'],
        deviceName: json['device_name'],
        image: json['image'],
        isActive: json['is_active'],
        isAvailable: json['is_available'],
        typeName: json['type_name'],
        isInRoom: false,
      );
    } catch (e, stackTrace) {
      _logger.severe("Error creating Device: $e", e, stackTrace);
      rethrow; // Re-throw the error after logging it
    }
  }

  // Method to convert from Device object to JSON
  Map<String, dynamic> toJson() {
    return {
      'device_id': deviceId,
      'device_name': deviceName,
      'description': description,
      'manufacturer': manufacturer,
      'serial': serial,
      'specification': specification,
      'image': image,
      'is_active': isActive,
      'is_available': isAvailable,
      'type_name': typeName,
    };
  }

  // Method to assign detail data from JSON to object
  void updateDetail(Map<String, dynamic> json) {
    try {
      _logger.info("Update Device from JSON: $json");

      description = json['description'];
      manufacturer = json['manufacturer'];
      serial = json['serial'];
      specification = json['specification'];
    } catch (e, stackTrace) {
      _logger.severe("Error updating Device: $e", e, stackTrace);
      rethrow; // Re-throw the error after logging it
    }
  }

  bool shouldUpdate(Map<String, dynamic> newData) {
    return description != newData['description'] ||
        serial != newData['serial'] ||
        manufacturer != newData['manufacturer'] ||
        specification != newData['specification'];
  }

  // Method to update whether tag is in room
  void updateInRoom(bool inRoomStatus) {
    isInRoom = inRoomStatus;
    _logger.info('Tag đang ở trong phòng: ${isInRoom ? 'Có' : 'Không'}');
  }
}
