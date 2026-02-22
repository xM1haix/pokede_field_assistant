import "package:pokede_field_assistant/classes/endpoints/ability.dart";
import "package:pokede_field_assistant/classes/endpoints/berry.dart";
import "package:pokede_field_assistant/classes/endpoints/berry_firmness.dart";
import "package:pokede_field_assistant/classes/endpoints/berry_flavor.dart";
import "package:pokede_field_assistant/classes/endpoints/characteristic.dart";
import "package:pokede_field_assistant/classes/endpoints/contest_effect.dart";
import "package:pokede_field_assistant/classes/endpoints/contest_type.dart";
import "package:pokede_field_assistant/classes/endpoints/egg_group.dart";
import "package:pokede_field_assistant/classes/endpoints/encounter_condition.dart";
import "package:pokede_field_assistant/classes/endpoints/encounter_condition_value.dart";
import "package:pokede_field_assistant/classes/endpoints/encounter_method.dart";
import "package:pokede_field_assistant/classes/endpoints/evolution_chain.dart";
import "package:pokede_field_assistant/classes/endpoints/evolution_trigger.dart";
import "package:pokede_field_assistant/classes/endpoints/gender.dart";
import "package:pokede_field_assistant/classes/endpoints/generation.dart";
import "package:pokede_field_assistant/classes/endpoints/growth_rate.dart";
import "package:pokede_field_assistant/classes/endpoints/item.dart";
import "package:pokede_field_assistant/classes/endpoints/item_attribute.dart";
import "package:pokede_field_assistant/classes/endpoints/item_category.dart";
import "package:pokede_field_assistant/classes/endpoints/item_fling_effect.dart";
import "package:pokede_field_assistant/classes/endpoints/item_pocket.dart";
import "package:pokede_field_assistant/classes/endpoints/language.dart";
import "package:pokede_field_assistant/classes/endpoints/location.dart";
import "package:pokede_field_assistant/classes/endpoints/location_area.dart";
import "package:pokede_field_assistant/classes/endpoints/machine.dart";
import "package:pokede_field_assistant/classes/endpoints/move.dart";
import "package:pokede_field_assistant/classes/endpoints/move_ailment.dart";
import "package:pokede_field_assistant/classes/endpoints/move_battle_style.dart";
import "package:pokede_field_assistant/classes/endpoints/move_category.dart";
import "package:pokede_field_assistant/classes/endpoints/move_damage_class.dart";
import "package:pokede_field_assistant/classes/endpoints/move_learn_method.dart";
import "package:pokede_field_assistant/classes/endpoints/move_target.dart";
import "package:pokede_field_assistant/classes/endpoints/nature.dart";
import "package:pokede_field_assistant/classes/endpoints/pal_park_area.dart";
import "package:pokede_field_assistant/classes/endpoints/pokeathlon_stat.dart";
import "package:pokede_field_assistant/classes/endpoints/pokedex.dart";
import "package:pokede_field_assistant/classes/endpoints/pokemon.dart";
import "package:pokede_field_assistant/classes/endpoints/pokemon_color.dart";
import "package:pokede_field_assistant/classes/endpoints/pokemon_form.dart";
import "package:pokede_field_assistant/classes/endpoints/pokemon_habitat.dart";
import "package:pokede_field_assistant/classes/endpoints/pokemon_shape.dart";
import "package:pokede_field_assistant/classes/endpoints/pokemon_species.dart";
import "package:pokede_field_assistant/classes/endpoints/region.dart";
import "package:pokede_field_assistant/classes/endpoints/stat.dart";
import "package:pokede_field_assistant/classes/endpoints/super_contest_effect.dart";
import "package:pokede_field_assistant/classes/endpoints/type.dart";
import "package:pokede_field_assistant/classes/endpoints/version.dart";
import "package:pokede_field_assistant/classes/endpoints/version_group.dart";

abstract class EndpointData {
  static List<EndpointData> get getEndpoints => [
    AbilityEndpoint(),
    BerryEndpoint(),
    BerryFirmnessEndpoint(),
    BerryFlavorEndpoint(),
    CharacteristicEndpoint(),
    ContestEffectEndpoint(),
    ContestTypeEndpoint(),
    EggGroupEndpoint(),
    EncounterConditionEndpoint(),
    EncounterConditionValueEndpoint(),
    EncounterMethodEndpoint(),
    EvolutionChainEndpoint(),
    EvolutionTriggerEndpoint(),
    GenderEndpoint(),
    GenerationEndpoint(),
    GrowthRateEndpoint(),
    ItemEndpoint(),
    ItemAttributeEndpoint(),
    ItemCategoryEndpoint(),
    ItemFlingEffectEndpoint(),
    ItemPocketEndpoint(),
    LanguageEndpoint(),
    LocationEndpoint(),
    LocationAreaEndpoint(),
    MachineEndpoint(),
    MoveEndpoint(),
    MoveAilmentEndpoint(),
    MoveBattleStyleEndpoint(),
    MoveCategoryEndpoint(),
    MoveDamageClassEndpoint(),
    MoveLearnMethodEndpoint(),
    MoveTargetEndpoint(),
    NatureEndpoint(),
    PalParkAreaEndpoint(),
    PokeathlonStatEndpoint(),
    PokedexEndpoint(),
    PokemonEndpoint(),
    PokemonColorEndpoint(),
    PokemonFormEndpoint(),
    PokemonHabitatEndpoint(),
    PokemonShapeEndpoint(),
    PokemonSpeciesEndpoint(),
    RegionEndpoint(),
    StatEndpoint(),
    SuperContestEffectEndpoint(),
    TypeEndpoint(),
    VersionEndpoint(),
    VersionGroupEndpoint(),
  ];
  String get name;
  String get url;

  static EndpointData? findEndpointFromJson(Map<String, dynamic> json) {
    for (final endpoint in getEndpoints) {
      if (endpoint.name == json["name"] && endpoint.url == json["url"]) {
        return endpoint;
      }
    }
    return null;
  }
}

enum EndpointValues {
  abilityEndpoint,
  berryEndpoint,
  berryFirmnessEndpoint,
  berryFlavorEndpoint,
  characteristicEndpoint,
  contestEffectEndpoint,
  contestTypeEndpoint,
  eggGroupEndpoint,
  encounterConditionEndpoint,
  encounterConditionValueEndpoint,
  encounterMethodEndpoint,
  evolutionChainEndpoint,
  evolutionTriggerEndpoint,
  genderEndpoint,
  generationEndpoint,
  growthRateEndpoint,
  itemEndpoint,
  itemAttributeEndpoint,
  itemCategoryEndpoint,
  itemFlingEffectEndpoint,
  itemPocketEndpoint,
  languageEndpoint,
  locationEndpoint,
  locationAreaEndpoint,
  machineEndpoint,
  moveEndpoint,
  moveAilmentEndpoint,
  moveBattleStyleEndpoint,
  moveCategoryEndpoint,
  moveDamageClassEndpoint,
  moveLearnMethodEndpoint,
  moveTargetEndpoint,
  natureEndpoint,
  palParkAreaEndpoint,
  pokeathlonStatEndpoint,
  pokedexEndpoint,
  pokemonEndpoint,
  pokemonColorEndpoint,
  pokemonFormEndpoint,
  pokemonHabitatEndpoint,
  pokemonShapeEndpoint,
  pokemonSpeciesEndpoint,
  regionEndpoint,
  statEndpoint,
  superContestEffectEndpoint,
  typeEndpoint,
  versionEndpoint,
  versionGroupEndpoint,
}
