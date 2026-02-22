import "package:flutter/material.dart";
import "package:pokede_field_assistant/classes/builder_helper.dart";
import "package:pokede_field_assistant/widgets/custom_grid_view.dart";
import "package:pokede_field_assistant/widgets/custom_list_view.dart";

bool _onNotification(ScrollUpdateNotification e) {
  return true;
}

class ElementViewer<T> extends StatelessWidget {
  const ElementViewer({
    required this.onNotification,
    required this.data,
    required this.onRefresh,
    required this.isList,
    required this.builderHelper,
    super.key,
  });
  final List<T> data;
  final bool isList;
  final Future<void> Function() onRefresh;
  final BuilderHelper<T> builderHelper;
  final bool Function(ScrollUpdateNotification) onNotification;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: NotificationListener<ScrollUpdateNotification>(
        onNotification: onNotification,
        child: AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          switchOutCurve: Curves.easeIn,
          switchInCurve: Curves.easeIn,
          child: isList
              ? CustomListView(listOfData: data, builderHelper: builderHelper)
              : CustomGridView(listOfData: data, builderHelper: builderHelper),
        ),
      ),
    );
  }
}
