import "package:flutter/material.dart";
import "package:pokede_field_assistant/classes/builder_helper.dart";
import "package:pokede_field_assistant/widgets/grid_view_element.dart";

class CustomGridView<T> extends StatelessWidget {
  const CustomGridView({
    required this.listOfData,
    required this.builderHelper,
    super.key,
  });
  final List<T> listOfData;

  final BuilderHelper<T> builderHelper;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 500,
      ),
      itemCount: listOfData.length,
      itemBuilder: (context, i) => GridViewElement(
        builderHelper: builderHelper,
        data: listOfData[i],
        isEven: i.isEven,
      ),
    );
  }
}
