import 'package:flutter/material.dart';
import 'package:mausam/utils/city_weather.dart';
import 'package:weather/weather.dart';
import '../utils/curr_loc_weather.dart';
import '../components/weather_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String city = '';
  final myController = TextEditingController();

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
  void dispose() {
    myController.dispose();
    super.dispose();
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
        floatingActionButton: FloatingActionButton(
          onPressed: () => showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return inputSheet();
              }),
          backgroundColor: Colors.blueAccent,
          child: const Icon(Icons.add),
        ));
  }

  Widget inputSheet() {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 200,
          width: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  controller: myController,
                  decoration: const InputDecoration(
                    label: Text('City Name'),
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  city = myController.text.trim();
                  myController.clear();
                  CityWeather cityWeather = CityWeather(city: city);
                  cityWeather.getWeather().then((value) {
                    setState(() => weatherData = value);
                    // App Currently adds only one city at a time at the top of the current location weather card
                    // Future Work: display cities weather in a list view.
                    // retain the current location weather card at the top of the list view.
                    // add a delete button to delete the city weather card from the list view.
                    // using sqlite or flutter firestore to store the cities data as per the current user.
                    // refactoring the code to make it more readable and maintainable.
                    WeatherCard(
                      cityName: value.areaName,
                      weatherDescription: value.weatherDescription,
                      temperature: value.temperature.toString(),
                      dateNtime: value.date.toString(),
                      sunset: value.sunset.toString(),
                    );
                  });
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: const Text(
                  'Add City',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
