// ignore_for_file: prefer_const_declarations

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Location {
  getLocation() async {
    final LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.low,
      distanceFilter: 1000,
    );
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print('Location permission denied');
      return;
    }
    Position position =
        await Geolocator.getCurrentPosition(locationSettings: locationSettings);
    print(position.latitude);
    print(position.longitude);

    await locationData(position.latitude, position.longitude);
  }

  Future<dynamic> locationData(double latitude, double longitude) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=f7ca1a9673f99dec796fba6c3484352f&units=metric'));
    if (response.statusCode == 200) {
      print(response.body);
      var decodedData = jsonDecode(response.body);

      String description = decodedData['weather'][0]['main'];
      double temperature = decodedData['main']['temp'];
      int id = decodedData['weather'][0]['id'];
      print('description: $description');
      print('temperature: $temperature');
      print('weather id: $id');
      return response.body;
    } else {
      throw Exception('Failed to get data');
    }
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
      return 'Bring a 🧥 just in case';
    }
  }
}
