import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grow_green_v2/controllers/data_controller.dart';
import 'package:grow_green_v2/models/readings_model.dart';
import 'package:grow_green_v2/providers/data_providers.dart';
import 'package:grow_green_v2/views/sensor_settings_view.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:provider/provider.dart';

class SensorDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DataController dataController = DataController();
    dynamic data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final sensor = data['sensor'];
    final readings = data['reading'];
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Sensor Details'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SensorSettingsView(sensor: sensor);
                    },
                  ),
                );
              },
              icon: Icon(Icons.settings))
        ],
      ),
      body: Center(
        child: Consumer<DatabaseFunctionsProvider>(
            builder: (context, databaseProvider, _) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ChartWidget(readings: readings)),
              ),
              Text('Sensor Id: ' + sensor.sensorId),
              Text('Battery Health: ' +
                  dataController
                      .getMostRecentSensorReading(sensor.sensorId, readings)
                      .batteryHealth
                      .toString()),
              Text('Threshold: ' + sensor.threshold.toString()),
              Text('Display Name: ' + sensor.displayName),
            ],
          );
        }),
      ),
    );
  }
}

class ChartWidget extends StatelessWidget {
  final List<ReadingsModel> readings;
  const ChartWidget({required this.readings});

  List<charts.Series<ReadingsModel, String>> _createChartSeries(
      List<ReadingsModel> readings) {
    return [
      charts.Series<ReadingsModel, String>(
        id: 'Moisture',
        data: readings,
        domainFn: (ReadingsModel reading, _) =>
            reading.timestamp.hour.toString(),
        measureFn: (ReadingsModel reading, _) => reading.moisture,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xFF008080)),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      _createChartSeries(readings),
      animate: true,
      domainAxis: const charts.OrdinalAxisSpec(),
    );
  }
}
