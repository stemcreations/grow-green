import 'package:flutter/material.dart';
import 'package:grow_green_v2/constants.dart';
import 'package:grow_green_v2/controllers/data_controller.dart';
import 'package:grow_green_v2/models/readings_model.dart';
import 'package:grow_green_v2/providers/data_providers.dart';
import 'package:grow_green_v2/widgets/custom_widgets.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DataController dataController = DataController();
    var dataProvider = Provider.of<DatabaseFunctionsProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(context),
      body: dataProvider.sensorList.isEmpty
          ? Builder(builder: (context) {
              dataProvider.getSensorList();
              return Center(
                child: CircularProgressIndicator(),
              );
            })
          : Consumer<DatabaseFunctionsProvider>(
              builder: (context, databaseProvider, _) {
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: Provider.of<DatabaseFunctionsProvider>(context,
                          listen: false)
                      .sensorList
                      .length,
                  itemBuilder: (BuildContext context, int index) {
                    List<ReadingsModel> readings =
                        Provider.of<DatabaseFunctionsProvider>(context,
                                    listen: false)
                                .readingsList ??
                            [];
                    var sensor = Provider.of<DatabaseFunctionsProvider>(context,
                            listen: false)
                        .sensorList[index];
                    return GestureDetector(
                      onTap: () {
                        var sensorReadings = dataController.getSensorReadings(
                            sensor.sensorId, readings);
                        Navigator.pushNamed(context, sensorDetails, arguments: {
                          'sensor': Provider.of<DatabaseFunctionsProvider>(
                                  context,
                                  listen: false)
                              .sensorList[index],
                          'reading': sensorReadings
                        });
                      },
                      child: Card(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      sensor.displayName,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .outline),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0, right: 5),
                                    child: Visibility(
                                      visible: dataController
                                              .getMostRecentSensorReading(
                                                  sensor.sensorId, readings)
                                              .moisture <
                                          sensor.threshold,
                                      child: Icon(
                                        Icons.water_drop,
                                        size: 30,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Image.asset(
                              sensor.sensorId.toLowerCase().contains('zone')
                                  ? 'assets/garden.png'
                                  : 'assets/plant.png',
                              height: 100,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            Text(dataController
                                .getMostRecentSensorReading(
                                    sensor.sensorId, readings)
                                .moisture
                                .toString()),
                            sensor.runtimeType.toString() == "GTZoneModel"
                                ? Text(kZones[sensor.pin])
                                : Container(),
                          ],
                        ),
                      ),
                    );
                  });
            }),
    );
  }
}
