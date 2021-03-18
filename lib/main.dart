import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherforecast_withgeolocation/screens/splashScreen.dart';
import 'package:weatherforecast_withgeolocation/theme/theme.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
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
