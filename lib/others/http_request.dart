import "package:http/http.dart" as http;

Future<String> callAPI(String url) async {
  final response = await http.get(Uri.parse(url));
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
