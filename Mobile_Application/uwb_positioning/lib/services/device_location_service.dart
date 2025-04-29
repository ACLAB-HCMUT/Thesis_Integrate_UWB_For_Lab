import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:uwb_positioning/models/device_location.dart';
import 'package:uwb_positioning/models/anchor.dart';
import 'package:uwb_positioning/services/config.dart';
import 'package:http/http.dart' as http;

class DeviceLocationService with ChangeNotifier {
  static Uri getHourlyUri(String id) => baseUri.replace(path: '/locations/hourly/$id');
  static Uri getDailyUri(String id) => baseUri.replace(path: '/locations/daily/$id');
  static Uri getAnchorUri(String id) => baseUri.replace(path: '/locations/anchor/$id');
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
  // static Future<Map<String, DeviceLocation>> fetchDataHourly() async {
  //   // Simulate device's data
  //   await Future.delayed(const Duration(milliseconds: 500));
  //   final Map<String, dynamic> fakeData = {
  //     '1': {
  //       'tag_x': 0.5,
  //       'tag_y': 0.5,
  //       'tag_z': 0,
  //       'record_time': '2024-12-28T09:00:00Z',
  //       'record_type': 'hourly',
  //       'room_id': '1',
  //     },
  //     '2': {
  //       'tag_x': 0.5,
  //       'tag_y': 1,
  //       'tag_z': 0,
  //       'record_time': '2024-12-28T10:00:00Z',
  //       'record_type': 'hourly',
  //       'room_id': '1',
  //     },
  //     '3': {
  //       'tag_x': 0.6,
  //       'tag_y': 2,
  //       'tag_z': 0,
  //       'record_time': '2024-12-28T11:00:00Z',
  //       'record_type': 'hourly',
  //       'room_id': '1',
  //     },
  //     '4': {
  //       'tag_x': 1,
  //       'tag_y': 2.5,
  //       'tag_z': 0,
  //       'record_time': '2024-12-28T12:00:00Z',
  //       'record_type': 'hourly',
  //       'room_id': '1',
  //     },
  //     '5': {
  //       'tag_x': 1.5,
  //       'tag_y': 2.5,
  //       'tag_z': 0,
  //       'record_time': '2024-12-28T13:00:00Z',
  //       'record_type': 'hourly',
  //       'room_id': '1',
  //     },
  //     '6': {
  //       'tag_x': 1.7,
  //       'tag_y': 2.8,
  //       'tag_z': 0,
  //       'record_time': '2024-12-28T14:00:00Z',
  //       'record_type': 'hourly',
  //       'room_id': '1',
  //     },
  //     '7': {
  //       'tag_x': 1.7,
  //       'tag_y': 3.5,
  //       'tag_z': 0,
  //       'record_time': '2024-12-28T15:00:00Z',
  //       'record_type': 'hourly',
  //       'room_id': '1',
  //     },
  //     '8': {
  //       'tag_x': 2.5,
  //       'tag_y': 3.5,
  //       'tag_z': 0,
  //       'record_time': '2024-12-28T16:00:00Z',
  //       'record_type': 'hourly',
  //       'room_id': '1',
  //     },
  //     '9': {
  //       'tag_x': 2.9,
  //       'tag_y': 3.7,
  //       'tag_z': 0,
  //       'record_time': '2024-12-28T17:00:00Z',
  //       'record_type': 'hourly',
  //       'room_id': '1',
  //     },
  //     '10': {
  //       'tag_x': 3.5,
  //       'tag_y': 4,
  //       'tag_z': 0,
  //       'record_time': '2024-12-28T18:00:00Z',
  //       'record_type': 'hourly',
  //       'room_id': '1',
  //     },
  //   };
  //
  //   // Convert fake data to Map
  //   final convertedData = fakeData.map((key, value) {
  //     return MapEntry(key, DeviceLocation.fromJson(value));
  //   });
  //
  //   _logger.info("Converted data: $convertedData");
  //   return convertedData;
  // }
  static Future<Map<String, DeviceLocation>> fetchDataHourly(String deviceId) async {
    try {
      final response = await http.get(getHourlyUri(deviceId));
      if (response.statusCode == 200) {
        final List<dynamic> rawList = jsonDecode(response.body);
        final Map<String, DeviceLocation> locationMap = {
          for (int i = 0; i < rawList.length; i++)
            (i + 1).toString(): DeviceLocation.fromJson(rawList[i])
        };
        _logger.info("Fetched hourly data from API: $locationMap");
        return locationMap;
      } else {
        _logger.warning('Failed to fetch hourly location: ${response.statusCode}');
        throw Exception('Failed to fetch hourly data');
      }
    } catch (e) {
      _logger.severe('Error fetching hourly location: $e');
      rethrow;
    }
  }

