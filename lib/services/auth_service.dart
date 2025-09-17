import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/app_state.dart';
import '/utils/modern_snackbar.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // Check if user is authenticated (either Firebase or JWT)
  static bool isAuthenticated() {
    return isUserAuthenticated;
  }

  // Check if user is a guest (not authenticated)
  static bool isGuest() {
    return !isAuthenticated();
  }

  // Logout and clear all authentication data
  static Future<void> logout(BuildContext context) async {
    try {
      // Clear Firebase authentication
      await authManager.signOut();

      // Clear JWT token and user data from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('ff_userId');
      await prefs.remove('ff_jwtToken');
      await prefs.remove('ff_userData');
      await prefs.remove('ff_cartId');
      await prefs.remove('ff_cartcreated');
      await prefs.remove('ff_applyCoupon');
      await prefs.remove('ff_likedVideo');

      // Clear app state
      final appState = FFAppState();
      appState.userId = '';
      appState.cartId = '';
      appState.cartcreated = false;
      appState.applyCoupon = false;
      appState.likedVideo = false;

      // Clear API manager cache and tokens
      _clearApiTokens();

      // Show success message
      ModernSnackbar.success(
        context: context,
        message: 'Successfully logged out',
      );

      // Navigate to login page
      if (context.mounted) {
        context.goNamed('loginOrGuest');
      }
    } catch (e) {
      print('Error during logout: $e');
      ModernSnackbar.error(
        context: context,
        message: 'Error during logout. Please try again.',
      );
    }
  }

  // Clear API tokens and cache
  static void _clearApiTokens() {
    // Clear any cached API tokens
    // This would depend on your API manager implementation
    try {
      // Clear API cache if available
      // ApiManager.clearCache();
    } catch (e) {
      print('Error clearing API cache: $e');
    }
  }

  // Handle guest user actions that require authentication
  static void requireAuth(
    BuildContext context, {
    String? message,
    String? redirectRoute,
  }) {
    const defaultMessage = 'Please login with your phone number to continue';
    const defaultRedirect = 'LoginMobileScreen';

    ModernSnackbar.warning(
      context: context,
      message: message ?? defaultMessage,
      duration: const Duration(seconds: 4),
    );

    // Navigate to mobile login page after a short delay
    Future.delayed(const Duration(milliseconds: 500), () {
      if (context.mounted) {
        context.pushNamed(redirectRoute ?? defaultRedirect);
      }
    });
  }

  // Check authentication before performing an action
  static Future<T?> withAuth<T>({
    required BuildContext context,
    required Future<T> Function() authenticatedAction,
    String? message,
    String? redirectRoute,
  }) async {
    if (isAuthenticated()) {
      return await authenticatedAction();
    } else {
      requireAuth(context, message: message, redirectRoute: redirectRoute);
      return null;
    }
  }

  // Show authentication required dialog
  static Future<bool> showAuthRequiredDialog(
    BuildContext context, {
    String title = 'Authentication Required',
    String message =
        'You need to be logged in to perform this action. Would you like to login with your phone number?',
  }) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.phone_android,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Phone number login only',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.phone_android,
                        size: 16,
                        color: Colors.white,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Login with Phone',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  // Handle authentication required with dialog
  static Future<void> requireAuthWithDialog(
    BuildContext context, {
    String title = 'Authentication Required',
    String message =
        'You need to be logged in to perform this action. Would you like to login with your phone number?',
    String? redirectRoute,
  }) async {
    final shouldLogin = await showAuthRequiredDialog(
      context,
      title: title,
      message: message,
    );

    if (shouldLogin && context.mounted) {
      context.pushNamed(redirectRoute ?? 'LoginMobileScreen');
    }
  }

  // Clear all user data (for account deletion or complete reset)
  static Future<void> clearAllUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Clear all user-related preferences
      final keys = prefs.getKeys();
      final userKeys = keys.where((key) =>
          key.startsWith('ff_') ||
          key.contains('user') ||
          key.contains('auth') ||
          key.contains('token') ||
          key.contains('cart'));

      for (final key in userKeys) {
        await prefs.remove(key);
      }

      // Clear app state
      final appState = FFAppState();
      appState.userId = '';
      appState.cartId = '';
      appState.cartcreated = false;
      appState.applyCoupon = false;
      appState.likedVideo = false;

      // Clear API tokens
      _clearApiTokens();
    } catch (e) {
      print('Error clearing user data: $e');
    }
  }

  // Get current authentication status
  static Map<String, dynamic> getAuthStatus() {
    return {
      'isAuthenticated': isAuthenticated(),
      'isGuest': isGuest(),
      'hasFirebaseAuth': currentUser != null && currentPhoneNumber.isNotEmpty,
      'hasJwtAuth': FFAppState().userId.isNotEmpty,
      'userId': FFAppState().userId,
      'phoneNumber': currentPhoneNumber,
    };
  }
}

// Extension for easy authentication checks
extension AuthExtension on BuildContext {
  bool get isAuthenticated => AuthService.isAuthenticated();
  bool get isGuest => AuthService.isGuest();

  Future<T?> withAuth<T>(
    Future<T> Function() authenticatedAction, {
    String? message,
    String? redirectRoute,
  }) {
    return AuthService.withAuth(
      context: this,
      authenticatedAction: authenticatedAction,
      message: message,
      redirectRoute: redirectRoute,
    );
  }

  void requireAuth({
    String? message,
    String? redirectRoute,
  }) {
    AuthService.requireAuth(
      this,
      message: message,
      redirectRoute: redirectRoute,
    );
  }

  Future<void> requireAuthWithDialog({
    String title = 'Authentication Required',
    String message =
        'You need to be logged in to perform this action. Would you like to login with your phone number?',
    String? redirectRoute,
  }) {
    return AuthService.requireAuthWithDialog(
      this,
      title: title,
      message: message,
      redirectRoute: redirectRoute,
    );
  }
}
