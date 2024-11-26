import 'package:flutter/material.dart';

class WeatherUi extends StatefulWidget {
  final dynamic data;
  const WeatherUi({super.key, this.data});

  @override
  State<WeatherUi> createState() => _WeatherUiState();
}

class _WeatherUiState extends State<WeatherUi> {
  late String description;
  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      description = widget.data['weather'][0]['main'];
    } else {
      description = "No Data Available";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: Text(description),
        ),
      ),
    );
  }
}

// String description = decodedData['weather'][0]['main'];
//       double temperature = decodedData['main']['temp'];
//       int id = decodedData['weather'][0]['id'];
//       print('description: $description');
//       print('temperature: $temperature');
//       print('weather id: $id');