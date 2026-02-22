import "package:flutter/material.dart";
import "package:pokede_field_assistant/classes/builder_helper.dart";
import "package:pokede_field_assistant/widgets/list_view_element.dart";

class CustomListView<T> extends StatelessWidget {
  const CustomListView({
    required this.listOfData,
    required this.builderHelper,
    super.key,
  });
  final List<T> listOfData;
  final BuilderHelper<T> builderHelper;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listOfData.length,
      itemBuilder: (context, i) {
        return ListViewElement<T>(
          isEven: i.isEven,
          builderHelper: builderHelper,
          data: listOfData[i],
        );
      },
    );
  }
}
