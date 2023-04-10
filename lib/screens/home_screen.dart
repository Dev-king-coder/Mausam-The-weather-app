import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import '../utils/curr_loc_weather.dart';
import '../components/weather_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Weather? weatherData;
  void getWeather() async {
    CurrentWeatherData currWeather = CurrentWeatherData();
    weatherData = await currWeather.getWeather();
    setState(() {
      weatherData = weatherData;
    });
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Mausam-The Weather App'),
      //   backgroundColor: Colors.black,
      // ),
      body: WeatherCard(
        cityName: weatherData?.areaName,
        weatherDescription: weatherData?.weatherDescription,
        temperature: weatherData?.temperature.toString(),
        dateNtime: weatherData?.date.toString(),
        sunset: weatherData?.sunset.toString(),
      ),
    );
  }
}
