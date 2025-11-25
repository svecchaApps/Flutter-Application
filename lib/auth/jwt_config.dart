import 'jwt_auth_manager.dart';
import '/config/environment_config.dart';

class JwtConfig {
  // API Base URL
  static String get apiBaseUrl => EnvironmentConfig.baseUrl;

  // JWT Secret (for token validation)
  static const String jwtSecret = 'your-jwt-secret-key-here';

  // Authentication endpoints
  static String get loginUrl => '$apiBaseUrl/auth/login';
  static String get registerUrl => '$apiBaseUrl/auth/register';
  static String get refreshUrl => '$apiBaseUrl/auth/refresh';

  // Phone authentication endpoints
  static String get sendOtpUrl => '$apiBaseUrl/auth/send-otp';
  static String get verifyOtpUrl => '$apiBaseUrl/auth/verify-otp';
  static String get checkUserExistsUrl => '$apiBaseUrl/auth/check-user-exists';
  static String get verifyPhoneUrl => '$apiBaseUrl/auth/verify-phone';

  // Token storage keys
  static const String tokenKey = 'jwt_access_token';
  static const String refreshTokenKey = 'jwt_refresh_token';
  static const String userIdKey = 'jwt_user_id';
  static const String tokenExpiryKey = 'jwt_token_expiry';

  // Token expiry settings
  static const int accessTokenExpiryDays = 99;
  static const int refreshTokenExpiryDays = 7;

  // API Headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Get authorization header with token
  static Future<Map<String, String>> getAuthHeaders() async {
    final headers = Map<String, String>.from(defaultHeaders);
    final token = await JwtAuthManager.instance.getJwtToken();
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }
}
