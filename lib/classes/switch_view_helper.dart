import "package:flutter/widgets.dart";
import "package:pokede_field_assistant/widgets/list_grid_icon_button.dart";

class SwitchViewHelper {
  SwitchViewHelper({required this.isList, required this.onTap});
  final void Function() onTap;
  bool isList;
  Widget toWidget() => ListGridIconButton(onTap: onTap, isList: isList);
}
