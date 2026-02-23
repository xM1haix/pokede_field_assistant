import "dart:convert";

import "package:pokede_field_assistant/classes/coords.dart";
import "package:pokede_field_assistant/classes/pokemon_type.dart";
import "package:pokede_field_assistant/others/http_request.dart";

class OpenMetro {
  OpenMetro({
    required this.temperature,
    required this.windspeed,
    required this.weatherCode,
  });
  factory OpenMetro.fromJson(Map<String, dynamic> json) {
    final current = json["current_weather"];
    return OpenMetro(
      temperature: current["temperature"].toDouble(),
      windspeed: current["windspeed"].toDouble(),
      weatherCode: current["weathercode"],
    );
  }
  static const _baseUrl = "https://api.open-meteo.com/v1/forecast";
  final double temperature;
  final double windspeed;
  final int weatherCode;
  PokemonType get toPokemonType {
    // 1. Extreme Weather First (Electric & Ice)
    if (weatherCode >= 95) return PokemonType.electric;
    if (weatherCode >= 71 && weatherCode <= 77) return PokemonType.ice;
    if (temperature < 0) return PokemonType.ice;

    // 2. High Wind (Flying / Dragon)
    if (windspeed > 30) return PokemonType.dragon;
    if (windspeed > 20) return PokemonType.flying;

    // 3. Precipitation (Water / Bug)
    if (weatherCode >= 51 && weatherCode <= 67) {
      return (temperature > 20) ? PokemonType.bug : PokemonType.water;
    }
    if (weatherCode >= 80 && weatherCode <= 82) return PokemonType.water;

    // 4. Atmospheric Conditions (Poison / Ghost / Dark)
    if (weatherCode == 45 || weatherCode == 48) return PokemonType.poison;
    if (weatherCode == 3) return PokemonType.ghost; // Overcast/Gloomy

    // 5. Sky Clarity & Temperature (Fire / Grass / Ground / Rock)
    if (weatherCode == 0) {
      // Clear Sky
      if (temperature > 30) return PokemonType.fire;
      if (temperature > 15) return PokemonType.grass;
      return PokemonType.fairy; // Clear but cool/crisp
    }

    if (weatherCode == 1 || weatherCode == 2) {
      // Partly Cloudy
      if (temperature > 25) return PokemonType.ground;
      if (temperature < 10) return PokemonType.steel;
      return PokemonType.normal;
    }

    // 6. Special/Rare Types (Stellar, Psychic, Fighting, etc.)
    // We can map these to specific niche ranges
    if (temperature > 35) return PokemonType.stellar; // Extreme Heat
    if (weatherCode == 2 && windspeed < 5)
      return PokemonType.psychic; // Calm/Serene
    if (weatherCode == 1 && temperature > 20) return PokemonType.fighting;
    if (temperature < 5) return PokemonType.dark;

    return PokemonType.unknown;
  }

  static Future<PokemonType> getPokemoType(Coords coords) async {
    final weather = await getWeather(coords);
    return weather.toPokemonType;
  }

  static Future<OpenMetro> getWeather(Coords coords) async {
    try {
      final response = await callAPI(
        "$_baseUrl?latitude=${coords.latitude}&longitude=${coords.longitude}&current_weather=true",
      );
      final data = jsonDecode(response) as Map<String, dynamic>;
      return OpenMetro.fromJson(data);
    } catch (e) {
      throw Exception("Network error: $e");
    }
  }
}
