import 'package:flutter/foundation.dart';

class GTZoneModel extends ChangeNotifier {
  String sensorId;
  String displayName;
  int threshold;
  int pin;
  GTZoneModel({
    required this.sensorId,
    required this.displayName,
    required this.threshold,
    required this.pin,
  });
}
