import "package:flutter/material.dart";
import "package:pokede_field_assistant/classes/pokemon/full.dart";
import "package:pokede_field_assistant/classes/pokemon/simple_pokemon.dart";
import "package:pokede_field_assistant/extensions/build_context.dart";
import "package:pokede_field_assistant/widgets/bookmark_icon_button.dart";
import "package:pokede_field_assistant/widgets/custom_cache_network_img.dart";
import "package:pokede_field_assistant/widgets/custom_future_builder.dart";
import "package:pokede_field_assistant/widgets/custom_hero.dart";
import "package:pokede_field_assistant/widgets/list_of_chip.dart";

class DetailsPage extends StatefulWidget {
  const DetailsPage(this.x, {super.key});
  final SimplePokemon x;
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late Future<FullPokemon> _future;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          context.back(widget.x);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.x.name),
          actions: [
            BookmarkIconButton(
              onTap: () => _saveToBookmarks(widget.x),
              isFav: widget.x.isBookmarked,
            ),
          ],
        ),
        body: Stack(
          children: [
            Center(
              child: CustomHero(tag: widget.x.id, url: widget.x.imageUrl),
            ),
            CustomFutureBuilder(
              future: _future,
              success: (context, data) => ListView(
                children: [
                  ...<String, dynamic>{
                    "id": data.id,
                    "name": data.name,
                    "baseExperience": data.baseExperience,
                    "height": data.height,
                    "isDefault": data.isDefault,
                    "order": data.order,
                    "weight": data.weight,
                  }.entries.map(
                    (e) => ListTile(
                      title: Row(
                        children: [
                          Text(e.key),
                          const Spacer(),
                          Text(e.value.toString()),
                        ],
                      ),
                    ),
                  ),
                  ListOfChip(
                    data: data.abilities,
                    text: "Abilities",
                    builder: (e) => Chip(
                      label: Text(e.ability.name),
                      backgroundColor: e.isHidden ? null : Colors.green,
                    ),
                  ),
                  ListOfChip(
                    data: data.forms,
                    text: "Forms",
                    builder: (e) => Chip(label: Text(e.name)),
                  ),

                  ListOfChip(
                    data: data.gameIndices,
                    text: "GameIndices",
                    builder: (e) => Chip(label: Text(e.version.name)),
                  ),
                  ListOfChip(
                    data: data.heldItems,
                    text: "HeldItems",
                    builder: (e) => Chip(label: Text(e.item.name)),
                  ),
                  ListOfChip(
                    data: data.moves,
                    text: "Moves",
                    builder: (e) => Chip(label: Text(e.move.name)),
                  ),
                  //   "types": data.types,
                  ListOfChip(
                    data: data.types,
                    text: "Types",
                    builder: (e) => Chip(label: Text(e.type.name)),
                  ),
                  // "sprites": data.sprites,
                  ListOfChip(
                    data: data.sprites.toList(),
                    text: "Sprites",
                    builder: CustomCacheNetworkImg.new,
                  ),
                  // "stats": data.stats,
                  ListOfChip(
                    data: data.stats,
                    text: "Moves",
                    builder: (e) => Container(
                      width: 150,
                      alignment: Alignment.center,
                      height: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withAlpha(25),
                      ),
                      child: Text(
                        "NAME:${e.stat.name}\nBASE STAT:${e.baseStat}\nEFFORT:${e.effort}",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    _future = FullPokemon.getFullData(widget.x.id);
  }

  Future<void> _saveToBookmarks(SimplePokemon x) async {
    final changed = await x.switchBookmark();
    if (changed) {
      setState(() {
        x.isBookmarked = !x.isBookmarked;
      });
    }
  }
}
