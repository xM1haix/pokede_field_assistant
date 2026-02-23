import "package:flutter/material.dart";
import "package:pokede_field_assistant/classes/pokemon.dart";
import "package:pokede_field_assistant/extensions/build_context.dart";
import "package:pokede_field_assistant/widgets/bookmark_icon_button.dart";
import "package:pokede_field_assistant/widgets/custom_cache_network_img.dart";
import "package:pokede_field_assistant/widgets/custom_hero.dart";
import "package:pokede_field_assistant/widgets/list_of_chip.dart";

class DetailsPage extends StatefulWidget {
  const DetailsPage(this.x, {super.key});
  final Pokemon x;
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    final data = widget.x;
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
              isFav: widget.x.isFav,
            ),
          ],
        ),
        body: Stack(
          children: [
            Center(
              child: CustomHero(tag: widget.x.id, url: widget.x.sprites.first),
            ),
            ListView(
              children: [
                ...<String, dynamic>{
                  "id": data.id,
                  "name": data.name,
                  "baseExperience": data.baseExperience,
                  "height": data.height,
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
                  data: data.types,
                  text: "Types",
                  builder: (e) => Chip(label: Text(e)),
                ),
                ListOfChip(
                  data: data.sprites.toList(),
                  text: "Sprites",
                  builder: CustomCacheNetworkImg.new,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveToBookmarks(Pokemon x) async {
    final changed = await x.switchBookmark();
    if (changed) {
      setState(() {
        x.isFav = !x.isFav;
      });
    }
  }
}
