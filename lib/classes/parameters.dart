class Parameters {
  Parameters({this.name, this.limit, this.page, this.id});
  int? id;
  String? name;
  int? limit;
  int? page;
  Map<String, String>? toMap() {
    final map = <String, String>{};
    if (name != null) {
      map["name"] = name!;
    }
    if (limit != null) {
      map["limit"] = limit.toString();
      if (page != null) {
        map["offset"] = (page! * limit!).toString();
      }
    }
    if (id != null) {
      map["id"] = id.toString();
    }
    return map.isEmpty ? null : map;
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
