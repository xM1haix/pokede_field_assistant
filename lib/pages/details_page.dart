import "package:flutter/material.dart";
import "package:pokede_field_assistant/classes/pokemon.dart";
import "package:pokede_field_assistant/widgets/custom_cache_network_img.dart";

class DetailsPage extends StatefulWidget {
  const DetailsPage(this.x, {super.key});
  final Pokemon x;
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Hero(
        tag: widget.x.id,
        child: Material(
          color: Colors.transparent,
          child: CustomCacheNetworkImg(widget.x.imageUrl),
        ),
      ),
    );
  }
}
