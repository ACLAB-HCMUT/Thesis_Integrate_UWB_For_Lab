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

  // Get the list of device's location as a Map
  static Future<Map<String, DeviceLocation>> fetchDataHourly() async {
    // Simulate device's data
    await Future.delayed(const Duration(milliseconds: 500));
    final Map<String, dynamic> fakeData = {
      '1': {
        'tag_x': 0.5,
        'tag_y': 0.5,
        'tag_z': 0,
        'record_time': '2024-12-28T09:00:00Z',
        'record_type': 'hourly',
        'room_id': '1',
      },
      '2': {
        'tag_x': 0.5,
        'tag_y': 1,
        'tag_z': 0,
        'record_time': '2024-12-28T10:00:00Z',
        'record_type': 'hourly',
        'room_id': '1',
      },
      '3': {
        'tag_x': 0.6,
        'tag_y': 2,
        'tag_z': 0,
        'record_time': '2024-12-28T11:00:00Z',
        'record_type': 'hourly',
        'room_id': '1',
      },
      '4': {
        'tag_x': 1,
        'tag_y': 2.5,
        'tag_z': 0,
        'record_time': '2024-12-28T12:00:00Z',
        'record_type': 'hourly',
        'room_id': '1',
      },
      '5': {
        'tag_x': 1.5,
        'tag_y': 2.5,
        'tag_z': 0,
        'record_time': '2024-12-28T13:00:00Z',
        'record_type': 'hourly',
        'room_id': '1',
      },
      '6': {
        'tag_x': 1.7,
        'tag_y': 2.8,
        'tag_z': 0,
        'record_time': '2024-12-28T14:00:00Z',
        'record_type': 'hourly',
        'room_id': '1',
      },
      '7': {
        'tag_x': 1.7,
        'tag_y': 3.5,
        'tag_z': 0,
        'record_time': '2024-12-28T15:00:00Z',
        'record_type': 'hourly',
        'room_id': '1',
      },
      '8': {
        'tag_x': 2.5,
        'tag_y': 3.5,
        'tag_z': 0,
        'record_time': '2024-12-28T16:00:00Z',
        'record_type': 'hourly',
        'room_id': '1',
      },
      '9': {
        'tag_x': 2.9,
        'tag_y': 3.7,
        'tag_z': 0,
        'record_time': '2024-12-28T17:00:00Z',
        'record_type': 'hourly',
        'room_id': '1',
      },
      '10': {
        'tag_x': 3.5,
        'tag_y': 4,
        'tag_z': 0,
        'record_time': '2024-12-28T18:00:00Z',
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
        'tag_x': 1,
        'tag_y': 4.5,
        'tag_z': 0,
        'record_time': '2024-12-19T09:00:00Z',
        'record_type': 'daily',
        'room_id': '1',
      },
      '2': {
        'tag_x': 1,
        'tag_y': 3.5,
        'tag_z': 0,
        'record_time': '2024-12-20T09:00:00Z',
        'record_type': 'daily',
        'room_id': '1',
      },
      '3': {
        'tag_x': 1.5,
        'tag_y': 3,
        'tag_z': 0,
        'record_time': '2024-12-21T09:00:00Z',
        'record_type': 'daily',
        'room_id': '1',
      },
      '4': {
        'tag_x': 2,
        'tag_y': 2.5,
        'tag_z': 0,
        'record_time': '2024-12-22T09:00:00Z',
        'record_type': 'daily',
        'room_id': '1',
      },
      '5': {
        'tag_x': 2.3,
        'tag_y': 3.2,
        'tag_z': 0,
        'record_time': '2024-12-23T09:00:00Z',
        'record_type': 'daily',
        'room_id': '1',
      },
      '6': {
        'tag_x': 2.7,
        'tag_y': 3.2,
        'tag_z': 0,
        'record_time': '2024-12-24T09:00:00Z',
        'record_type': 'daily',
        'room_id': '1',
      },
      '7': {
        'tag_x': 3.0,
        'tag_y': 3,
        'tag_z': 0,
        'record_time': '2024-12-25T09:00:00Z',
        'record_type': 'daily',
        'room_id': '1',
      },
      '8': {
        'tag_x': 3.5,
        'tag_y': 2,
        'tag_z': 0,
        'record_time': '2024-12-26T09:00:00Z',
        'record_type': 'daily',
        'room_id': '1',
      },
      '9': {
        'tag_x': 2,
        'tag_y': 1,
        'tag_z': 0,
        'record_time': '2024-12-27T09:00:00Z',
        'record_type': 'daily',
        'room_id': '1',
      },
      '10': {
        'tag_x': 0.5,
        'tag_y': 0.5,
        'tag_z': 0,
        'record_time': '2024-12-28T09:00:00Z',
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
        'room_id': '1',
      },
      '2': {
        'anchorrec_id': '2',
        'anchor_id': 2,
        'anchor_x': 5,
        'anchor_y': 0,
        'anchor_z': 0,
        'record_time': '2024-12-28T12:30:00Z',
        'room_id': '1',
      },
      '3': {
        'anchorrec_id': '3',
        'anchor_id': 3,
        'anchor_x': 0,
        'anchor_y': 5,
        'anchor_z': 0,
        'record_time': '2024-12-28T12:30:00Z',
        'room_id': '1',
      },
      '4': {
        'anchorrec_id': '4',
        'anchor_id': 4,
        'anchor_x': 5,
        'anchor_y': 5,
        'anchor_z': 0,
        'record_time': '2024-12-28T12:30:00Z',
        'room_id': '1',
      },
    };

    // Convert fake data to Map
    final convertedData = fakeData.map((key, value) {
      return MapEntry(key, Anchor.fromJson(value));
    });

    _logger.info("Converted data: $convertedData");
    return convertedData;
  }

  // Fetch hourly data
  Future<void> fetchHistoryHourly() async {
    try {
      if (_deviceLocs.isEmpty) {
        _deviceLocs = await fetchDataHourly();
        notifyListeners();
      }
      if (_anchorLocs.isEmpty) {
        _anchorLocs = await fetchAnchor();
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Error loading data: $e');
    }
  }

  Future<void> fetchHistoryDaily() async {
    try {
      if (_deviceLocsDaily.isEmpty) {
        _deviceLocsDaily = await fetchDataDaily();
        notifyListeners();
      }
      if (_anchorLocs.isEmpty) {
        _anchorLocs = await fetchAnchor();
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Error loading data: $e');
    }
  }
}
