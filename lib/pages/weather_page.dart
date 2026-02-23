import "package:flutter/material.dart";
import "package:pokede_field_assistant/classes/coords.dart";
import "package:pokede_field_assistant/classes/open_metro.dart";
import "package:pokede_field_assistant/widgets/custom_future_builder.dart";

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _coords = Coords(0, 0);
  late Future<WeatherData> _future;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: setCoords),
      appBar: AppBar(),
      body: CustomFutureBuilder(
        future: _future,
        success: (context, x) => ListView(
          children: [
            ListTile(title: Text("temperature:${x.temperature}")),
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

  Future<void> setCoords() async {
    final newCoords = await Coords.popupCoords(context, _coords);
    setState(() {
      _coords.reset(newCoords);
      _init();
    });
  }

  void _init() {
    _future = WeatherService().fetchCurrentWeather(_coords);
  }
}
