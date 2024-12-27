import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService with ChangeNotifier {
  final String server = "io.adafruit.com";
  final String username = "Duyen";
  final String aioKey = "";
  final String topicTag = "Duyen/feeds/tagposition";
  final String topicAnchor = "Duyen/feeds/anchorposition";

  late MqttServerClient client;

  // Temporary memory to store data of devices/anchors
  final Map<String, Map<String, dynamic>> _deviceData = {};
  final Map<String, Map<String, dynamic>> _anchorData = {};
  // Getter to get data
  Map<String, Map<String, dynamic>> get deviceData => _deviceData;
  Map<String, Map<String, dynamic>> get anchorData => _anchorData;
  // Logger instance
  final Logger _logger = Logger('MqttService');

  Future<void> connectAndSubscribe() async {
    client = MqttServerClient.withPort(server, 'flutter_client', 1883);
    client.logging(on: true);
    client.keepAlivePeriod = 60;

    // Connection Configuration
    final connMessage = MqttConnectMessage()
        .authenticateAs(username, aioKey)
        .startClean()
        .withWillTopic('disconnect')
        .withWillMessage('Disconnected unexpectedly')
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;

    try {
      // Connect to Adafruit
      _logger.info('Connecting to MQTT broker...');
      await client.connect();
      _logger.info('Connected successfully!');

      // Subscribe to the topic
      client.subscribe(topicTag, MqttQos.atLeastOnce);
      _logger.info('Subscribed to topic: $topicTag');
      client.subscribe(topicAnchor, MqttQos.atLeastOnce);
      _logger.info('Subscribed to topic: $topicAnchor');

      // Listen for updates
      client.updates!
          .listen((List<MqttReceivedMessage<MqttMessage?>>? messages) {
        final recMessage = messages![0].payload as MqttPublishMessage;
        final payload = MqttPublishPayload.bytesToStringAsString(
            recMessage.payload.message);

        // Get the topic of the received message
        final topic = messages[0].topic;

        // Parse JSON
        handleTopicMessage(topic, payload);
      });
    } catch (e) {
      // Disconnect if error
      _logger.severe('Error: $e');
      client.disconnect();
    }
  }

  void handleTopicMessage(String topic, String payload) {
    try {
      final parsedData = jsonDecode(payload) as Map<String, dynamic>;
      _logger.info('Received JSON: $parsedData');

      if (topic == topicTag) {
        final deviceId = parsedData['tag_id'] as String;
        _deviceData[deviceId] = {
          'tag_x': parsedData['tag_x'].toDouble(),
          'tag_y': parsedData['tag_y'].toDouble(),
          'tag_z': parsedData['tag_z'].toDouble(),
        };
        _logger.fine('Updated device $deviceId data: ${_deviceData[deviceId]}');
      } else if (topic == topicAnchor) {
        final anchorId = parsedData['anchor_id'] as String;
        _anchorData[anchorId] = {
          'anchor_x': parsedData['anchor_x'].toDouble(),
          'anchor_y': parsedData['anchor_y'].toDouble(),
          'anchor_z': parsedData['anchor_z'].toDouble(),
        };
        _logger.fine('Updated anchor $anchorId data: ${_anchorData[anchorId]}');
      }

      // Change notification
      notifyListeners();
    } catch (e) {
      _logger.severe('Error parsing message: $e');
    }
  }

  void disconnect() {
    client.disconnect();
    _logger.info('Disconnected from MQTT broker');
  }

  bool hasAtLeastThreeAnchors() {
    int count = 0;
    for (final anchor in _anchorData.values) {
      if (anchor['anchor_x'] != null &&
          anchor['anchor_y'] != null &&
          anchor['anchor_z'] != null) {
        count++;
      }
      if (count >= 3) {
        return true;
      }
    }
    return false;
  }
}
