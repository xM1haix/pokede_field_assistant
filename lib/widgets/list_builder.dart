import "package:flutter/material.dart";
import "package:pokede_field_assistant/classes/builder_helper.dart";
import "package:pokede_field_assistant/classes/switch_view_helper.dart";
import "package:pokede_field_assistant/widgets/custom_future_builder.dart";
import "package:pokede_field_assistant/widgets/element_viewer.dart";

class ListBuilder<T> extends StatelessWidget {
  const ListBuilder({
    required this.switchViewHelper,
    required this.future,
    required this.builderHelper,
    required this.onRefresh,
    super.key,
  });
  final SwitchViewHelper switchViewHelper;
  final Future<List<T>> future;
  final BuilderHelper<T> builderHelper;
  final Future<void> Function() onRefresh;
  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: future,
      success: (context, data) => ElementViewer(
        onRefresh: onRefresh,
        data: data,
        isList: switchViewHelper.isList,
        builderHelper: builderHelper,
      ),
    );
  }
}
