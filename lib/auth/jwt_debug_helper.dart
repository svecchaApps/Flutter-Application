import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'jwt_auth_manager.dart';
import 'jwt_config.dart';
import '/backend/api_requests/api_calls.dart';

class JwtDebugHelper {
  static final JwtAuthManager _jwtAuthManager = JwtAuthManager.instance;

  // Test JWT configuration
  static Future<void> testJwtConfig() async {
    print('🔍 [JWT_DEBUG] Testing JWT Configuration...');
    print('🔍 [JWT_DEBUG] API Base URL: ${JwtConfig.apiBaseUrl}');
    print('🔍 [JWT_DEBUG] Login URL: ${JwtConfig.loginUrl}');
    print('🔍 [JWT_DEBUG] Register URL: ${JwtConfig.registerUrl}');
    print('🔍 [JWT_DEBUG] Send OTP URL: ${JwtConfig.sendOtpUrl}');
    print('🔍 [JWT_DEBUG] Verify Phone URL: ${JwtConfig.verifyPhoneUrl}');
  }

  // Test API connectivity
  static Future<void> testApiConnectivity() async {
    print('🔍 [JWT_DEBUG] Testing API Connectivity...');
    try {
      final response =
          await http.get(Uri.parse('${JwtConfig.apiBaseUrl}/health'));
      print('🔍 [JWT_DEBUG] Health check response: ${response.statusCode}');
      print('🔍 [JWT_DEBUG] Health check body: ${response.body}');
    } catch (e) {
      print('🔍 [JWT_DEBUG] API connectivity error: $e');
    }
  }

  // Get current authentication status
  static Future<void> getCurrentAuthStatus() async {
    print('🔍 [JWT_DEBUG] Current Authentication Status...');

    final isAuthenticated = await _jwtAuthManager.isAuthenticated();
    final token = await _jwtAuthManager.getJwtToken();
    final refreshToken = await _jwtAuthManager.getRefreshToken();
    final userId = await _jwtAuthManager.getUserId();

    print('🔍 [JWT_DEBUG] Is Authenticated: $isAuthenticated');
    print('🔍 [JWT_DEBUG] Has Access Token: ${token != null}');
    print('🔍 [JWT_DEBUG] Has Refresh Token: ${refreshToken != null}');
    print('🔍 [JWT_DEBUG] User ID: $userId');

    if (token != null) {
      print('🔍 [JWT_DEBUG] Token preview: ${token.substring(0, 50)}...');
    }
  }

  // Test JWT endpoints
  static Future<void> testJwtEndpoints() async {
    print('🔍 [JWT_DEBUG] Testing JWT Endpoints...');

    // Test registration endpoint
    await testRegistrationEndpoint();

    // Test login endpoint
    await testLoginEndpoint();

    // Test verify phone endpoint
    await testVerifyPhoneEndpoint();
  }

