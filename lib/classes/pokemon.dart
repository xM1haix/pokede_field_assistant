import "dart:convert";

import "package:pokede_field_assistant/classes/bookmarks.dart";
import "package:pokede_field_assistant/classes/parameters.dart";
import "package:pokede_field_assistant/others/http_request.dart";

class Pokemon {
  Pokemon({
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
  Future<bool> removeBookmark() async {
    try {
      final result = await BookmarkService.instance.removeBookmark(name);
      isBookmarked = false;
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> switchBookmark() async =>
      BookmarkService.instance.switchBookmark(name, isBookmarked: isBookmarked);
  @override
  String toString() =>
      // ignore: lines_longer_than_80_chars
      "Pokemon(id : $id, type : $type, imageUrl : $imageUrl, name : $name, url : $url)";
  static Future<List<Pokemon>> readAll(Parameters parameters) async {
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
        final detailData = jsonDecode(fullData);
        final name = e["name"];
        return Pokemon(
          id: id,
          url: url,
          name: name,
          isBookmarked: BookmarkService.instance.isBookmark(name),
          type: detailData["types"][0]["type"]["name"],
          imageUrl:
              detailData["sprites"]["other"]["official-artwork"]["front_default"],
        );
      }).toList();
      final allPokemon = await Future.wait(futures);
      return allPokemon;
    } catch (e) {
      rethrow;
    }
  }
}
      // final List results = json.decode(response.body)["results"];
      // final detailFutures = results.map((pokemon) {
      //   return http.get(Uri.parse(pokemon["url"]));
      // }).toList();
      // final detailResponses = await Future.wait(detailFutures);
      // final result = detailResponses.map((res) {
      //   final data = json.decode(res.body);
      //   return {
      //     "name": data["name"],
      //     "type": data["types"][0]["type"]["name"],
      //     "sprite": data["sprites"]["front_default"],
      //   };
      // }).toList();
      // return result;