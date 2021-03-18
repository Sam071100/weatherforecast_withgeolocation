import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weatherforecast_withgeolocation/model/forecastModel.dart';
import 'package:weatherforecast_withgeolocation/model/weatherModel.dart';
import 'package:weatherforecast_withgeolocation/widgets/weather.dart';
import 'package:weatherforecast_withgeolocation/widgets/weatherItem.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool isLoading = false;
  WeatherData weatherData;
  ForecastData forecastData;
  String myvar = 'visakhapatnam';
  int counter = 0;
  String citi;
  void setCiti() {
    setState(() {
      counter++;
      citi = myvar;
      loadWeather();
    });
  }

  loadWeather() async {
    setState(() {
      isLoading = true;
    });
    Position position;
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
    } catch (e) {
      print(e);
    }

    if (position != null && counter == 0) {
      final lat = position.latitude;
      final lon = position.longitude;

      final weatherResponse = await http.get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=7c527bceebadff9006977cf598974a9f&units=metric'));

      final forecastResponse = await http.get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=7c527bceebadff9006977cf598974a9f&units=metric'));

      if (weatherResponse.statusCode == 200 &&
          forecastResponse.statusCode == 200) {
        return setState(() {
          weatherData =
              new WeatherData.fromJson(jsonDecode(weatherResponse.body));
          forecastData =
              new ForecastData.fromJson(jsonDecode(forecastResponse.body));
          isLoading = false;
        });
      }
    } else {
      final weatherResponse = await http.get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/weather?q=$citi&appid=7c527bceebadff9006977cf598974a9f&units=metric'));

      final forecastResponse = await http.get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/forecast?q=$citi&appid=7c527bceebadff9006977cf598974a9f&units=metric'));

      if (weatherResponse.statusCode == 200 &&
          forecastResponse.statusCode == 200) {
        return setState(() {
          weatherData =
              new WeatherData.fromJson(jsonDecode(weatherResponse.body));
          forecastData =
              new ForecastData.fromJson(jsonDecode(forecastResponse.body));
          isLoading = false;
        });
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (text) {
                  myvar = text;
                },
                maxLines: 1,
                decoration: InputDecoration(
                    hintText: 'Enter City Name',
                    labelText: 'City',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.location_city_rounded,
                      color: Colors.black,
                    )),
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
            ),
            ElevatedButton(
              onPressed: setCiti,
              child: Text('Search'),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: weatherData != null
                        ? Weather(weather: weatherData)
                        : Container(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: isLoading
                        ? CircularProgressIndicator(
                            strokeWidth: 2.0,
                            valueColor: new AlwaysStoppedAnimation(Colors.red),
                          )
                        : IconButton(
                            icon: new Icon(Icons.refresh),
                            splashColor: Colors.cyan,
                            tooltip: 'Refresh',
                            onPressed: loadWeather,
                            color: Colors.black,
                          ),
                  ),
                ],
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200.0,
                  child: forecastData != null
                      ? Expanded(
                          child: ListView.builder(
                              itemCount: forecastData.list.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => WeatherItem(
                                  weather: forecastData.list.elementAt(index))),
                        )
                      : Container(
                          child: Text(
                            "Weather APP\n version: 1.0",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25.0,
                                fontFamily: "Times New Roman",
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
