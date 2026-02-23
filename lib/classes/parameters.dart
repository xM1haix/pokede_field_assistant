class Parameters {
  Parameters({this.limit, this.page});
  int? limit;
  int? page;

  Map<String, String>? toMap() {
    final map = <String, String>{};
    if (limit != null) {
      map["limit"] = limit.toString();
      if (page != null) {
        map["offset"] = (page! * limit!).toString();
      }
    }
    return map.isEmpty ? null : map;
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
