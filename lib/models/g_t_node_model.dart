import 'package:flutter/foundation.dart';

class GTNodeModel extends ChangeNotifier {
  String sensorId;
  String displayName;
  int threshold;
  GTNodeModel({
    required this.sensorId,
    required this.displayName,
    required this.threshold,
  });
}