  // Get the list of devices as a Map
  // static Future<Map<String, DeviceLocation>> fetchDataDaily() async {
  //   // Simulate device's data
  //   await Future.delayed(const Duration(milliseconds: 500));
  //   final Map<String, dynamic> fakeData = {
  //     '1': {
  //       'tag_x': 1,
  //       'tag_y': 4.5,
  //       'tag_z': 0,
  //       'record_time': '2024-12-19T09:00:00Z',
  //       'record_type': 'daily',
  //       'room_id': '1',
  //     },
  //     '2': {
  //       'tag_x': 1,
  //       'tag_y': 3.5,
  //       'tag_z': 0,
  //       'record_time': '2024-12-20T09:00:00Z',
  //       'record_type': 'daily',
  //       'room_id': '1',
  //     },
  //     '3': {
  //       'tag_x': 1.5,
  //       'tag_y': 3,
  //       'tag_z': 0,
  //       'record_time': '2024-12-21T09:00:00Z',
  //       'record_type': 'daily',
  //       'room_id': '1',
  //     },
  //     '4': {
  //       'tag_x': 2,
  //       'tag_y': 2.5,
  //       'tag_z': 0,
  //       'record_time': '2024-12-22T09:00:00Z',
  //       'record_type': 'daily',
  //       'room_id': '1',
  //     },
  //     '5': {
  //       'tag_x': 2.3,
  //       'tag_y': 3.2,
  //       'tag_z': 0,
  //       'record_time': '2024-12-23T09:00:00Z',
  //       'record_type': 'daily',
  //       'room_id': '1',
  //     },
  //     '6': {
  //       'tag_x': 2.7,
  //       'tag_y': 3.2,
  //       'tag_z': 0,
  //       'record_time': '2024-12-24T09:00:00Z',
  //       'record_type': 'daily',
  //       'room_id': '1',
  //     },
  //     '7': {
  //       'tag_x': 3.0,
  //       'tag_y': 3,
  //       'tag_z': 0,
  //       'record_time': '2024-12-25T09:00:00Z',
  //       'record_type': 'daily',
  //       'room_id': '1',
  //     },
  //     '8': {
  //       'tag_x': 3.5,
  //       'tag_y': 2,
  //       'tag_z': 0,
  //       'record_time': '2024-12-26T09:00:00Z',
  //       'record_type': 'daily',
  //       'room_id': '1',
  //     },
  //     '9': {
  //       'tag_x': 2,
  //       'tag_y': 1,
  //       'tag_z': 0,
  //       'record_time': '2024-12-27T09:00:00Z',
  //       'record_type': 'daily',
  //       'room_id': '1',
  //     },
  //     '10': {
  //       'tag_x': 0.5,
  //       'tag_y': 0.5,
  //       'tag_z': 0,
  //       'record_time': '2024-12-28T09:00:00Z',
  //       'record_type': 'daily',
  //       'room_id': '1',
  //     },
  //   };
  //
  //   // Convert fake data to Map
  //   final convertedData = fakeData.map((key, value) {
  //     return MapEntry(key, DeviceLocation.fromJson(value));
  //   });
  //
  //   _logger.info("Converted data: $convertedData");
  //   return convertedData;
  // }
  static Future<Map<String, DeviceLocation>> fetchDataDaily(String deviceId) async {
    try {
      final response = await http.get(getDailyUri(deviceId));
      if (response.statusCode == 200) {
        final List<dynamic> rawList = jsonDecode(response.body);
        final Map<String, DeviceLocation> locationMap = {
          for (int i = 0; i < rawList.length; i++)
            (i + 1).toString(): DeviceLocation.fromJson(rawList[i])
        };
        _logger.info("Fetched daily data from API: $locationMap");
        return locationMap;
      } else {
        _logger.warning('Failed to fetch daily location: ${response.statusCode}');
        throw Exception('Failed to fetch daily data');
      }
    } catch (e) {
      _logger.severe('Error fetching daily location: $e');
      rethrow;
    }
  }

