import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:grow_green_v2/models/g_t_node_model.dart';
import 'package:grow_green_v2/models/g_t_zone_model.dart';
import 'package:grow_green_v2/models/readings_model.dart';
import 'package:http/http.dart' as http;

class DatabaseFunctionsProvider extends ChangeNotifier {
  List<dynamic> _sensorList = []; // List of sensors
  List<ReadingsModel> _readingsList = []; // List of readings

  List<dynamic> get sensorList => _sensorList;
  List<ReadingsModel> get readingsList => _readingsList;

  Future<List<ReadingsModel>> _getSensorReadings() async {
    _readingsList.clear();
    var request =
        http.Request('GET', Uri.parse('http://127.0.0.1:5050/sensor-data'));
    http.StreamedResponse response = await request.send();
    String byteStream = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      List<Map<dynamic, dynamic>> data =
          jsonDecode(byteStream).cast<Map<dynamic, dynamic>>();
      List<ReadingsModel> readings = [];
      for (var reading in data) {
        ReadingsModel tempReading = ReadingsModel(
          sensorId: reading['sensor_id'],
          moisture: reading['moisture'],
          batteryHealth: reading['battery_health'],
          timestamp: DateTime.parse(reading['timestamp']),
        );
        readings.add(tempReading);
      }
      _readingsList = readings;
      notifyListeners();
      return _readingsList;
    } else {
      throw Exception('Failed to fetch sensor data');
    }
  }

  Future<List<dynamic>> getSensorList() async {
    await _getSensorReadings();
    //Get zones from server
    var request =
        http.Request('GET', Uri.parse('http://127.0.0.1:5050/get-zones'));
    http.StreamedResponse response = await request.send();
    String byteStream = await response.stream.bytesToString();

    //Get nodes from server
    var nodeRequest =
        http.Request('GET', Uri.parse('http://127.0.0.1:5050/get-nodes'));
    http.StreamedResponse nodeResponse = await nodeRequest.send();
    String nodeByteStream = await nodeResponse.stream.bytesToString();
    if (response.statusCode == 200 && nodeResponse.statusCode == 200) {
      List<Map<dynamic, dynamic>> zoneData =
          jsonDecode(byteStream).cast<Map<dynamic, dynamic>>();
      List<Map<dynamic, dynamic>> nodeData =
          jsonDecode(nodeByteStream).cast<Map<dynamic, dynamic>>();
      List<dynamic> sensors = [];
      for (var zone in zoneData) {
        GTZoneModel tempZone = GTZoneModel(
            sensorId: zone['sensor_id'],
            displayName: zone['display_name'],
            threshold: zone['threshold'],
            pin: zone['pin']);
        sensors.add(tempZone);
      }
      for (var node in nodeData) {
        GTNodeModel tempNode = GTNodeModel(
            sensorId: node['sensor_id'],
            displayName: node['display_name'],
            threshold: node['threshold']);
        sensors.add(tempNode);
      }
      _sensorList = sensors;
      notifyListeners();
      return sensors;
    } else {
      throw Exception('Failed to fetch sensor data');
    }
  }
}
