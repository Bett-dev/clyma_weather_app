// ignore_for_file: prefer_const_declarations

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Location {
  // Modify the method to return the weather data
  Future<dynamic> getLocation() async {
    final LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.low,
      distanceFilter: 1000,
    );

    // Request location permission
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print('Location permission denied');
      return null; // Return null if permission is denied
    }

    // Get current position
    Position position =
        await Geolocator.getCurrentPosition(locationSettings: locationSettings);
    print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');

    // Get weather data based on location and return it
    return await locationData(position.latitude, position.longitude);
  }

  // Fetch weather data from OpenWeatherMap API
  Future<dynamic> locationData(double latitude, double longitude) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=&units=metric'));

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      print('Decoded Data: $decodedData'); // Check if this prints correctly
      return decodedData;
    } else {
      print('Error: ${response.statusCode}');
      throw Exception('Failed to get data');
    }
  }

  // Determine the weather icon based on the condition
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

  // Determine a message based on the temperature
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
