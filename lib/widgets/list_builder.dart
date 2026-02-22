import "package:flutter/material.dart";
import "package:pokede_field_assistant/classes/builder_helper.dart";
import "package:pokede_field_assistant/classes/viewer_tool_helper.dart";
import "package:pokede_field_assistant/widgets/custom_future_builder.dart";
import "package:pokede_field_assistant/widgets/element_viewer.dart";
import "package:pokede_field_assistant/widgets/test.dart";

class ListBuilder<T> extends StatelessWidget {
  const ListBuilder({
    required this.popupToChangeTheNumOnPage,
    required this.goToPage,
    required this.future,
    required this.isListMode,
    required this.builderHelper,
    required this.onRefresh,
    required this.viewerToolHelper,
    required this.onNotification,
    required this.switchView,
    super.key,
  });
  final Future<List<T>> future;
  final void Function() switchView;
  final bool isListMode;
  final BuilderHelper<T> builderHelper;
  final Future<void> Function() onRefresh;
  final ViewerToolHelper viewerToolHelper;
  final Future<void> Function() popupToChangeTheNumOnPage;
  final void Function(int) goToPage;
  final bool Function(ScrollUpdateNotification) onNotification;
  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: future,
      success: (context, data) => ViewerTools(
        switchView: switchView,
        goToPage: goToPage,
        popupToChangeTheNumOnPage: popupToChangeTheNumOnPage,
        viewerToolHelper: viewerToolHelper,
        isList: isListMode,
        theList: ElementViewer(
          onNotification: onNotification,
          onRefresh: onRefresh,
          data: data,
          isList: isListMode,
          builderHelper: builderHelper,
        ),
      ),
    );
  }
}
