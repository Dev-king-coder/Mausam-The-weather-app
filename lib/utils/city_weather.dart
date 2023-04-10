import 'package:weather/weather.dart';
import 'apikey.dart';

class CityWeather {
  String city;
  CityWeather({required this.city});
  WeatherFactory wf = WeatherFactory(apiKey, language: Language.ENGLISH);
  Future<Weather> getWeather() async {
    Weather cw = await wf.currentWeatherByCityName(city);
    return cw;
  }
}
