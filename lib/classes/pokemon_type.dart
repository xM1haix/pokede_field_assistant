import "dart:convert";

import "package:pokede_field_assistant/classes/pokemon.dart" show getValue;
import "package:pokede_field_assistant/extensions/string.dart";
import "package:pokede_field_assistant/others/http_request.dart";

enum PokemonType {
  normal(1),
  fighting(2),
  flying(3),
  poison(4),
  ground(5),
  rock(6),
  bug(7),
  ghost(8),
  steel(9),
  fire(10),
  water(11),
  grass(12),
  electric(13),
  psychic(14),
  ice(15),
  dragon(16),
  dark(17),
  fairy(18),
  stellar(19),
  unknown(10001),
  shadow(10002);

  const PokemonType(this.id);
  final int id;

  String get url => "https://pokeapi.co/api/v2/type/$id/";
  Future<List<int>> getPokemonIds() async {
    final api = await callAPI(url);
    final decodedApi = jsonDecode(api) as Map<String, dynamic>;
    if (!decodedApi.containsKey("pokemon")) {
      return [];
    }
    final rawPokemons = decodedApi["pokemon"] as List;
    final ids = <int>[];
    for (final Map<String, dynamic> e in rawPokemons) {
      final rawPokemon = e["pokemon"] as Map<String, dynamic>;
      final url = getValue<String>(data: rawPokemon, key: "url", id: 0);
      final id = url.getTheId();
      if (id != null) {
        ids.add(id);
      }
    }
    return ids;
  }
}
