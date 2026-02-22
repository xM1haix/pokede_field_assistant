import "dart:async";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:pokede_field_assistant/extensions/build_context.dart";

Future<int?> changeNumOnPage({
  required BuildContext context,
  required int initialValue,
}) async {
  final controller = TextEditingController(text: initialValue.toString());
  final focusNode = FocusNode();
  String? errorText = "Value required";
  focusNode.requestFocus();
  final confirm = await popup(
    context,
    "Set the number of elements per page",
    actions: [PopupAction("Cancel!", false), PopupAction("Create!", true)],
    content: StatefulBuilder(
      builder: (context, setState) => TextField(
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly, // allow digits only
        ],
        keyboardType: TextInputType.number,
        onChanged: (s) {
          setState(() {
            errorText = s.isEmpty ? "Name required" : null;
          });
        },
        focusNode: focusNode,
        controller: controller,
        decoration: InputDecoration(
          errorText: errorText,
          hintText: "Insert name",
        ),
      ),
    ),
  );
  return confirm == true && controller.text.isNotEmpty
      ? int.parse(controller.text)
      : null;
}

Future<bool> confirmPopup(BuildContext context, String question) async {
  final x = await showDialog<bool?>(
    context: context,
    builder: (context) => AlertDialog(
      actionsAlignment: .spaceEvenly,
      title: Text(question, textAlign: .center),
      actions: [
        PopupAction("No!", false),
        PopupAction("Yes!", true),
      ].map((e) => e.toWidget(context)).toList(),
    ),
  );
  return x ?? false;
}

Future<void> errorPopup(BuildContext context, e) async => showDialog<void>(
  context: context,
  builder: (context) => AlertDialog(
    title: const Text("Something went wrong"),
    content: Text(e.toString()),
    actionsAlignment: .center,
    actions: [PopupAction("Ok!").toWidget(context)],
  ),
);
Future<void> infoPopup(BuildContext context, String title) async =>
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        actionsAlignment: .center,
        actions: [PopupAction("Ok!").toWidget(context)],
      ),
    );

Future<T?> popup<T>(
  BuildContext context,
  String title, {
  List<PopupAction<T>> actions = const [],
  Widget? content,
}) async => showDialog<T>(
  context: context,
  builder: (context) => AlertDialog(
    title: Text(title),
    content: content,
    actionsAlignment: .spaceEvenly,
    actions: actions.map((e) => e.toWidget(context)).toList(),
  ),
);

class LoadingPopup {
  factory LoadingPopup() => _instance;
  LoadingPopup._internal();
  static final _instance = LoadingPopup._internal();
  BuildContext? _dialogContext;
  void close() {
    if (_dialogContext != null) {
      Navigator.of(_dialogContext!).pop();
      _dialogContext = null;
    }
  }

  Future<void> show(BuildContext context) async {
    if (_dialogContext == null) {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          _dialogContext = dialogContext;
          return const Center(child: CircularProgressIndicator());
        },
      );
      _dialogContext = null;
    }
  }
}

class PopupAction<T> {
  PopupAction(this.text, [this.value]);
  final String text;
  final T? value;
  Widget toWidget(BuildContext context) =>
      TextButton(onPressed: () => context.back(value), child: Text(text));
}
