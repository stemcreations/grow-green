import 'package:flutter/foundation.dart';

class ReadingsModel extends ChangeNotifier {
  String sensorId;
  double moisture;
  double batteryHealth;
  DateTime timestamp;
  ReadingsModel({
    required this.sensorId,
    required this.moisture,
    required this.batteryHealth,
    required this.timestamp,
  });
}
