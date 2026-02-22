import "package:http/http.dart" as http;
import "package:pokede_field_assistant/classes/parameters.dart";

const baseAPIUrl = "https://pokeapi.co/api/v2/";
Future<String> callAPI(String endpoint, Parameters parameters) async {
  final uri = Uri.parse(
    baseAPIUrl + endpoint,
  ).replace(queryParameters: parameters.toMap());
  final response = await http.get(uri);
  response.ensureSuccess();
  return response.body;
}

class HttpStatusException implements Exception {
  HttpStatusException(this.statusCode, this.body);
  factory HttpStatusException.fromResponse(http.Response response) {
    return HttpStatusException(response.statusCode, response.body);
  }
  final int statusCode;
  final String body;
  @override
  String toString() =>
      "HttpStatusException(statusCode: $statusCode, body:$body)";
}

extension ResponseValidation on http.Response {
  void ensureSuccess() {
    if (statusCode != 200) {
      throw HttpStatusException.fromResponse(this);
    }
  }
}
