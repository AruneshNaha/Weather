import 'dart:ffi';

import 'package:Weather/screens/location_screen.dart';
import 'package:Weather/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:Weather/services/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:Weather/services/weather.dart';

const apiKey = '9f0a339cebea2252ae5bf6b4d1a88ac4';
double latitude, longitude;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Location location = new Location();

  void getLocation() async {
    WeatherModel weatherModel = new WeatherModel();
    var weatherData = await weatherModel.getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SpinKitRotatingCircle(
              color: Colors.white,
              size: 100.0,
            ),
          ),
          Center(
            child: Text(
              "Loading...",
              style: TextStyle(
                fontFamily: 'Spartan MB',
                fontSize: 40.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
