class Device {
  final int deviceId;
  final String deviceName;
  final String description;
  final String serial;
  final String manufacturer;
  final String specification;
  final int typeId;
  final String image;
  final bool isActive;
  final bool isAvailable;

  Device({
    required this.deviceId,
    required this.deviceName,
    required this.description,
    required this.serial,
    required this.manufacturer,
    required this.specification,
    required this.typeId,
    required this.image,
    required this.isActive,
    required this.isAvailable,
  });

  // Method to convert from JSON to Device object
  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      deviceId: json['device_id'],
      deviceName: json['device_name'],
      description: json['description'],
      serial: json['serial'],
      manufacturer: json['manufacturer'],
      specification: json['specification'],
      typeId: json['type_id'],
      image: json['image'],
      isActive: json['is_active'],
      isAvailable: json['is_available'],
    );
  }

  // Method to convert from Device object to JSON
  Map<String, dynamic> toJson() {
    return {
      'device_id': deviceId,
      'device_name': deviceName,
      'description': description,
      'serial': serial,
      'manufacturer': manufacturer,
      'specification': specification,
      'type_id': typeId,
      'image': image,
      'is_active': isActive,
      'is_available': isAvailable,
    };
  }
}
