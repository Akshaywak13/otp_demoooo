import 'dart:convert';


import 'package:http/http.dart' as http;

typedef ApiResponseSuccess = Function(dynamic data);
typedef ApiResponseFailure = Function(String error);

const String jsonContentType = 'application/json';

class ApiBase {
  final Map<String, String> _headers;
  // Future _getToken() async {
  //   token = await LocalStorageUtils.fetchToken();
  //   // ignore: avoid_print
  //   print(token);
  // }

  String? token = "";

  ApiBase({Map<String, String>? headers})
      : _headers = headers ?? {'Content-Type': jsonContentType};
  Future<void> get(
    String url,
    ApiResponseSuccess onSuccess,
    ApiResponseFailure onFailure, {
    bool? isTokenMandatory = false,
  }) async {
    //await _getToken();

    if (isTokenMandatory ?? false) {
      _headers['Authorization'] = token ?? '';
    }
    _request(
        (uri) => http.get(uri, headers: _headers), url, onSuccess, onFailure);
  }

  Future<void> post(String url, Map<String, dynamic> body,
      ApiResponseSuccess onSuccess, ApiResponseFailure onFailure) async {
    _request((uri) => http.post(uri, body: jsonEncode(body), headers: _headers),
        url, onSuccess, onFailure);
  }

  Future<void> put(String url, Map<String, dynamic> body,
      ApiResponseSuccess onSuccess, ApiResponseFailure onFailure) async {
    _request((uri) => http.put(uri, body: jsonEncode(body), headers: _headers),
        url, onSuccess, onFailure);
  }

  Future<void> delete(String url, ApiResponseSuccess onSuccess,
      ApiResponseFailure onFailure) async {
    _request(http.delete, url, onSuccess, onFailure);
  }

  Future<void> _request(Function requestMethod, String url,
      ApiResponseSuccess onSuccess, ApiResponseFailure onFailure) async {
    try {
      final response = await requestMethod(Uri.parse(url));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        onSuccess(jsonDecode(response.body));
      } else {
        final errorResponse = jsonDecode(response.body);
        final errorMessage = errorResponse['message'] ?? 'Failed to load data.';

        switch (response.statusCode) {
          case 400:
            onFailure('Bad request: $errorMessage');
            break;
          case 401:
            onFailure('Unauthorized: $errorMessage');
            break;
          case 403:
            onFailure('Forbidden: $errorMessage');
            break;
          case 404:
            onFailure('Not found: $errorMessage');
            break;
          case 500:
            onFailure('Internal server error: $errorMessage');
            break;
          default:
            onFailure(
                'Failed to load data. Status code: ${response.statusCode}');
            break;
        }
      }
    } catch (e) {
      onFailure('An error occurred: $e');
    }
  }

  void addHeader(String key, String value) {
    _headers[key] = value;
  }

  String getHeader(String key) {
    return _headers[key] ?? "";
  }
}
