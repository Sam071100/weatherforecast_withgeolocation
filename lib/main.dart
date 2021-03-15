import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherforecast_withgeolocation/screens/splashScreen.dart';
import 'package:weatherforecast_withgeolocation/theme/theme.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Weather App',
      theme: lighttheme(),
      darkTheme: darktheme(),
      themeMode: ThemeMode.system,
      home: Splashscreen(),
    );
  }
}