  // Test registration endpoint
  static Future<void> testRegistrationEndpoint() async {
    print('🔍 [JWT_DEBUG] Testing Registration Endpoint...');
    try {
      final response = await http.post(
        Uri.parse(JwtConfig.registerUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': 'test@example.com',
          'password': 'testpassword123',
          'displayName': 'Test User',
          'phoneNumber': '+919876543210',
          'role': 'User',
          'isCreator': false,
          'nickName': 'Test',
          'city': 'Test City',
          'state': 'Test State',
          'pincode': 123456,
        }),
      );
      print('🔍 [JWT_DEBUG] Registration response: ${response.statusCode}');
      print('🔍 [JWT_DEBUG] Registration body: ${response.body}');
    } catch (e) {
      print('🔍 [JWT_DEBUG] Registration error: $e');
    }
  }

  // Test login endpoint
  static Future<void> testLoginEndpoint() async {
    print('🔍 [JWT_DEBUG] Testing Login Endpoint...');
    try {
      final response = await http.post(
        Uri.parse(JwtConfig.loginUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': 'test@example.com',
          'password': 'testpassword123',
        }),
      );
      print('🔍 [JWT_DEBUG] Login response: ${response.statusCode}');
      print('🔍 [JWT_DEBUG] Login body: ${response.body}');
    } catch (e) {
      print('🔍 [JWT_DEBUG] Login error: $e');
    }
  }

  // Test verify phone endpoint
  static Future<void> testVerifyPhoneEndpoint() async {
    print('🔍 [JWT_DEBUG] Testing Verify Phone Endpoint...');
    try {
      // Get Firebase ID token
      String? firebaseIdToken;
      try {
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          firebaseIdToken = await currentUser.getIdToken();
          print('🔍 [JWT_DEBUG] Firebase ID token obtained');
        }
      } catch (e) {
        print('🔍 [JWT_DEBUG] Error getting Firebase ID token: $e');
      }

      final response = await http.post(
        Uri.parse(JwtConfig.verifyPhoneUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phoneNumber': '+919876543210',
          'firebaseIdToken': firebaseIdToken ?? 'test-token',
        }),
      );
      print('🔍 [JWT_DEBUG] Verify phone response: ${response.statusCode}');
      print('🔍 [JWT_DEBUG] Verify phone body: ${response.body}');
    } catch (e) {
      print('🔍 [JWT_DEBUG] Verify phone error: $e');
    }
  }

  // Test cart authentication
  static Future<void> testCartAuthentication() async {
    print('🔍 [JWT_DEBUG] Testing Cart Authentication...');
    try {
      final token = await _jwtAuthManager.getJwtToken();
      if (token == null) {
        print('🔍 [JWT_DEBUG] No JWT token available for cart test');
        return;
      }

      // Test a cart API call
      final response = await http.get(
        Uri.parse('${JwtConfig.apiBaseUrl}/cart'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print('🔍 [JWT_DEBUG] Cart API response: ${response.statusCode}');
      print('🔍 [JWT_DEBUG] Cart API body: ${response.body}');
    } catch (e) {
      print('🔍 [JWT_DEBUG] Cart authentication error: $e');
    }
  }

  // Debug token details
  static Future<void> debugToken() async {
    print('🔍 [JWT_DEBUG] Debugging JWT Token...');
    final token = await _jwtAuthManager.getJwtToken();
    if (token != null) {
      print('🔍 [JWT_DEBUG] Token length: ${token.length}');
      print('🔍 [JWT_DEBUG] Token preview: ${token.substring(0, 100)}...');

      // Try to decode JWT payload (without verification)
      try {
        final parts = token.split('.');
        if (parts.length == 3) {
          final payload = parts[1];
          final decoded =
              utf8.decode(base64Url.decode(base64Url.normalize(payload)));
          print('🔍 [JWT_DEBUG] Token payload: $decoded');
        }
      } catch (e) {
        print('🔍 [JWT_DEBUG] Error decoding token payload: $e');
      }
    } else {
      print('🔍 [JWT_DEBUG] No token available');
    }
  }

  // Debug user ID
  static Future<void> debugUserId() async {
    print('🔍 [JWT_DEBUG] Debugging User ID...');
    final userId = await _jwtAuthManager.getUserId();
    print('🔍 [JWT_DEBUG] User ID: $userId');
  }

  // Debug authentication status
  static Future<void> debugAuthStatus() async {
    print('🔍 [JWT_DEBUG] Debugging Authentication Status...');
    final isAuth = await _jwtAuthManager.isAuthenticated();
    print('🔍 [JWT_DEBUG] Is Authenticated: $isAuth');
  }

  // Clear all tokens (for testing)
  static Future<void> clearAllTokens() async {
    print('🔍 [JWT_DEBUG] Clearing all tokens...');
    await _jwtAuthManager.clearTokens();
    print('🔍 [JWT_DEBUG] All tokens cleared');
  }

  // Run all debug tests
  static Future<void> runAllTests() async {
    print('🔍 [JWT_DEBUG] Running all JWT debug tests...');

    await testJwtConfig();
    await testApiConnectivity();
    await getCurrentAuthStatus();
    await debugToken();
    await debugUserId();
    await debugAuthStatus();

    print('🔍 [JWT_DEBUG] All tests completed');
  }
}
