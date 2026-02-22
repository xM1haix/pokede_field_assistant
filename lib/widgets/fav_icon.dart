import "package:flutter/material.dart";

class FavIcon extends StatelessWidget {
  const FavIcon({required this.onTap, required this.isFav, super.key});
  final void Function() onTap;
  final bool isFav;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      child: IconButton(
        key: Key(isFav.toString()),
        onPressed: onTap,
        icon: Icon(
          isFav ? Icons.star : Icons.star_border,
          color: Colors.yellow,
        ),
      ),
    );
  }
}
