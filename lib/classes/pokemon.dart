import "dart:convert";

import "package:pokede_field_assistant/classes/bookmarks.dart";
import "package:pokede_field_assistant/classes/coords.dart";
import "package:pokede_field_assistant/classes/open_metro.dart";
import "package:pokede_field_assistant/classes/pokemon_type.dart";
import "package:pokede_field_assistant/others/http_request.dart";

T? getPossibleValue<T>({
  required Map<String, dynamic> data,
  required String key,
  required int id,
}) {
  if (!data.containsKey(key)) {
    return null;
  }
  if (data[key] is! T) {
    return null;
  }
  return data[key];
}

T getValue<T>({
  required Map<String, dynamic> data,
  required String key,
  required int id,
}) {
  if (!data.containsKey(key)) {
    throw MissingFieldException(id, key);
  }
  if (data[key] is! T) {
    throw WrongType(id, key);
  }
  return data[key];
}

class MissingFieldException implements Exception {
  MissingFieldException(this.id, this.key);

  final String key;
  final int id;
}

class PairNameId {
  PairNameId(this.id, this.name);

  final int id;
  final String name;
}

class Pokemon {
  Pokemon({
    required this.name,
    required this.baseExperience,
    required this.height,
    required this.order,
    required this.weight,
    required this.id,
    required this.sprites,
    required this.isFav,
    required this.types,
  });
  final int id;
  final String name;
  final List<String> sprites;
  final List<String> types;
  bool isFav;
  final int? baseExperience;
  final int? height;
  final int? order;
  final int? weight;
  String get url => generateURl(id);

  Future<bool> switchBookmark() async =>
      BookmarkService.instance.switchBookmark(id, isBookmarked: isFav);

  static String generateURl(int id) => "https://pokeapi.co/api/v2/pokemon/$id/";
  static Future<List<Pokemon>> getFromCoords(Coords coords) async {
    final pokemonType = await OpenMetro.getPokemoType(coords);
    final ids = await pokemonType.getPokemonIds();
    return getFromListOfIds(ids);
  }

  static Future<List<Pokemon>> getFromListOfIds(List<int> ids) async =>
      Future.wait(ids.map(readPokemon).toList());
  static Future<List<Pokemon>> read({
    required String searchedName,
    required int page,
    required int limit,
    required bool onlyBookmarks,
    required PokemonType? pokemonType,
    required Coords coords,
  }) {
    if (onlyBookmarks) {
      return showBookmarked();
    }
    if (pokemonType != null) {
      return getFromCoords(coords);
    }
    if (searchedName.isEmpty) {
      return simpleRead(page: page, limit: limit);
    }
    return searchByName(searchedName: searchedName, page: page, limit: limit);
  }

  static Future<Pokemon> readPokemon(int id) async {
    try {
      final rawData = await callAPI(generateURl(id));
      final json = jsonDecode(rawData) as Map<String, dynamic>;
      final name = getValue<String>(data: json, key: "name", id: id);
      final rawTypes = json["types"] as List;
      final type = <String>[];
      for (final rawType in rawTypes) {
        type.add(getValue<String>(data: rawType["type"], key: "name", id: id));
      }
      return Pokemon(
        id: id,
        name: name,
        isFav: BookmarkService.instance.isBookmark(id),
        types: type,
        sprites: (json["sprites"] as Map).entries
            .map((e) => e.value.toString())
            .toList(),

        baseExperience: getPossibleValue<int>(
          data: json,
          key: "base_experience",
          id: id,
        ),
        height: getPossibleValue<int>(data: json, key: "height", id: id),
        order: getPossibleValue<int>(data: json, key: "order", id: id),
        weight: getPossibleValue<int>(data: json, key: "weight", id: id),
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Pokemon>> searchByName({
    required String searchedName,
    required int page,
    required int limit,
  }) async {
    final getTheList = await callAPI(
      "https://pokeapi.co/api/v2/pokemon/?&limit=2000",
    );
    final rawData = jsonDecode(getTheList) as Map<String, dynamic>;
    final results = rawData["results"] as List;
    final ids = <int>[];
    var counter = 0;
    for (final e in results) {
      final name = getValue<String>(data: e, key: "name", id: 0);
      if (!name.contains(searchedName)) {
        continue;
      }
      final url = getValue<String>(data: e, key: "url", id: 0);
      final id = int.tryParse(url.split("/").where((s) => s.isNotEmpty).last);
      if (id == null) {
        continue;
      }
      counter++;
      if (counter >= page * limit) {
        ids.add(id);
      }
      if (ids.length == limit) {
        break;
      }
    }
    print(ids.length);
    return getFromListOfIds(ids);
  }

  static Future<List<Pokemon>> showBookmarked() async =>
      getFromListOfIds(BookmarkService.instance.getAll());

  static Future<List<Pokemon>> simpleRead({
    required int page,
    required int limit,
  }) async {
    try {
      final offset = page * limit;
      final getTheList = await callAPI(
        "https://pokeapi.co/api/v2/pokemon/?offset=$offset&limit=$limit",
      );
      final rawData = jsonDecode(getTheList) as Map<String, dynamic>;
      final results = rawData["results"] as List;
      final ids = <int>[];
      for (final e in results) {
        final url = getValue<String>(data: e, key: "url", id: 0);
        final id = int.tryParse(url.split("/").where((s) => s.isNotEmpty).last);
        if (id != null) {
          ids.add(id);
        }
      }
      return getFromListOfIds(ids);
    } catch (e) {
      rethrow;
    }
  }
}

class WrongType implements Exception {
  WrongType(this.id, this.key);
  final String key;
  final int id;
}
