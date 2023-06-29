import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grow_green_v2/constants.dart';
import 'package:grow_green_v2/controllers/data_controller.dart';
import 'package:grow_green_v2/providers/data_providers.dart';
import 'package:provider/provider.dart';

class SensorSettingsView extends StatelessWidget {
  dynamic sensor;
  SensorSettingsView({this.sensor, super.key});
  @override
  Widget build(BuildContext context) {
    DataController dataController = DataController();
    //dynamic sensor = ModalRoute.of(context)?.settings.arguments;
    String newDisplayName = '';
    int newThreshold = 0;
    int newPin = 0;
    return Scaffold(
      appBar: AppBar(
          title: Text('Sensor Settings'),
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
                  onPressed: () {},
                ),
              ),
              sensor.runtimeType.toString() == 'GTZoneModel'
                  ? ListTile(
                      title: Text(kZones[sensor.pin]),
                      subtitle: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Set Zone',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a zone';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          newPin = int.parse(value);
                        },
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.save,
                          size: 45,
                          color: Color(0xFF008080),
                        ),
                        onPressed: () {},
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
