import "dart:convert";

import "package:pokede_field_assistant/classes/bookmarks.dart";
import "package:pokede_field_assistant/classes/parameters.dart";
import "package:pokede_field_assistant/extensions/string.dart";
import "package:pokede_field_assistant/others/http_request.dart";

class SimplePokemon {
  SimplePokemon({
    required this.id,
    required this.url,
    required this.name,
    required this.type,
    required this.imageUrl,
    required this.isBookmarked,
  });
  static var _counter = 0;
  static const apiURL = "https://pokeapi.co/api/v2/pokemon/";
  static final List<int> _haveError = [];
  static int get counter => _counter;
  static List<int> get haveError => _haveError;
  final String name;
  final int id;
  final String type;
  final String url;
  final String imageUrl;
  bool isBookmarked;
  Future<bool> switchBookmark() async =>
      BookmarkService.instance.switchBookmark(name, isBookmarked: isBookmarked);
  @override
  String toString() =>
      "Pokemon(id:$id,type:$type,imageUrl:$imageUrl,name:$name,url:$url,isBookmarked:$isBookmarked)";

  static Future<List<SimplePokemon>> searchByName(
    Parameters parameters,
    String searchedName,
  ) async {
    try {
      final newParameters = searchedName.isEmpty
          ? parameters
          : Parameters(limit: 2000);
      final apiCall = await callAPI(
        "https://pokeapi.co/api/v2/pokemon/",
        newParameters,
      );
      final decodedResponse = jsonDecode(apiCall) as Map<String, dynamic>;
      List rawPokemonDataList = decodedResponse["results"];
      if (searchedName.isNotEmpty) {
        rawPokemonDataList = rawPokemonDataList.where((e) {
          final name = (e["name"] as String).toLowerCase();
          return name.contains(searchedName.toLowerCase());
        }).toList();
      }

      final futures = rawPokemonDataList.map((e) async {
        final url = e["url"] as String;
        final id = int.parse(url.split("/").where((e) => e.isNotEmpty).last);
        final fullData = await callAPI(
          "https://pokeapi.co/api/v2/pokemon/$id/",
          Parameters(),
        );
        final details = jsonDecode(fullData);
        final name = e["name"] as String;
        final image =
            details["sprites"]["other"]["official-artwork"]["front_default"];
        if (image == null) {
          _haveError.add(id);
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
      final pokemonsList = results.whereType<SimplePokemon>().toList();
      _counter = searchedName.isEmpty
          ? decodedResponse["count"]
          : pokemonsList.length;
      if (searchedName.isEmpty) {
        _counter = decodedResponse["count"];
        return pokemonsList;
      }
      _counter = pokemonsList.length;
      final limit = parameters.limit ?? 100;
      final page = parameters.page ?? 0;
      final start = page * limit;
      final end = start + limit;
      if (start >= pokemonsList.length) {
        return [];
      }
      return pokemonsList.sublist(
        start,
        end > pokemonsList.length ? pokemonsList.length : end,
      );
    } catch (e) {
      rethrow;
    }
  }
}
