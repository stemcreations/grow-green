import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grow_green_v2/constants.dart';
import 'package:grow_green_v2/controllers/data_controller.dart';
import 'package:grow_green_v2/providers/data_providers.dart';
import 'package:provider/provider.dart';

class SensorSettingsView extends StatelessWidget {
  final dynamic sensor;
  SensorSettingsView({this.sensor, super.key});
  @override
  Widget build(BuildContext context) {
    DataController dataController = DataController();
    String newDisplayName = '';
    int newThreshold = 0;
    int selectedPin = 4;
    if (sensor.runtimeType.toString() == 'GTZoneModel') {
      selectedPin = sensor.pin;
    }

    void updatedSelectedZone(int value) {
      selectedPin = value;
    }

    return Scaffold(
      appBar: AppBar(
          title: Text('Sensor Settings'),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Center(
        child: Consumer<DatabaseFunctionsProvider>(
            builder: (context, databaseProvider, _) {
          return Column(
            children: [
              ListTile(
                title: Text('Display Name: ' + sensor.displayName),
                subtitle: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Set Display Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a display name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    newDisplayName = value;
                  },
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.save,
                    size: 45,
                    color: Color(0xFF008080),
                  ),
                  onPressed: () async {
                    await dataController.updateSensorDisplayName(
                        sensor.sensorId, newDisplayName);
                    sensor.displayName = newDisplayName;
                    sensor.notifyListeners();
                    await databaseProvider.getSensorList();
                  },
                ),
              ),
              ListTile(
                title: Text('Threshold: ' + sensor.threshold.toString()),
                subtitle: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Set Threshold',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a threshold';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    newThreshold = int.parse(value);
                  },
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.save,
                    size: 45,
                    color: Color(0xFF008080),
                  ),
                  onPressed: () async {
                    await dataController.updateSensorThreshold(
                        sensor.sensorId, newThreshold);
                    sensor.threshold = newThreshold;
                    sensor.notifyListeners();
                    await databaseProvider.getSensorList();
                  },
                ),
              ),
              sensor.runtimeType.toString() == 'GTZoneModel'
                  ? ListTile(
                      title: Text(kZones[sensor.pin]),
                      subtitle: DropdownButton(
                        value: selectedPin,
                        onChanged: (value) async {
                          updatedSelectedZone(value as int);
                          databaseProvider.notifyListeners();
                        },
                        items: kZoneNamesToPin.keys.map((key) {
                          return DropdownMenuItem(
                            child: Text(key),
                            value: kZoneNamesToPin[key],
                          );
                        }).toList(),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.save,
                          size: 45,
                          color: Color(0xFF008080),
                        ),
                        onPressed: () async {
                          await dataController.updateZonePin(
                              sensor.sensorId, selectedPin);
                          sensor.pin = selectedPin;
                          sensor.notifyListeners();
                          await databaseProvider.getSensorList();
                        },
                      ),
                    )
                  : Container()
            ],
          );
        }),
      ),
    );
  }
}
