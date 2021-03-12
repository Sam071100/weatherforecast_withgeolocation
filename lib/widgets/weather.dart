import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherforecast_withgeolocation/model/weatherModel.dart';

class Weather extends StatelessWidget {
  final WeatherData weather;

  Weather({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(weather.name),
        Text(
          weather.main,
          style: new TextStyle(fontSize: 32.0),
        ),
        Text('${weather.temp.toString()}°F'),
        Image.network('https://openweathermap.org/img/w/${weather.icon}.png'),
        Text(new DateFormat.yMMMMd().format(weather.date)),
        Text(new DateFormat.Hm().format(weather.date)),
      ],
    );
  }
}
