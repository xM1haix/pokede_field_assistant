import "package:flutter/material.dart";

class CustomFutureBuilder<T> extends StatelessWidget {
  const CustomFutureBuilder({
    required this.future,
    required this.success,
    super.key,
  });
  final Future<T> future;
  final Widget Function(BuildContext context, T data) success;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: snapshot.hasError
              ? Text("Error: ${snapshot.error}")
              : !snapshot.hasData
              ? const CircularProgressIndicator()
              : success(context, snapshot.data as T),
        );
      },
    );
  }
}
