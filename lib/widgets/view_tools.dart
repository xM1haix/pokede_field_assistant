import "package:flutter/material.dart";
import "package:pokede_field_assistant/classes/navigator_helper.dart";
import "package:pokede_field_assistant/classes/switch_view_helper.dart";
import "package:pokede_field_assistant/others/popup.dart";

class ViewerTools extends StatelessWidget {
  const ViewerTools({
    required this.child,
    required this.showTools,
    required this.switchViewHelper,
    required this.navigatorHelper,
    super.key,
  });
  final SwitchViewHelper switchViewHelper;
  final Widget child;
  final bool showTools;
  final NavigatorHelper navigatorHelper;

  @override
  Widget build(BuildContext context) {
    final numOfPages = navigatorHelper.numOfPages;
    final currentPage = navigatorHelper.currentPage;
    final goToPage = navigatorHelper.navigateToPage;
    final numOnPage = navigatorHelper.numOnPage;

    return Stack(
      children: [
        child,
        AnimatedAlign(
          duration: const Duration(milliseconds: 350),
          alignment: Alignment(0, showTools ? -1 : -1.5),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
                color: Colors.black.withValues(alpha: 0.7),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextField(onSubmitted: navigatorHelper.onSubmitted),
                  ),

                  IconButton(
                    onPressed: () async {
                      final newValue = await changeNumOnPage(
                        context: context,
                        initialValue: numOnPage,
                      );
                      if (newValue != null) {
                        navigatorHelper.changeTheNumOnPage(newValue);
                      }
                    },
                    icon: Text("$numOnPage"),
                  ),
                  switchViewHelper.toWidget(),
                ],
              ),
            ),
          ),
        ),
        AnimatedAlign(
          duration: const Duration(milliseconds: 350),
          alignment: Alignment(0, showTools ? 1 : 1.5),
          child: Container(
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              color: Colors.black.withValues(alpha: 0.7),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final maxButtons = (constraints.maxWidth / 75).floor();
                int startIndex;
                int endIndex;
                final halfButtons = maxButtons ~/ 2;
                if (numOfPages <= maxButtons) {
                  startIndex = 0;
                  endIndex = numOfPages;
                } else if (currentPage < halfButtons) {
                  startIndex = 0;
                  endIndex = maxButtons;
                } else if (currentPage + halfButtons + 1 > numOfPages) {
                  startIndex = numOfPages - maxButtons;
                  endIndex = numOfPages;
                } else {
                  startIndex = currentPage - halfButtons;
                  endIndex = currentPage + halfButtons + 1;
                }
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      tooltip: "Go to back page",
                      disabledColor: Colors.transparent,
                      onPressed: currentPage < 1
                          ? null
                          : () => goToPage(currentPage - 1),
                      icon: const Icon(Icons.arrow_back_rounded),
                    ),
                    ...List.generate(endIndex - startIndex, (j) {
                      final i = startIndex + j;
                      return IconButton(
                        tooltip: "Go to page ${i + 1}",
                        onPressed: () => goToPage(i),
                        icon: Text(
                          "${i + 1}",
                          style: i == currentPage
                              ? const TextStyle(color: Colors.green)
                              : null,
                        ),
                      );
                    }),
                    IconButton(
                      tooltip: "Go to next page",
                      disabledColor: Colors.transparent,
                      onPressed: currentPage + 2 > numOfPages
                          ? null
                          : () => goToPage(currentPage + 1),
                      icon: const Icon(Icons.arrow_forward_rounded),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
