import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:uwb_positioning/services/auth_service.dart';
import 'dart:convert';
import 'package:uwb_positioning/services/config.dart';
import 'package:uwb_positioning/models/device.dart';
import 'package:uwb_positioning/services/update_service.dart';
import 'package:http/http.dart' as http;

class DeviceService with ChangeNotifier {
  //API
  static final getAllDeviceUri = baseUri.replace(path: '/devices');
  static Uri getDetailUri(String id) => baseUri.replace(path: '/devices/$id');
  //User
  final AuthProvider userProvider;
  DeviceService(this.userProvider);
  // Temporary memory to store detail of devices
  Map<String, Device> _devices = {};
  Map<String, Device> get devices => _devices;
  // Logger instance
  static final Logger _logger = Logger('DeviceService');

  // Get the list of devices as a Map
  // static Future<Map<String, Device>> fetchListDevice() async {
  //   // Simulate device's data
  //   await Future.delayed(const Duration(milliseconds: 500));
  //   final Map<String, dynamic> fakeData = {
  //     '1': {
  //       'device_id': '1',
  //       'device_name': 'UWB Tag 1',
  //       'image':
  //           'https://static-cdn.m5stack.com/resource/docs/products/unit/uwb/uwb_02.webp',
  //       'is_active': true,
  //       'is_available': true,
  //       'type_name': 'UWB Unit',
  //     },
  //     '2': {
  //       'device_id': '2',
  //       'device_name': 'NodeMCU-BU01',
  //       'image':
  //           'https://exp-tech.de/cdn/shop/products/NodeMCU-BU01_1.png?vu003d1689269984',
  //       'is_active': false,
  //       'is_available': false,
  //       'type_name': 'UWB Unit',
  //     },
  //     '3': {
  //       'device_id': '3',
  //       'device_name': 'STM32 Microcontroller',
  //       'image':
  //           'https://res.cloudinary.com/rsc/image/upload/w_1024/F9107951-01',
  //       'is_active': false,
  //       'is_available': false,
  //       'type_name': 'Microcontroller',
  //     },
  //   };
  //   // Convert fake data to Map
  //   final convertedData = fakeData.map((key, value) {
  //     return MapEntry(key, Device.createDevice(value));
  //   });
  //
  //   _logger.info("Converted data: $convertedData");
  //   return convertedData;
  // }
  Future<Map<String, Device>> fetchListDevice() async {
    // final response = await http.get(getAllDeviceUri);
    final token = userProvider.user?.token;

    if (token == null) {
      throw Exception('Token không tồn tại');
    }

    final response = await http.get(
      getAllDeviceUri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    _logger.info("Raw response body: ${response.body}");
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final Map<String, Device> deviceMap = {
        for (var device in data)
          device['device_id'].toString(): Device.createDevice(device),
      };
      _logger.info("Fetched data: $deviceMap");
      return deviceMap;
    } else {
      throw Exception('Failed to load devices');
    }
  }

  // Get device details from database
  // static Future<Map<String, dynamic>> fetchInfoDevice(String deviceId) async {
  //   await Future.delayed(const Duration(milliseconds: 500));
  //   if (deviceId == '1') {
  //     return {
  //       'description':
  //           "UWB is a Unit which integrates the UWB(Ultra Wide Band) communication protocol which uses nanosecond pulses to locate objects and define position and orientation. The design uses the Ai-ThinkerBU01 Transceiver module which is based on Decawave's DW1000 design. The internal STM32 chip with its integrated ranging algorithm,is capable of 10cm positioning accuracy and also supports AT command control. Applications include: Indoor wireless tracking/range finding of assets,which works by triangulating the position of the base station/s and tag (the base station resolves the position information and outputs it to the tag).",
  //       'manufacturer': 'M5Stack',
  //       'serial': 'SKU:U100',
  //       'specification':
  //           'Data transfer rate: 10 kbit/s, 850 kbit/s and 6.8 Mbit/s',
  //     };
  //   } else if (deviceId == '2') {
  //     return {
  //       'description':
  //           "Node MCU is an open-source development platform based on the ESP8266, a popular Wi-Fi module known for its ability to connect to the Internet and enable remote control. It provides a simple and efficient programming environment using Lua scripts or Arduino IDE. Node MCU facilitates easy integration with IoT devices and automation applications.",
  //       'manufacturer': 'Espressif Systems',
  //       'serial': 'SKU:ESP8266',
  //       'specification': 'Processor: Tensilica L106 32-bit RISC microprocessor',
  //     };
  //   } else {
  //     return {
  //       'description':
  //           "The STM32 is a family of 32-bit microcontrollers from STMicroelectronics, based on the ARM Cortex-M processor. Known for their high performance, low power consumption, and scalability, STM32 microcontrollers are ideal for a wide range of applications, including industrial automation, consumer electronics, and IoT. They provide rich peripheral interfaces and robust development support.",
  //       'manufacturer': 'STMicroelectronics',
  //       'serial': 'SKU:STM32F401',
  //       'specification': 'Clock Speed: Up to 84 MHz',
  //     };
  //   }
  // }
  Future<Map<String, dynamic>> fetchInfoDevice(String deviceId) async {
    final token = userProvider.user?.token;

    if (token == null) {
      throw Exception('Token không tồn tại');
    }
    final uri = getDetailUri(deviceId);
    final resp = await http.get(uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },);
    _logger.info('GET $uri → ${resp.statusCode}');
    if (resp.statusCode != 200) throw Exception('Failed to load device detail');
    return json.decode(resp.body) as Map<String, dynamic>;
  }

  // Fetch data for the first time
  Future<void> fetchDeviceGeneral() async {
    if (_devices.isEmpty) {
      try {
        _devices = await fetchListDevice();
        notifyListeners();
      } catch (e) {
        throw Exception('Error loading data: $e');
      }
    }
  }

  // Fetch device detail
  Future<void> fetchDeviceDetail(String deviceId) async {
    try {
      final deviceDetailData = await fetchInfoDevice(deviceId);
      final currentDevice = _devices[deviceId]!;
      if (currentDevice.shouldUpdate(deviceDetailData)) {
        _devices[deviceId]!.updateDetail(deviceDetailData);
        notifyListeners();
      } else {
        throw Exception('Device not found!');
      }
    } catch (e) {
      throw Exception('Error fetching device detail: $e');
    }
  }

  // Check and update data if there are changes
  Future<void> checkAndFetchUpdates() async {
    try {
      final isUpdated = await UpdateService().checkForUpdates();
      if (isUpdated) {
        _devices = await fetchListDevice();
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Error checking for updates: $e');
    }
  }
}
