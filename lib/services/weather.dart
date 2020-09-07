import 'package:Weather/services/location.dart';
import 'package:Weather/services/networking.dart';
import 'package:flutter/cupertino.dart';

const apiKey = '9f0a339cebea2252ae5bf6b4d1a88ac4';
const openWeatherMapUrl = "https://api.openweathermap.org/data/2.5/weather";
Location location = new Location();

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url = '${openWeatherMapUrl}?q=${cityName}&appid=$apiKey&units=metric';

    NetworkHelper networkHelper = new NetworkHelper(url);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    await location.getCurrentLocation();

    NetworkHelper networkHelper = new NetworkHelper(
        '${openWeatherMapUrl}?lat=${location.latitude}&lon=${location.longitude}&appid=${apiKey}&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case you are';
    }
  }

  AssetImage getImage(int condition) {
    AssetImage rain = AssetImage('images/rain.jpg');
    AssetImage thunderStorms = AssetImage('images/thunder.jpg');
    AssetImage cloud = AssetImage('images/location_background.jpg');
    AssetImage haze = AssetImage('images/haze.jpg');
    AssetImage snow = AssetImage('images/snow.jpg');
    AssetImage sunny = AssetImage('images/summer.jpg');
    AssetImage mild = AssetImage('images/mild_summer.jpg');
    AssetImage error = AssetImage('images/location_background.jpg');

    if (condition < 300) {
      return thunderStorms;
    } else if (condition < 400) {
      return cloud;
    } else if (condition < 600) {
      return rain;
    } else if (condition < 700) {
      return snow;
    } else if (condition < 800) {
      return haze;
    } else if (condition == 800) {
      return sunny;
    } else if (condition <= 804) {
      return mild;
    } else {
      return error;
    }
  }
}
