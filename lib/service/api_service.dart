import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map<String, dynamic>> post(
      String url,
      Map<String, dynamic> body, {
        Map<String, String>? headers,
      }) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        if (headers != null) ...headers,
      },
      body: jsonEncode(body),
    );

    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> get(
      String url, {
        Map<String, String>? headers,
      }) async {
    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    return jsonDecode(response.body);
  }
}
