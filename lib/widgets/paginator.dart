import "package:flutter/material.dart";

class Paginator extends StatelessWidget {
  const Paginator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(25),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      ),
    );
  }
}
