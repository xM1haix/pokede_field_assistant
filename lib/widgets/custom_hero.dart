import "package:flutter/material.dart";
import "package:pokede_field_assistant/widgets/custom_cache_network_img.dart";

class CustomHero extends StatelessWidget {
  const CustomHero({required this.tag, required this.url, super.key});
  final Object tag;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Material(
        color: Colors.transparent,
        child: CustomCacheNetworkImg(url),
      ),
    );
  }
}
