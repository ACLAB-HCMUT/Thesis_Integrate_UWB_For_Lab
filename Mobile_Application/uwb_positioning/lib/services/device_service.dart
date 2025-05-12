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
  static Uri detailUri(String id) => baseUri.replace(path: '/devices/$id');
  //User
  final AuthProvider userProvider;
  DeviceService(this.userProvider);
  // Temporary memory to store detail of devices
  Map<String, Device> _devices = {};
  Map<String, Device> get devices => _devices;
  // Logger instance
  static final Logger _logger = Logger('DeviceService');

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

  Future<Map<String, dynamic>> fetchInfoDevice(String deviceId) async {
    final token = userProvider.user?.token;

    if (token == null) {
      throw Exception('Token không tồn tại');
    }
    final uri = detailUri(deviceId);
    final resp = await http.get(uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },);
    _logger.info('GET $uri → ${resp.statusCode}');
    if (resp.statusCode != 200) throw Exception('Failed to load device detail');
    return json.decode(resp.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> updateDevice(String deviceId, Map<String, dynamic> updateFields) async {
    final token = userProvider.user?.token;  // Lấy token từ userProvider

    if (token == null) {
      throw Exception('Token không tồn tại');
    }

    final uri = detailUri(deviceId);

    final response = await http.patch(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(updateFields),  // Gửi dữ liệu cần cập nhật
    );

    if (response.statusCode != 200) {
      throw Exception('Cập nhật thiết bị thất bại');
    }

    return json.decode(response.body) as Map<String, dynamic>;
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
      _logger.warning("$deviceDetailData");
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
