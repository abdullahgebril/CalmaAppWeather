
import 'package:calma/services/Location.dart';
import 'package:calma/services/Network.dart';
const apikey = 'fdc83e178241cc4a6b04048717ac56c8';
class WeatherModel {


  Future getCityWeather(String cityName) async{
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$cityName,uk&appid=$apikey&units=metric';
    Network network = Network(url);
    var weatherData = await network.getweatherData();
    return weatherData;
  }
  Future getweatherData() async{
    Location location = Location();
    await location.getLocation();


    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.lat}&lon=${location.long}&appid=$apikey&units=metric';
    Network network = Network(url);
    var weatherData = await network.getweatherData();
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
      return 'Bring a 🧥 just in case';
    }
  }
}