  // Get the list of devices as a Map
  // static Future<Map<String, Anchor>> fetchAnchor() async {
  //   // Simulate device's data
  //   await Future.delayed(const Duration(milliseconds: 500));
  //   final Map<String, dynamic> fakeData = {
  //     '1': {
  //       'anchorrec_id': '1',
  //       'anchor_id': 1,
  //       'anchor_x': 0,
  //       'anchor_y': 0,
  //       'anchor_z': 0,
  //       'record_time': '2024-12-28T12:30:00Z',
  //       'room_id': '1',
  //     },
  //     '2': {
  //       'anchorrec_id': '2',
  //       'anchor_id': 2,
  //       'anchor_x': 5,
  //       'anchor_y': 0,
  //       'anchor_z': 0,
  //       'record_time': '2024-12-28T12:30:00Z',
  //       'room_id': '1',
  //     },
  //     '3': {
  //       'anchorrec_id': '3',
  //       'anchor_id': 3,
  //       'anchor_x': 0,
  //       'anchor_y': 5,
  //       'anchor_z': 0,
  //       'record_time': '2024-12-28T12:30:00Z',
  //       'room_id': '1',
  //     },
  //     '4': {
  //       'anchorrec_id': '4',
  //       'anchor_id': 4,
  //       'anchor_x': 5,
  //       'anchor_y': 5,
  //       'anchor_z': 0,
  //       'record_time': '2024-12-28T12:30:00Z',
  //       'room_id': '1',
  //     },
  //   };
  //
  //   // Convert fake data to Map
  //   final convertedData = fakeData.map((key, value) {
  //     return MapEntry(key, Anchor.fromJson(value));
  //   });
  //
  //   _logger.info("Converted data: $convertedData");
  //   return convertedData;
  // }
  static Future<Map<String, Anchor>> fetchAnchor(String deviceId) async {
    try {
      final response = await http.get(getAnchorUri(deviceId));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        // Chuyển thành Map<String, Anchor>
        final Map<String, Anchor> anchorMap = {
          for (var item in jsonList)
            item['anchor_id'].toString(): Anchor.fromJson(item)
        };
        _logger.info("Fetched anchor data: $anchorMap");
        return anchorMap;
      } else {
        _logger.warning('Failed to fetch anchors: ${response.statusCode}');
        return {};
      }
    } catch (e) {
      _logger.severe('Error fetching anchors: $e');
      return {};
    }
  }

  // Fetch hourly data
  Future<void> fetchHistoryHourly(String deviceId) async {
    try {
      if (_deviceLocs.isEmpty) {
        _deviceLocs = await fetchDataHourly(deviceId);
        notifyListeners();
      }
      if (_anchorLocs.isEmpty) {
        _anchorLocs = await fetchAnchor(deviceId);
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Error loading data: $e');
    }
  }

  Future<void> fetchHistoryDaily(String deviceId) async {
    try {
      if (_deviceLocsDaily.isEmpty) {
        _deviceLocsDaily = await fetchDataDaily(deviceId);
        notifyListeners();
      }
      if (_anchorLocs.isEmpty) {
        _anchorLocs = await fetchAnchor(deviceId);
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Error loading data: $e');
    }
  }
}
