import "dart:convert";

import "package:pokede_field_assistant/classes/parameters.dart";
import "package:pokede_field_assistant/others/http_request.dart";

class FullPokemon {
  FullPokemon({
    required this.id,
    required this.name,
    required this.baseExperience,
    required this.height,
    required this.isDefault,
    required this.order,
    required this.weight,
    required this.abilities,
    required this.forms,
    required this.gameIndices,
    required this.heldItems,
    required this.locationAreaEncounters,
    required this.moves,
    required this.sprites,
    required this.stats,
    required this.types,
  });
  factory FullPokemon.fromJson(Map<String, dynamic> json) {
    return FullPokemon(
      id: json["id"],
      name: json["name"],
      baseExperience: json["base_experience"],
      height: json["height"],
      isDefault: json["is_default"],
      order: json["order"],
      weight: json["weight"],
      abilities: (json["abilities"] as List)
          .map((e) => PokemonAbility.fromJson(e))
          .toList(),
      forms: (json["forms"] as List)
          .map((e) => NamedAPIResource.fromJson(e))
          .toList(),
      gameIndices: (json["game_indices"] as List)
          .map((e) => VersionGameIndex.fromJson(e))
          .toList(),
      heldItems: (json["held_items"] as List)
          .map((e) => PokemonHeldItem.fromJson(e))
          .toList(),
      locationAreaEncounters: json["location_area_encounters"],
      moves: (json["moves"] as List)
          .map((e) => PokemonMove.fromJson(e))
          .toList(),
      sprites: PokemonSprites.fromJson(json["sprites"]),
      stats: (json["stats"] as List)
          .map((e) => PokemonStat.fromJson(e))
          .toList(),
      types: (json["types"] as List)
          .map((e) => PokemonTypeSimple.fromJson(e))
          .toList(),
    );
  }
  final int id;
  final String name;
  final int baseExperience;
  final int height;
  final bool isDefault;
  final int order;
  final int weight;
  final List<PokemonAbility> abilities;
  final List<NamedAPIResource> forms;
  final List<VersionGameIndex> gameIndices;
  final List<PokemonHeldItem> heldItems;
  final String locationAreaEncounters;
  final List<PokemonMove> moves;
  final PokemonSprites sprites;
  final List<PokemonStat> stats;

  final List<PokemonTypeSimple> types;

  static Future<FullPokemon> getFullData(int id) async {
    final result = await callAPI(
      "https://pokeapi.co/api/v2/pokemon/$id",
      Parameters(),
    );
    final decodedReponse = jsonDecode(result) as Map<String, dynamic>;
    return FullPokemon.fromJson(decodedReponse);
  }
}

class NamedAPIResource {
  NamedAPIResource({required this.name, required this.url});
  factory NamedAPIResource.fromJson(Map<String, dynamic> json) {
    return NamedAPIResource(name: json["name"], url: json["url"]);
  }

  final String name;
  final String url;
}

class PokemonAbility {
  PokemonAbility({
    required this.isHidden,
    required this.slot,
    required this.ability,
  });
  factory PokemonAbility.fromJson(Map<String, dynamic> json) {
    return PokemonAbility(
      isHidden: json["is_hidden"],
      slot: json["slot"],
      ability: NamedAPIResource.fromJson(json["ability"]),
    );
  }
  final bool isHidden;

  final int slot;

  final NamedAPIResource ability;
}

class PokemonHeldItem {
  PokemonHeldItem({required this.item});
  factory PokemonHeldItem.fromJson(Map<String, dynamic> json) =>
      PokemonHeldItem(item: NamedAPIResource.fromJson(json["item"]));
  final NamedAPIResource item;
}

class PokemonMove {
  PokemonMove({required this.move});
  factory PokemonMove.fromJson(Map<String, dynamic> json) =>
      PokemonMove(move: NamedAPIResource.fromJson(json["move"]));
  final NamedAPIResource move;
}

class PokemonSprites {
  PokemonSprites({
    required this.frontDefault,
    this.backDefault,
    this.frontShiny,
    this.backShiny,
  });
  factory PokemonSprites.fromJson(Map<String, dynamic> json) {
    return PokemonSprites(
      frontDefault: json["front_default"],
      backDefault: json["back_default"],
      frontShiny: json["front_shiny"],
      backShiny: json["back_shiny"],
    );
  }
  final String frontDefault;
  final String? backDefault;
  final String? frontShiny;
  final String? backShiny;
  List<String> toList() {
    final sprites = [frontDefault];
    if (backDefault != null) {
      sprites.add(backDefault!);
    }
    if (frontShiny != null) {
      sprites.add(frontShiny!);
    }
    if (backShiny != null) {
      sprites.add(backShiny!);
    }

    return sprites;
  }
}

class PokemonStat {
  PokemonStat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });
  factory PokemonStat.fromJson(Map<String, dynamic> json) {
    return PokemonStat(
      baseStat: json["base_stat"],
      effort: json["effort"],
      stat: NamedAPIResource.fromJson(json["stat"]),
    );
  }
  final int baseStat;

  final int effort;

  final NamedAPIResource stat;
}

class PokemonTypeSimple {
  PokemonTypeSimple({required this.slot, required this.type});
  factory PokemonTypeSimple.fromJson(Map<String, dynamic> json) {
    return PokemonTypeSimple(
      slot: json["slot"],
      type: NamedAPIResource.fromJson(json["type"]),
    );
  }

  final int slot;

  final NamedAPIResource type;
}

class VersionGameIndex {
  VersionGameIndex({required this.gameIndex, required this.version});
  factory VersionGameIndex.fromJson(Map<String, dynamic> json) =>
      VersionGameIndex(
        gameIndex: json["game_index"],
        version: NamedAPIResource.fromJson(json["version"]),
      );
  final int gameIndex;
  final NamedAPIResource version;
}
