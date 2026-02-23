import "dart:convert";

import "package:pokede_field_assistant/classes/bookmarks.dart";
import "package:pokede_field_assistant/classes/parameters.dart";
import "package:pokede_field_assistant/classes/pokemon/simple_pokemon.dart";
import "package:pokede_field_assistant/others/http_request.dart";

class PokemonType {
  const PokemonType({required this.name, required int url}) : _url = url;
  static const pokemonTypes = <PokemonType>[
    PokemonType(name: "normal", url: 1),
    PokemonType(name: "fighting", url: 2),
    PokemonType(name: "flying", url: 3),
    PokemonType(name: "poison", url: 4),
    PokemonType(name: "ground", url: 5),
    PokemonType(name: "rock", url: 6),
    PokemonType(name: "bug", url: 7),
    PokemonType(name: "ghost", url: 8),
    PokemonType(name: "steel", url: 9),
    PokemonType(name: "fire", url: 10),
    PokemonType(name: "water", url: 11),
    PokemonType(name: "grass", url: 12),
    PokemonType(name: "electric", url: 13),
    PokemonType(name: "psychic", url: 14),
    PokemonType(name: "ice", url: 15),
    PokemonType(name: "dragon", url: 16),
    PokemonType(name: "dark", url: 17),
    PokemonType(name: "fairy", url: 18),
    PokemonType(name: "stellar", url: 19),
    PokemonType(name: "unknown", url: 10001),
    PokemonType(name: "shadow", url: 10002),
  ];
  final String name;
  final int _url;
  String get url => "https://pokeapi.co/api/v2/type/$_url/";
  Future<List<SimplePokemon>> getPokemons() async {
    final getFullTypeData = await callAPI(url, Parameters());
    final decoded = jsonDecode(getFullTypeData) as Map<String, dynamic>;
    if (!decoded.containsKey("pokemon")) {
      throw "There are no pokemons for htis type";
    }
    final pokemonList = decoded["pokemon"] as List;

    final pokemonUrls = <String>[];
    for (final Map<String, dynamic> pokemon in pokemonList) {
      if (pokemon.containsKey("url")) {
        pokemonUrls.add(pokemon["url"] as String);
      } else {
        print("No url in $pokemon");
      }
    }
    final futures = pokemonUrls.map((e) async {
      final url = e;
      final id = int.parse(url.split("/").where((e) => e.isNotEmpty).last);
      final fullData = await callAPI(e, Parameters());
      final details = jsonDecode(fullData);
      final name = details["name"];
      final image =
          details["sprites"]["other"]["official-artwork"]["front_default"];
      if (image == null) {
        print({e: details});
        return null;
      }
      return SimplePokemon(
        id: id,
        url: url,
        name: name.capitalizeFirst,
        isBookmarked: BookmarkService.instance.isBookmark(name),
        type: (details["types"][0]["type"]["name"] as String).toUpperCase(),
        imageUrl:
            details["sprites"]["other"]["official-artwork"]["front_default"],
      );
    }).toList();

    final results = await Future.wait(futures);
    return results.whereType<SimplePokemon>().toList();
  }
}
