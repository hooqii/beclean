import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  ApiService._();

  static const String hostUrl = "http://zuzuzu.my.id:3002";
  static const String baseUrl = "$hostUrl/api/v1";

  static String? token;
  static String? role;

  static Map<String, String> get _headers {
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
  }

  static ApiResponse _handleResponse(http.Response response) {
    final body = jsonDecode(response.body);
    final data = body["data"];
    final message = body["message"];
    return ApiResponse(response.statusCode, message, data, body);
  }

  static Future<ApiResponse> getRequest(String url) async {
    final response = await http.get(
      Uri.parse(url),
      headers: _headers,
    );
    return _handleResponse(response);
  }

  static Future<ApiResponse> postRequest(String url, {String? body}) async {
    final response = await http.post(
      Uri.parse(url),
      headers: _headers,
      body: body,
    );
    return _handleResponse(response);
  }

  static Future<ApiResponse> putRequest(String url, {String? body}) async {
    final response = await http.put(
      Uri.parse(url),
      headers: _headers,
      body: body,
    );
    return _handleResponse(response);
  }

  static Future<ApiResponse> deleteRequest(String url, {String? body}) async {
    final response = await http.delete(
      Uri.parse(url),
      headers: _headers,
      body: body,
    );
    return _handleResponse(response);
  }
}

class ApiResponse {
  final int statusCode;
  final String message;
  final dynamic data;
  final dynamic body;

  ApiResponse(
    this.statusCode,
    this.message,
    this.data,
    this.body,
  );
}
