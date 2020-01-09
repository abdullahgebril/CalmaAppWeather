import 'package:flutter/material.dart';
import 'package:calma/uitilities/constants.dart';

import 'package:calma/screens/city_screen.dart';
import 'package:calma/services/weather.dart';

class LocationScreen extends StatefulWidget {
  final weatherData;
  LocationScreen(this.weatherData);
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  @override
  void initState() {
    super.initState();
    updateui(widget.weatherData);
  }

  var cityname;
  int tempurature;
  String weatherIcoon;
  String message;

  void updateui(final weatherData) {
    setState(() {
      if (weatherData == null) {
        cityname = '';
        tempurature = 0;
        message = '';
        weatherIcoon = '';
        return;
      }
      cityname = weatherData['name'];
      double temp = weatherData['main']['temp'];
      tempurature = temp.toInt();
      message = weatherModel.getMessage(tempurature);
      var condtion = weatherData['weather'][0]['id'];
      weatherIcoon = weatherModel.getWeatherIcon(condtion);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
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
                  FlatButton(
                    onPressed: () {
                      var weatgerData = weatherModel.getweatherData();
                      updateui(weatgerData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: ()async {
                     var cityname = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CityScreen(),
                        ),
                      );
                     if(cityname !=null) {
                       var cityweatherData = await weatherModel.getCityWeather(cityname);
                       updateui(cityweatherData);
                     }

                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${tempurature}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcoon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$message in $cityname!",
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
