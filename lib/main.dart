import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grow_green_v2/constants.dart';
import 'package:grow_green_v2/providers/data_providers.dart';
import 'package:grow_green_v2/views/home_view.dart';
import 'package:grow_green_v2/views/sensor_details_view.dart';
import 'package:grow_green_v2/views/sensor_settings_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ref.watch(readingsProvider);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DatabaseFunctionsProvider>(
            create: (_) => DatabaseFunctionsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Green Thumb',
        initialRoute: home,
        routes: {
          home: (context) => HomeView(),
          sensorDetails: (context) => SensorDetailsView(),
          sensorSettings: (context) => SensorSettingsView(),
        },
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
          textTheme: GoogleFonts.quicksandTextTheme(),
        ),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
          textTheme: GoogleFonts.quicksandTextTheme(),
        ),
      ),
    );
  }
}
