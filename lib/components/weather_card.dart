import 'package:flutter/material.dart';

class WeatherCard extends StatefulWidget {
  final String? cityName;
  final String? weatherDescription;
  final String? temperature;
  final String? dateNtime;
  final String? sunset;
  const WeatherCard({
    super.key,
    this.cityName,
    this.weatherDescription,
    this.temperature,
    this.dateNtime,
    this.sunset,
  });

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  @override
  Widget build(BuildContext context) {
    String? currentTime = widget.dateNtime?.substring(11, 13) ?? "0";
    int? time = int.parse(currentTime);
    String? sunsetTime = widget.sunset?.substring(11, 13) ?? "0";
    int? sunset = int.parse(sunsetTime);
    String asset = "lib/assets/images/";
    if (time > sunset ||
        widget.weatherDescription == "broken clouds" ||
        widget.weatherDescription == "scattered clouds" ||
        widget.weatherDescription == "mist" ||
        widget.weatherDescription == "shower rain" ||
        widget.weatherDescription == "thunderstorm" ||
        widget.weatherDescription == "snow") {
      switch (widget.weatherDescription!) {
        case "clear sky":
          asset += "clear_sky_night.png";
          break;
        case "few clouds":
          asset += "few_clouds_night.png";
          break;
        case "scattered clouds":
          asset += "scattered_clouds.png";
          break;
        case "broken clouds":
          asset += "broken_clouds.png";
          break;
        case "shower rain":
          asset += "shower_rain.png";
          break;
        case "rain":
          asset += "rain_night.png";
          break;
        case "thunderstorm":
          asset += "thunderstorm.png";
          break;
        case "snow":
          asset += "snow.png";
          break;
        case "mist":
          asset += "mist.png";
          break;
        default:
          asset += "clear_sky_night.png";
      }
    } else {
      switch (widget.weatherDescription) {
        case "clear sky":
          asset += "clear_sky_day.png";
          break;
        case "few clouds":
          asset += "few_clouds_day.png";
          break;
        case "rain":
          asset += "rain_day.png";
          break;
        default:
          asset += "clear_sky_day.png";
      }
    }
    return Padding(
      padding: const EdgeInsets.only(top: 70, right: 10, left: 10),
      child: Column(
        children: [
          TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.location_pin),
              label: const Text('Current Weather of your Location')),
          Container(
            child: (widget.cityName != null &&
                    widget.weatherDescription != null &&
                    widget.temperature != null)
                ? SizedBox(
                    child: Card(
                    color: (time > sunset) ? Colors.blueGrey : Colors.blue,
                    child: ListTile(
                      leading: Image.asset(
                        asset,
                        height: 100,
                        width: 50,
                      ),
                      title: Text(widget.cityName!),
                      subtitle: Text(widget.weatherDescription!),
                      trailing: Text(widget.temperature!),
                    ),
                  ))
                : Center(
                    child: Column(children: const [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 2.0,
                      ),
                      Text("Retrieving Mausam..."),
                    ]),
                  ),
          ),
        ],
      ),
    );
  }
}
