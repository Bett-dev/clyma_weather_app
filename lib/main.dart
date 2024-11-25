import 'package:flutter/material.dart';
import 'package:clyma/screens/homepage.dart';



void main() {
  runApp(const ClymaApp());
}

class ClymaApp extends StatelessWidget {
  const ClymaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Homepage(),
    );
  }
}
