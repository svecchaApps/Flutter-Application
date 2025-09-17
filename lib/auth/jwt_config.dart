import 'jwt_auth_manager.dart';

class JwtConfig {
  // API Base URL
  static const String apiBaseUrl =
      'https://indigo-rhapsody-backend-ten.vercel.app';

  // JWT Secret (for token validation)
  static const String jwtSecret = 'your-jwt-secret-key-here';

  // Authentication endpoints
  static const String loginUrl = '$apiBaseUrl/auth/login';
  static const String registerUrl = '$apiBaseUrl/auth/register';
  static const String refreshUrl = '$apiBaseUrl/auth/refresh';

  // Phone authentication endpoints
  static const String sendOtpUrl = '$apiBaseUrl/auth/send-otp';
  static const String verifyOtpUrl = '$apiBaseUrl/auth/verify-otp';
  static const String checkUserExistsUrl = '$apiBaseUrl/auth/check-user-exists';
  static const String verifyPhoneUrl = '$apiBaseUrl/auth/verify-phone';

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
