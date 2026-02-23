import "package:flutter/material.dart";

extension ExtensionOnBuildContext on BuildContext {
  ///Reusable and shorter function which will get the
  ///[BuildContext] as [context] and the [x] as any parameter to return
  void back<T>([T? x]) => Navigator.pop(this, x);

  ///Reusable and shorter Future which will navigate to
  ///thewidget[location] also returns [T] if provided

  Future<T?> nav<T>(Widget location) async => Navigator.push<T>(
    this,
    PageRouteBuilder(
      transitionDuration: const Duration(seconds: 1),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
      pageBuilder: (context, animation, secondaryAnimation) => location,
    ),
  );
}
