import "package:flutter/material.dart";

class ListGridIconButton extends StatelessWidget {
  const ListGridIconButton({
    required this.onTap,
    required this.isList,
    super.key,
  });
  final bool isList;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(isList ? Icons.grid_view : Icons.list),
    );
  }
}
