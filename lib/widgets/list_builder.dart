import "package:flutter/material.dart";
import "package:pokede_field_assistant/classes/builder_helper.dart";
import "package:pokede_field_assistant/classes/navigator_helper.dart";
import "package:pokede_field_assistant/classes/switch_view_helper.dart";
import "package:pokede_field_assistant/widgets/custom_future_builder.dart";
import "package:pokede_field_assistant/widgets/element_viewer.dart";
import "package:pokede_field_assistant/widgets/view_tools.dart";

class ListBuilder<T> extends StatelessWidget {
  const ListBuilder({
    required this.future,
    required this.builderHelper,
    required this.onRefresh,
    required this.showTools,
    required this.onNotification,
    required this.switchViewHelper,
    required this.navigatorHelper,
    super.key,
  });
  final SwitchViewHelper switchViewHelper;
  final NavigatorHelper navigatorHelper;
  final Future<List<T>> future;
  final BuilderHelper<T> builderHelper;
  final Future<void> Function() onRefresh;
  final bool showTools;
  final bool Function(ScrollUpdateNotification) onNotification;
  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: future,
      success: (context, data) => ViewerTools(
        navigatorHelper: navigatorHelper,
        showTools: showTools,
        switchViewHelper: switchViewHelper,
        child: ElementViewer(
          onNotification: onNotification,
          onRefresh: onRefresh,
          data: data,
          isList: switchViewHelper.isList,
          builderHelper: builderHelper,
        ),
      ),
    );
  }
}
