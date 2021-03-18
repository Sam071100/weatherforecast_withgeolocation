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
        Text(
          weather.name,
          style: TextStyle(
              fontFamily: 'Times New Roman',
              fontWeight: FontWeight.w500,
              fontSize: 20.0),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 4.0),
          child: Text(
            weather.main,
            style: new TextStyle(fontSize: 32.0),
          ),
        ),
        Text(
          '${(weather.temp).toString()}°C',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w400, fontSize: 18.0),
        ),
        Image.network('https://openweathermap.org/img/w/${weather.icon}.png'),
        Text(
          new DateFormat.yMMMMd().format(weather.date),
          style: TextStyle(fontSize: 16.0),
        ),
        Text(
          new DateFormat.Hm().format(weather.date),
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }
}
