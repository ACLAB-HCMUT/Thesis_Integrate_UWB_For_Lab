import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:uwb_positioning/models/device_location.dart';
import 'package:uwb_positioning/models/anchor.dart';

class DeviceLocationService with ChangeNotifier {
  // Temporary memory to store detail of devices
  Map<String, DeviceLocation> _deviceLocs = {};
  Map<String, DeviceLocation> get deviceLocs => _deviceLocs;

  Map<String, DeviceLocation> _deviceLocsDaily = {};
  Map<String, DeviceLocation> get deviceLocsDaily => _deviceLocsDaily;

  Map<String, Anchor> _anchorLocs = {};
  Map<String, Anchor> get anchorLocs => _anchorLocs;
  // Logger instance
  static final Logger _logger = Logger('DeviceLocationService');

  // Get the list of devices as a Map
  static Future<Map<String, DeviceLocation>> fetchDataHourly() async {
    // Simulate device's data
    await Future.delayed(const Duration(milliseconds: 500));
    final Map<String, dynamic> fakeData = {
      '1': {
        'tag_x': 1,
        'tag_y': 1,
        'tag_z': 0,
        'record_time': '2024-12-28T12:30:00Z',
        'record_type': 'hourly',
        'room_id': '1',
      },
      '2': {
        'tag_x': 1,
        'tag_y': 2,
        'tag_z': 0,
        'record_time': '2024-12-28T12:30:00Z',
        'record_type': 'hourly',
        'room_id': '1',
      },
      '3': {
        'tag_x': 1,
        'tag_y': 3,
        'tag_z': 0,
        'record_time': '2024-12-28T12:30:00Z',
        'record_type': 'hourly',
        'room_id': '1',
      },
    };
    // Convert fake data to Map
    final convertedData = fakeData.map((key, value) {
      return MapEntry(key, DeviceLocation.fromJson(value));
    });

    _logger.info("Converted data: $convertedData");
    return convertedData;
  }

  // Get the list of devices as a Map
  static Future<Map<String, DeviceLocation>> fetchDataDaily() async {
    // Simulate device's data
    await Future.delayed(const Duration(milliseconds: 500));
    final Map<String, dynamic> fakeData = {
      '1': {
        'tag_x': 2,
        'tag_y': 1,
        'tag_z': 0,
        'record_time': '2024-12-28T12:30:00Z',
        'record_type': 'daily',
        'room_id': '1',
      },
      '2': {
        'tag_x': 2,
        'tag_y': 2,
        'tag_z': 0,
        'record_time': '2024-12-28T12:30:00Z',
        'record_type': 'daily',
        'room_id': '1',
      },
      '3': {
        'tag_x': 2,
        'tag_y': 3,
        'tag_z': 0,
        'record_time': '2024-12-28T12:30:00Z',
        'record_type': 'daily',
        'room_id': '1',
      },
    };
    // Convert fake data to Map
    final convertedData = fakeData.map((key, value) {
      return MapEntry(key, DeviceLocation.fromJson(value));
    });

    _logger.info("Converted data: $convertedData");
    return convertedData;
  }

  // Get the list of devices as a Map
  static Future<Map<String, Anchor>> fetchAnchor() async {
    // Simulate device's data
    await Future.delayed(const Duration(milliseconds: 500));
    final Map<String, dynamic> fakeData = {
      '1': {
        'anchorrec_id': '1',
        'anchor_id': 1,
        'anchor_x': 0,
        'anchor_y': 0,
        'anchor_z': 0,
        'record_time': '2024-12-28T12:30:00Z',
        'room_number': '1',
      },
      '2': {
        'anchorrec_id': '2',
        'anchor_id': 2,
        'anchor_x': 5,
        'anchor_y': 0,
        'anchor_z': 0,
        'record_time': '2024-12-28T12:30:00Z',
        'room_number': '1',
      },
      '3': {
        'anchorrec_id': '3',
        'anchor_id': 3,
        'anchor_x': 0,
        'anchor_y': 5,
        'anchor_z': 0,
        'record_time': '2024-12-28T12:30:00Z',
        'room_number': '1',
      },
      '4': {
        'anchorrec_id': '4',
        'anchor_id': 4,
        'anchor_x': 5,
        'anchor_y': 5,
        'anchor_z': 0,
        'record_time': '2024-12-28T12:30:00Z',
        'room_number': '1',
      },
    };
    // Convert fake data to Map
    final convertedData = fakeData.map((key, value) {
      return MapEntry(key, Anchor.fromJson(value));
    });

    _logger.info("Converted data: $convertedData");
    return convertedData;
  }

  // Fetch data for the first time
  Future<void> fetchHistoryHourly() async {
    if (_deviceLocs.isEmpty) {
      try {
        _deviceLocs = await fetchDataHourly();
        notifyListeners();
      } catch (e) {
        throw Exception('Error loading data: $e');
      }
    }
    if (_anchorLocs.isEmpty) {
      try {
        _anchorLocs = await fetchAnchor();
        notifyListeners();
      } catch (e) {
        throw Exception('Error loading data: $e');
      }
    }
  }

  Future<void> fetchHistoryDaily() async {
    if (_deviceLocsDaily.isEmpty) {
      try {
        _deviceLocsDaily = await fetchDataDaily();
        notifyListeners();
      } catch (e) {
        throw Exception('Error loading data: $e');
      }
    }
    if (_anchorLocs.isEmpty) {
      try {
        _anchorLocs = await fetchAnchor();
        notifyListeners();
      } catch (e) {
        throw Exception('Error loading data: $e');
      }
    }
  }

  // Future<void> fetchHistoryAnchor() async {
  //   if (_anchorLocs.isEmpty) {
  //     try {
  //       _anchorLocs = await fetchAnchor();
  //       notifyListeners();
  //     } catch (e) {
  //       throw Exception('Error loading data: $e');
  //     }
  //   }
  // }
}
