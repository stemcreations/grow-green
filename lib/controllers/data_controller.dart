import 'dart:convert';
import 'package:grow_green_v2/models/readings_model.dart';
import 'package:grow_green_v2/providers/data_providers.dart';
import 'package:http/http.dart' as http;

class DataController {
  List<ReadingsModel> getSensorReadings(
      String sensorId, List<ReadingsModel> readings) {
    return readings.where((element) => element.sensorId == sensorId).toList();
  }

  ReadingsModel getMostRecentSensorReading(
      String sensorId, List<ReadingsModel> readings) {
    List<ReadingsModel> sensorReadings =
        readings.where((element) => element.sensorId == sensorId).toList();
    sensorReadings.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return sensorReadings[0];
  }

  Future<void> updateSensorDisplayName(
      String sensorId, String displayName) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://127.0.0.1:5050/update-display_name'));
    request.body =
        json.encode({'sensor_id': sensorId, 'display_name': displayName});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('Sensor display name updated');
    } else {
      print('Failed to update sensor display name');
    }
  }

  dynamic getSensorObject(String sensorId, List<dynamic> sensorList) {
    return sensorList.firstWhere((element) => element['sensor_id'] == sensorId);
  }
}
