import 'package:flutter/material.dart';
import 'package:clyma/utilities/constants.dart';
import 'package:clyma/services/location.dart';

class WeatherUi extends StatefulWidget {
  final dynamic data;
  const WeatherUi({super.key, this.data});

  @override
  State<WeatherUi> createState() => _WeatherUiState();

}

class _WeatherUiState extends State<WeatherUi> {
  late String description;
  late double temperature;
  late int idd;
  late String temp;



  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      description = widget.data['weather'][0]['main'];
      temperature = widget.data['main']['temp'];
      temp = temperature.toStringAsFixed(0);
      idd = widget.data['weather'][0]['id'];

      String weatherId= Location().getWeatherIcon(idd);

     
      print('description: $description');
      print('temperature: $temperature');
      print('weather id: $idd');
    } else {
      description = "No Data Available";
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
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
                  TextButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {},
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    const Text(
                      'weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  'weatherMessage in cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
