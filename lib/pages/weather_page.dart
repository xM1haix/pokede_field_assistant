import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:pokede_field_assistant/classes/open_metro.dart";
import "package:pokede_field_assistant/widgets/custom_future_builder.dart";

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  var lat = 45.4;
  var lon = 54.5;
  final _controllerLatitude = TextEditingController();
  final _controllerLongitude = TextEditingController();
  late Future<WeatherData> _future;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomFutureBuilder(
        future: _future,
        success: (context, x) => ListView(
          children: [
            TextField(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // allow digits only
              ],
              keyboardType: TextInputType.number,

              controller: _controllerLatitude,
              decoration: const InputDecoration(hintText: "latitude"),
            ),
            TextField(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // allow digits only
              ],
              keyboardType: TextInputType.number,

              controller: _controllerLongitude,
              decoration: const InputDecoration(hintText: "longitude"),
            ),
            ListTile(title: Text("latitude:${x.latitude}")),
            ListTile(title: Text("longitude:${x.longitude}")),
            ListTile(title: Text("temperature:${x.temperature}")),
            ListTile(title: Text("weatherCode:${x.weatherCode}")),
            ListTile(title: Text("windspeed:${x.windspeed}")),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    _future = WeatherService().fetchCurrentWeather(lat, lon);
  }
}
