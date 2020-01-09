import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:calma/services/weather.dart';

import 'package:calma/screens/Loction_screen.dart';



class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double lat, long;
  @override
  void initState() {
    super.initState();
    getloaction();
  }

  void getloaction() async {


    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getweatherData();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationScreen(weatherData),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SpinKitRotatingCircle(
      color: Colors.white,
      size: 50.0,
    )));
  }
}
