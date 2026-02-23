import "dart:convert";

import "package:http/http.dart" as http;
import "package:pokede_field_assistant/classes/coords.dart";

class WeatherData {
  WeatherData({
    required this.latitude,
    required this.longitude,
    required this.temperature,
    required this.windspeed,
    required this.weatherCode,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final current = json["current_weather"];
    return WeatherData(
      latitude: json["latitude"],
      longitude: json["longitude"],
      temperature: current["temperature"],
      windspeed: current["windspeed"],
      weatherCode: current["weathercode"],
    );
  }
  final double latitude;
  final double longitude;
  final double temperature;
  final double windspeed;
  final int weatherCode;
}

class WeatherService {
  static const _baseUrl = "https://api.open-meteo.com/v1/forecast";

  Future<WeatherData> fetchCurrentWeather(Coords coords) async {
    final url = Uri.parse(
      "$_baseUrl?latitude=${coords.latitude}&longitude=${coords.longitude}&current_weather=true",
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return WeatherData.fromJson(data);
      } else {
        throw Exception("Failed to load weather: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Network error: $e");
    }
  }
}
