import "dart:convert";

import "package:pokede_field_assistant/classes/parameters.dart";
import "package:pokede_field_assistant/others/http_request.dart";

class Endpoint {
  Endpoint({required this.name, required this.url});

  final String name;
  final String url;
  @override
  String toString() => '{"name": "$name", "url": "$url"}';

  static Future<List<Endpoint>> getEndpoints() async {
    try {
      final response = await callAPI("", Parameters());
      final results = jsonDecode(response) as Map<String, dynamic>;
      final x = results.entries
          .map((e) => Endpoint(name: e.key, url: e.value))
          .toList();
      return x;
    } catch (e) {
      rethrow;
    }
  }
}
