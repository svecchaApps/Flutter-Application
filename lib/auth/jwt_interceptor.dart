import 'dart:convert';
import 'package:http/http.dart' as http;
import 'jwt_auth_manager.dart';

class JwtInterceptor {
  static final JwtAuthManager _authManager = JwtAuthManager.instance;

  // Simple interceptor for HTTP requests
  static Future<http.Response> interceptRequest(
    http.Client client,
    http.BaseRequest request,
  ) async {
    // Get JWT token
    final token = await _authManager.getJwtToken();

    // Add authorization header if token exists
    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    // Send the request
    final response = await client.send(request);
    return await http.Response.fromStream(response);
  }
}
