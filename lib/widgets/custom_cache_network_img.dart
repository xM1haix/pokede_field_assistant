import "package:cached_network_image_ce/cached_network_image.dart";
import "package:flutter/material.dart";

class CustomCacheNetworkImg extends StatelessWidget {
  const CustomCacheNetworkImg(this.url, {super.key});

  final String url;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.contain,
      imageUrl: url,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => Tooltip(
        message: error.toString(),
        child: const Icon(Icons.warning_amber, color: Colors.red),
      ),
    );
  }
}
