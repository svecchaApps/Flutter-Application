import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'jwt_config.dart';

class JwtAuthManager {
  static final JwtAuthManager _instance = JwtAuthManager._internal();
  factory JwtAuthManager() => _instance;
  JwtAuthManager._internal();

  static JwtAuthManager get instance => _instance;

  static const String _tokenKey = 'jwt_access_token';
  static const String _refreshTokenKey = 'jwt_refresh_token';
  static const String _userIdKey = 'jwt_user_id';
  static const String _tokenExpiryKey = 'jwt_token_expiry';

  // Get JWT token
  Future<String?> getJwtToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    final expiry = prefs.getString(_tokenExpiryKey);

    if (token != null && expiry != null) {
      final expiryDate = DateTime.parse(expiry);
      if (DateTime.now().isBefore(expiryDate)) {
        print('🔐 [JWT] Token is valid, expires at: $expiryDate');
        return token;
      } else {
        print('🔐 [JWT] Token expired at: $expiryDate');
        // Try to refresh token
        final refreshed = await refreshToken();
        if (refreshed) {
          return prefs.getString(_tokenKey);
        }
      }
    }
    return null;
  }

  // Set JWT token
  Future<void> setJwtToken(String token, {String? expiresIn}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);

    if (expiresIn != null) {
      // Parse expiresIn (e.g., "99d" -> 99 days from now)
      final days = int.tryParse(expiresIn.replaceAll('d', '')) ?? 1;
      final expiryDate = DateTime.now().add(Duration(days: days));
      await prefs.setString(_tokenExpiryKey, expiryDate.toIso8601String());
      print('🔐 [JWT] Token stored, expires at: $expiryDate');
    }
  }

  // Get refresh token
  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  // Set refresh token
  Future<void> setRefreshToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_refreshTokenKey, token);
  }

  // Get user ID
  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  // Set user ID
  Future<void> setUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
  }

  // Check if user is authenticated
  Future<bool> isAuthenticated() async {
    final token = await getJwtToken();
    return token != null && token.isNotEmpty;
  }

  // Clear all tokens
  Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_refreshTokenKey);
    await prefs.remove(_userIdKey);
    await prefs.remove(_tokenExpiryKey);
    print('🔐 [JWT] All tokens cleared');
  }

  // Store authentication data
  Future<void> storeAuthData({
    required String accessToken,
    required String refreshToken,
    required String userId,
    String? expiresIn,
  }) async {
    await setJwtToken(accessToken, expiresIn: expiresIn);
    await setRefreshToken(refreshToken);
    await setUserId(userId);
    print('🔐 [JWT] Auth data stored for user: $userId');
  }

  // Login with email and password
  Future<Map<String, dynamic>?> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      print('🔐 [JWT] Attempting email login for: $email');

      final response = await http.post(
        Uri.parse('${JwtConfig.apiBaseUrl}/auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      print('🔐 [JWT] Login response status: ${response.statusCode}');
      print('🔐 [JWT] Login response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          final accessToken = data['accessToken'];
          final refreshToken = data['refreshToken'];
          final user = data['user'];
          final expiresIn = data['expiresIn'];
          final userId = user['_id'];

          await storeAuthData(
            accessToken: accessToken,
            refreshToken: refreshToken,
            userId: userId,
            expiresIn: expiresIn,
          );

          print('🔐 [JWT] Email login successful for user: $userId');
          return data;
        }
      }

      print('🔐 [JWT] Email login failed: ${response.body}');
      return null;
    } catch (e) {
      print('🔐 [JWT] Email login error: $e');
      return null;
    }
  }

  // Create new user
  Future<Map<String, dynamic>?> createUser({
    required String email,
    required String password,
    required String displayName,
    required String phoneNumber,
    String? firebaseIdToken,
    String? role,
    bool? isCreator,
    String? nickName,
    String? city,
    String? state,
    int? pincode,
    BuildContext? context,
  }) async {
    try {
      print('🔐 [JWT] Creating user: $email');

      final requestBody = {
        'email': email,
        'password': password,
        'displayName': displayName,
        'phoneNumber': phoneNumber,
        if (firebaseIdToken != null) 'firebaseIdToken': firebaseIdToken,
        if (role != null) 'role': role,
        if (isCreator != null) 'isCreator': isCreator,
        if (nickName != null) 'nickName': nickName,
        if (city != null) 'city': city,
        if (state != null) 'state': state,
        if (pincode != null) 'pincode': pincode,
      };

      print('🔐 [JWT] Create user request body: $requestBody');
      print('🔐 [JWT] Email parameter received: "$email"');
      print('🔐 [JWT] Email parameter type: ${email.runtimeType}');
      print('🔐 [JWT] Email parameter length: ${email.length}');
      print('🔐 [JWT] Email parameter isEmpty: ${email.isEmpty}');
      print('🔐 [JWT] Email parameter isNotEmpty: ${email.isNotEmpty}');

      final response = await http.post(
        Uri.parse('${JwtConfig.apiBaseUrl}/auth/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      print('🔐 [JWT] Create user response status: ${response.statusCode}');
      print('🔐 [JWT] Create user response body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          final accessToken = data['accessToken'];
          final refreshToken = data['refreshToken'];
          final user = data['user'];
          final expiresIn = data['expiresIn'];
          final userId = user['_id'];

          await storeAuthData(
            accessToken: accessToken,
            refreshToken: refreshToken,
            userId: userId,
            expiresIn: expiresIn,
          );

          print('🔐 [JWT] User creation successful: $userId');
          return data;
        }
      }

      print('🔐 [JWT] User creation failed: ${response.body}');
      return null;
    } catch (e) {
      print('🔐 [JWT] User creation error: $e');
      return null;
    }
  }

  // Send phone OTP
  Future<Map<String, dynamic>?> sendPhoneOtp({
    required String phoneNumber,
  }) async {
    try {
      print('🔐 [JWT] Sending OTP to: $phoneNumber');

      final response = await http.post(
        Uri.parse(JwtConfig.sendOtpUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'phoneNumber': phoneNumber,
        }),
      );

      print('🔐 [JWT] Send OTP response status: ${response.statusCode}');
      print('🔐 [JWT] Send OTP response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('🔐 [JWT] OTP sent successfully');
        return data;
      }

      print('🔐 [JWT] Send OTP failed: ${response.body}');
      return null;
    } catch (e) {
      print('🔐 [JWT] Send OTP error: $e');
      return null;
    }
  }

  // Verify phone OTP
  Future<Map<String, dynamic>?> verifyPhoneOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    try {
      print('🔐 [JWT] Verifying OTP for: $phoneNumber');

      final response = await http.post(
        Uri.parse(JwtConfig.verifyOtpUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'phoneNumber': phoneNumber,
          'otp': otp,
        }),
      );

      print('🔐 [JWT] Verify OTP response status: ${response.statusCode}');
      print('🔐 [JWT] Verify OTP response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('🔐 [JWT] OTP verification successful');
        return data;
      }

      print('🔐 [JWT] Verify OTP failed: ${response.body}');
      return null;
    } catch (e) {
      print('🔐 [JWT] Verify OTP error: $e');
      return null;
    }
  }

  // Check if user exists
  Future<Map<String, dynamic>?> checkUserExists({
    required String phoneNumber,
  }) async {
    try {
      print('🔐 [JWT] Checking if user exists: $phoneNumber');

      final response = await http.post(
        Uri.parse(JwtConfig.checkUserExistsUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'phoneNumber': phoneNumber,
        }),
      );

      print(
          '🔐 [JWT] Check user exists response status: ${response.statusCode}');
      print('🔐 [JWT] Check user exists response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('🔐 [JWT] User exists check completed');
        return data;
      }

      print('🔐 [JWT] Check user exists failed: ${response.body}');
      return null;
    } catch (e) {
      print('🔐 [JWT] Check user exists error: $e');
      return null;
    }
  }

  // Verify phone with Firebase token
  Future<Map<String, dynamic>?> verifyPhoneWithFirebaseToken({
    required String phoneNumber,
    required String firebaseToken,
  }) async {
    try {
      print('🔐 [JWT] Verifying phone with Firebase token: $phoneNumber');

      final response = await http.post(
        Uri.parse(JwtConfig.verifyPhoneUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'phoneNumber': phoneNumber,
          'firebaseIdToken': firebaseToken,
        }),
      );

      print('🔐 [JWT] Verify phone response status: ${response.statusCode}');
      print('🔐 [JWT] Verify phone response body: ${response.body}');
      print('🔐 [JWT] Verify phone response headers: ${response.headers}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          final isNewUser = data['isNewUser'] ?? false;
          print('🔐 [JWT] Success response, isNewUser: $isNewUser');
          print('🔐 [JWT] Full response data: $data');

          if (isNewUser) {
            print(
                '🔐 [JWT] New user detected, returning data for registration');
            return data;
          } else {
            print('🔐 [JWT] Existing user detected, calling login endpoint');
            // Call login endpoint for existing user
            return await _callLoginWithPhone(phoneNumber, firebaseToken);
          }
        }
      }

      print('🔐 [JWT] Verify phone failed: ${response.body}');
      return null;
    } catch (e) {
      print('🔐 [JWT] Verify phone error: $e');
      return null;
    }
  }

  // Call login with phone
  Future<Map<String, dynamic>?> _callLoginWithPhone(
    String phoneNumber,
    String firebaseToken,
  ) async {
    try {
      print('🔐 [JWT] Calling login endpoint with phone: $phoneNumber');

      // Get fresh Firebase ID token
      String? firebaseIdToken;
      try {
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          firebaseIdToken = await currentUser.getIdToken();
          print('🔐 [JWT] Fresh Firebase ID token obtained');
        }
      } catch (e) {
        print('🔐 [JWT] Error getting fresh Firebase ID token: $e');
        firebaseIdToken = firebaseToken; // Use provided token as fallback
      }

      final response = await http.post(
        Uri.parse('${JwtConfig.apiBaseUrl}/auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'phoneNumber': phoneNumber,
          'firebaseIdToken': firebaseIdToken,
        }),
      );

      print('🔐 [JWT] Login response status: ${response.statusCode}');
      print('🔐 [JWT] Login response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          final accessToken = data['accessToken'];
          final refreshToken = data['refreshToken'];
          final user = data['user'];
          final expiresIn = data['expiresIn'];
          final userId = user['_id'];

          await storeAuthData(
            accessToken: accessToken,
            refreshToken: refreshToken,
            userId: userId,
            expiresIn: expiresIn,
          );

          print('🔐 [JWT] Phone login successful for user: $userId');
          return data;
        }
      }

      print(
          '🔐 [JWT] Login failed with status ${response.statusCode}: ${response.body}');
      return null;
    } catch (e) {
      print('🔐 [JWT] Login error: $e');
      return null;
    }
  }

  // Refresh token
  Future<bool> refreshToken() async {
    try {
      print('🔐 [JWT] Attempting to refresh token');

      final refreshToken = await getRefreshToken();
      if (refreshToken == null) {
        print('🔐 [JWT] No refresh token available');
        return false;
      }

      final response = await http.post(
        Uri.parse('${JwtConfig.apiBaseUrl}/auth/refresh'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'refreshToken': refreshToken,
        }),
      );

      print('🔐 [JWT] Refresh response status: ${response.statusCode}');
      print('🔐 [JWT] Refresh response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          final accessToken = data['accessToken'];
          final newRefreshToken = data['refreshToken'];
          final expiresIn = data['expiresIn'];

          await setJwtToken(accessToken, expiresIn: expiresIn);
          await setRefreshToken(newRefreshToken);

          print('🔐 [JWT] Token refreshed successfully');
          return true;
        }
      }

      print('🔐 [JWT] Token refresh failed: ${response.body}');
      return false;
    } catch (e) {
      print('🔐 [JWT] Token refresh error: $e');
      return false;
    }
  }
}
