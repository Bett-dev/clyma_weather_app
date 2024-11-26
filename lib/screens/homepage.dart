import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clyma/services/location.dart';
import 'weather.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var weatherData;

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  void fetchWeatherData() async {
    var data = await Location().getLocation(); // Make sure this returns data
    if (!mounted) return;
    setState(() {
      weatherData = data; // Store the fetched data
    });
    print('Weather Data: $weatherData'); // Confirm that we have the data

    if (weatherData != null) {
      // Navigate to the next screen if data is available
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WeatherUi(
            data: weatherData,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.black12,
          size: 50.0,
        ),
      ),
    );
  }
}
