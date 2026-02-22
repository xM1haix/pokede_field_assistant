import "package:flutter/material.dart";

class MajorData with ChangeNotifier {
  var _resultCounter = 0;
  int get resultCounter => _resultCounter;
  void setNumberOfResult(int x) {
    _resultCounter = x;
    notifyListeners();
  }
}
