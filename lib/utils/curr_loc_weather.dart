import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'apikey.dart';
import 'user_location.dart';

class CurrentWeatherData {
  WeatherFactory wf = WeatherFactory(apiKey, language: Language.ENGLISH);

  UserLocation userLoc = UserLocation();

  Future<Weather> getWeather() async {
    Position position = await userLoc.determinePosition();
    Weather w = await wf.currentWeatherByLocation(
        position.latitude, position.longitude);
    return w;
  }
}
