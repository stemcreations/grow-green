import 'package:grow_green_v2/models/g_t_zone_model.dart';
import 'package:grow_green_v2/models/g_t_node_model.dart';
import 'package:grow_green_v2/models/readings_model.dart';

List<dynamic> sensorListTest = [
  GTZoneModel(
      sensorId: 'G.T.Zone 1212',
      displayName: 'Front Yard',
      threshold: 78,
      pin: 4),
  GTZoneModel(
      sensorId: 'G.T.Zone 1214',
      displayName: 'Back Yard',
      threshold: 78,
      pin: 23),
  GTZoneModel(
      sensorId: 'G.T.Zone 1216',
      displayName: 'Side Yard',
      threshold: 78,
      pin: 27),
  GTNodeModel(sensorId: 'G.T.Node 1010', displayName: 'Peppers', threshold: 78),
  GTNodeModel(
      sensorId: 'G.T.Node 1015', displayName: 'Tomatoes', threshold: 78),
];

List<ReadingsModel> readingsListTest = [
  ReadingsModel(
      sensorId: 'G.T.Zone 1212',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 10, 10, 00)),
  ReadingsModel(
      sensorId: 'G.T.Zone 1212',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 10, 16, 00)),
  ReadingsModel(
      sensorId: 'G.T.Zone 1212',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 10, 22, 00)),
  ReadingsModel(
      sensorId: 'G.T.Zone 1212',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 11, 04, 00)),
  ReadingsModel(
      sensorId: 'G.T.Zone 1212',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 11, 10, 00)),
  ReadingsModel(
      sensorId: 'G.T.Zone 1212',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 11, 16, 00)),
  ReadingsModel(
      sensorId: 'G.T.Zone 1212',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 11, 22, 00)),
  ReadingsModel(
      sensorId: 'G.T.Zone 1212',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 12, 04, 00)),
  ReadingsModel(
      sensorId: 'G.T.Zone 1212',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 12, 10, 00)),
  ReadingsModel(
      sensorId: 'G.T.Zone 1212',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 12, 16, 00)),
  ReadingsModel(
      sensorId: 'G.T.Zone 1214',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 11, 16, 00)),
  ReadingsModel(
      sensorId: 'G.T.Zone 1214',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 11, 22, 00)),
  ReadingsModel(
      sensorId: 'G.T.Zone 1214',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 12, 04, 00)),
  ReadingsModel(
      sensorId: 'G.T.Zone 1214',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 12, 10, 00)),
  ReadingsModel(
      sensorId: 'G.T.Zone 1214',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 12, 16, 00)),
  ReadingsModel(
      sensorId: 'G.T.Zone 1214',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 12, 22, 00)),
  ReadingsModel(
      sensorId: 'G.T.Zone 1214',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 13, 04, 00)),
  ReadingsModel(
      sensorId: 'G.T.Zone 1214',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 13, 10, 00)),
  ReadingsModel(
      sensorId: 'G.T.Zone 1214',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 13, 16, 00)),
  ReadingsModel(
      sensorId: 'G.T.Zone 1216',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 12, 22, 00)),
  ReadingsModel(
      sensorId: 'G.T.Zone 1216',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 13, 04, 00)),
  ReadingsModel(
      sensorId: 'G.T.Zone 1216',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 13, 10, 00)),
  ReadingsModel(
      sensorId: 'G.T.Zone 1216',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 13, 16, 00)),
  ReadingsModel(
      sensorId: 'G.T.Zone 1216',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 13, 22, 00)),
  ReadingsModel(
      sensorId: 'G.T.Zone 1216',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 14, 04, 00)),
  ReadingsModel(
      sensorId: 'G.T.Zone 1216',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 14, 10, 00)),
  ReadingsModel(
      sensorId: 'G.T.Zone 1216',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 14, 16, 00)),
  ReadingsModel(
      sensorId: 'G.T.Zone 1216',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 14, 22, 00)),
  ReadingsModel(
      sensorId: 'G.T.Node 1010',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 14, 04, 00)),
  ReadingsModel(
      sensorId: 'G.T.Node 1010',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 14, 10, 00)),
  ReadingsModel(
      sensorId: 'G.T.Node 1010',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 14, 16, 00)),
  ReadingsModel(
      sensorId: 'G.T.Node 1010',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 14, 22, 00)),
  ReadingsModel(
      sensorId: 'G.T.Node 1010',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 15, 04, 00)),
  ReadingsModel(
      sensorId: 'G.T.Node 1010',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 15, 10, 00)),
  ReadingsModel(
      sensorId: 'G.T.Node 1010',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 15, 16, 00)),
  ReadingsModel(
      sensorId: 'G.T.Node 1010',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 15, 22, 00)),
  ReadingsModel(
      sensorId: 'G.T.Node 1010',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 14, 04, 00)),
  ReadingsModel(
      sensorId: 'G.T.Node 1015',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 15, 10, 00)),
  ReadingsModel(
      sensorId: 'G.T.Node 1015',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 15, 16, 00)),
  ReadingsModel(
      sensorId: 'G.T.Node 1015',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 15, 22, 00)),
  ReadingsModel(
      sensorId: 'G.T.Node 1015',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 16, 04, 00)),
  ReadingsModel(
      sensorId: 'G.T.Node 1015',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 16, 10, 00)),
  ReadingsModel(
      sensorId: 'G.T.Node 1015',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 16, 16, 00)),
  ReadingsModel(
      sensorId: 'G.T.Node 1015',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 16, 22, 00)),
  ReadingsModel(
      sensorId: 'G.T.Node 1015',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 17, 04, 00)),
  ReadingsModel(
      sensorId: 'G.T.Node 1015',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 17, 10, 00)),
  ReadingsModel(
      sensorId: 'G.T.Node 1015',
      moisture: 65,
      batteryHealth: 75,
      timestamp: DateTime(2023, 10, 17, 16, 00)),
];
