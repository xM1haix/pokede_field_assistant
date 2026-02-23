extension ExtensionOnString on String {
  String get capitalizeFirst =>
      isEmpty ? this : this[0].toUpperCase() + substring(1);
  int? getTheId() => int.tryParse(split("/").where((s) => s.isNotEmpty).last);
}
