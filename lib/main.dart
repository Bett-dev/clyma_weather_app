import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const ClymaApp());
}

class ClymaApp extends StatelessWidget {
  const ClymaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      body: Center(child: TextButton(onPressed: ()async{
        
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(locationSettings: locationSettings);
    print(position.latitude);
      }, child: const Text('get location')),),
    ),
    );
  }
}