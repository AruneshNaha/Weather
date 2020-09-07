import 'dart:ui';
import 'dart:io';

import 'package:Weather/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:Weather/utilities/constants.dart';
import 'package:Weather/services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({@required this.locationWeather});
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = new WeatherModel();
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  var windspeed;
  int temperature, temp_min, temp_max;
  String weatherMessage;
  String weatherIcon;
  int condition;
  String cityName;
  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = "Error";
        weatherMessage = "Error in fetching data! Check internet connection!";
        cityName = "null";
        windspeed = "NIL";
        temp_max = 0;
        temp_min = 0;
        return;
      }
      condition = weatherData['weather'][0]['id'];
      windspeed = weatherData['wind']['speed'];
      var min = weatherData['main']['temp_min'];
      var max = weatherData['main']['temp_max'];
      temp_min = min.toInt();
      temp_max = max.toInt();
      var temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      cityName = weatherData['name'];
      weatherMessage = weatherModel.getMessage(temperature);
      weatherIcon = weatherModel.getWeatherIcon(condition);
    });
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Are you sure you want to exit the app?"),
        actions: [
          FlatButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text("No")),
          FlatButton(
              onPressed: () {
                exit(0);
              },
              child: Text("Yes"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: weatherModel.getImage(condition),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop),
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: [
                        FlatButton(
                          onPressed: () async {
                            var weatherData =
                                await weatherModel.getLocationWeather();
                            updateUI(weatherData);
                          },
                          child: Icon(
                            Icons.near_me,
                            size: 50.0,
                          ),
                        ),
                        Text(
                          "My location",
                          style: TextStyle(
                            fontFamily: 'Spartan MB',
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Image(
                          image: AssetImage(
                            "images/windmill.png",
                          ),
                          height: 50.0,
                        ),
                        Text(
                          "$windspeed km/h",
                          style: TextStyle(
                            fontFamily: 'Spartan MB',
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        FlatButton(
                          onPressed: () async {
                            var typedName = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return CityScreen();
                                },
                              ),
                            );
                            if (typedName != null) {
                              var weatherData =
                                  await weatherModel.getCityWeather(typedName);
                              updateUI(weatherData);
                            }
                          },
                          child: Icon(
                            Icons.location_city,
                            size: 50.0,
                          ),
                        ),
                        Text(
                          "Search a city",
                          style: TextStyle(
                            fontFamily: 'Spartan MB',
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Icon(Icons.wb_sunny),
                        Text(
                          "Maximum",
                          style: TextStyle(
                            fontFamily: 'Spartan MB',
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          '$temp_max°C',
                          style: TextStyle(
                              fontFamily: 'Spartan MB', fontSize: 40.0),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.cloud),
                        Text(
                          "Minimum",
                          style: TextStyle(
                            fontFamily: 'Spartan MB',
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          '$temp_min°C',
                          style: TextStyle(
                              fontFamily: 'Spartan MB', fontSize: 40.0),
                        )
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        '$temperature°C',
                        style: kTempTextStyle,
                      ),
                      Text(
                        '${weatherIcon}',
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    "${weatherMessage} in $cityName!",
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Copyright "),
                        Icon(Icons.copyright),
                        Text(" Naha's codebase")
                      ],
                    ),
                    Text("Developer: Arunesh Naha")
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// var condition = jsonDecode(data)['weather'][0]['id'];
// var temperature = jsonDecode(data)['main']['temp'];
// var city = jsonDecode(data)['name'];
