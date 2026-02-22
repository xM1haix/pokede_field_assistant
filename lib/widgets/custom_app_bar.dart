import "package:flutter/material.dart";
import "package:pokede_field_assistant/widgets/list_grid_icon_button.dart";

AppBar customAppBar({
  required bool isList,
  required Function() onTap,
  required void Function(String) onSubmitted,
}) => AppBar(
  title: TextField(
    onSubmitted: onSubmitted,
    decoration: const InputDecoration(
      hintText: "Search...",
      hintStyle: TextStyle(fontStyle: FontStyle.italic),
    ),
  ),
  actions: [ListGridIconButton(onTap: onTap, isList: isList)],
);
