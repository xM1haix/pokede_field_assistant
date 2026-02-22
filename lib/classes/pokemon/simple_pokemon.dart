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
  static const apiURL = "pokemon";
  static int get counter => _counter;
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
  static Future<List<SimplePokemon>> readAll(Parameters parameters) async {
    try {
      final apiCall = await callAPI(apiURL, parameters);
      final decodedReponse = jsonDecode(apiCall) as Map<String, dynamic>;
      _counter = decodedReponse["count"];
      final rawPokemonDataList = decodedReponse["results"] as List;
      final futures = rawPokemonDataList.map((e) async {
        final url = e["url"];
        final id = int.parse(
          (url as String).split("/").where((e) => e.isNotEmpty).last,
        );
        final fullData = await callAPI("pokemon/$id/", Parameters());
        final details = jsonDecode(fullData);
        final name = e["name"] as String;
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
      final allPokemon = await Future.wait(futures);
      return allPokemon;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<SimplePokemon>> readBookmarks(
    Parameters parameters,
  ) async {
    try {
      final bookmarks = BookmarkService.instance.getAll();
      if (bookmarks.isEmpty) {
        return [];
      }
      final futures = bookmarks.map((e) async {
        final url = "${baseAPIUrl}pokemon/$e";
        final fullData = await callAPI("pokemon/$e/", Parameters());
        final details = jsonDecode(fullData);
        return SimplePokemon(
          isBookmarked: true,
          url: url,
          name: e.capitalizeFirst,
          id: int.parse(details["id"]),
          type: (details["types"][0]["type"]["name"] as String).toUpperCase(),
          imageUrl:
              details["sprites"]["other"]["official-artwork"]["front_default"],
        );
      }).toList();
      final allPokemon = await Future.wait(futures);
      return allPokemon;
    } catch (e) {
      rethrow;
    }
  }
}
