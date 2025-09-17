# JWT Authentication Implementation

This document describes the JWT (JSON Web Token) authentication system implemented in the Flutter application.

## Overview

The JWT authentication system provides secure API access by using tokens instead of session-based authentication. It works alongside Firebase Authentication for OTP verification and provides a unified authentication experience.

## Architecture

### Core Components

1. **JwtAuthManager** (`lib/auth/jwt_auth_manager.dart`)
   - Singleton class managing JWT token lifecycle
   - Handles token storage, retrieval, refresh, and validation
   - Provides authentication methods for login, registration, and phone verification

2. **JwtConfig** (`lib/auth/jwt_config.dart`)
   - Centralized configuration for API endpoints and settings
   - Contains all JWT-related constants and URLs

3. **JwtDebugHelper** (`lib/auth/jwt_debug_helper.dart`)
   - Debugging utilities for testing JWT functionality
   - Provides methods to test endpoints and inspect tokens

4. **ApiManager Integration** (`lib/backend/api_requests/api_manager.dart`)
   - Automatically injects JWT tokens into API request headers
   - Handles token refresh and authentication errors

## Authentication Flow

### 1. Email/Password Login

```dart
// Try JWT authentication first
final jwtResult = await JwtAuthManager.instance.loginWithEmail(
  email: email,
  password: password,
);

if (jwtResult != null) {
  // JWT login successful
  final user = jwtResult['user'];
  final userId = user?['_id'] ?? '';
  FFAppState().userId = userId;
  // Navigate to homepage
} else {
  // Fallback to Firebase authentication
}
```

### 2. Phone Number Login

```dart
// 1. Send OTP via Firebase
await authManager.beginPhoneAuth(phoneNumber: phoneNumber);

// 2. Verify OTP and get Firebase token
final user = await authManager.verifySmsCode(smsCode: otp);
final firebaseToken = await user.getIdToken();

// 3. Send Firebase token to backend for JWT authentication
final jwtResult = await JwtAuthManager.instance.verifyPhoneWithFirebaseToken(
  phoneNumber: phoneNumber,
  firebaseToken: firebaseToken,
);

if (jwtResult != null) {
  final isNewUser = jwtResult['isNewUser'] ?? false;
  if (isNewUser) {
    // Navigate to registration
  } else {
    // Login successful, navigate to homepage
  }
}
```

### 3. User Registration

```dart
// Get Firebase ID token for registration
final currentUser = FirebaseAuth.instance.currentUser;
final firebaseIdToken = await currentUser.getIdToken();

// Create user with JWT
final jwtResult = await JwtAuthManager.instance.createUser(
  email: email,
  password: password,
  displayName: displayName,
  phoneNumber: phoneNumber,
  firebaseIdToken: firebaseIdToken,
  role: 'User',
  isCreator: false,
  // ... other parameters
);

if (jwtResult != null) {
  // Registration successful
  final user = jwtResult['user'];
  final userId = user?['_id'] ?? '';
  FFAppState().userId = userId;
  // Navigate to add address page
}
```

## API Endpoints

### Authentication Endpoints

- **Login**: `POST /auth/login`
- **Register**: `POST /auth/register`
- **Refresh Token**: `POST /auth/refresh`
- **Send OTP**: `POST /auth/send-otp`
- **Verify OTP**: `POST /auth/verify-otp`
- **Verify Phone**: `POST /auth/verify-phone`
- **Check User Exists**: `POST /auth/check-user-exists`

### Request/Response Examples

#### Login Request
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

#### Login Response
```json
{
  "success": true,
  "message": "Login successful",
  "user": {
    "_id": "user_id",
    "email": "user@example.com",
    "displayName": "User Name",
    "phoneNumber": "+1234567890",
    "role": "User",
    "is_creator": false
  },
  "accessToken": "jwt_access_token",
  "refreshToken": "jwt_refresh_token",
  "expiresIn": "99d"
}
```

#### Phone Verification Request
```json
{
  "phoneNumber": "+1234567890",
  "firebaseIdToken": "firebase_id_token"
}
```

#### Phone Verification Response
```json
{
  "success": true,
  "message": "Phone verification successful",
  "isNewUser": false,
  "phoneNumber": "+1234567890",
  "firebaseUid": "firebase_user_id"
}
```

## Token Management

### Token Storage

Tokens are stored securely using `SharedPreferences`:

- **Access Token**: `jwt_access_token`
- **Refresh Token**: `jwt_refresh_token`
- **User ID**: `jwt_user_id`
- **Token Expiry**: `jwt_token_expiry`

### Token Refresh

The system automatically refreshes tokens when they expire:

```dart
// Check if token is expired
final expiry = prefs.getString(_tokenExpiryKey);
if (expiry != null) {
  final expiryDate = DateTime.parse(expiry);
  if (DateTime.now().isBefore(expiryDate)) {
    return token; // Token is valid
  } else {
    // Token expired, try to refresh
    final refreshed = await refreshToken();
    if (refreshed) {
      return await prefs.getString(_tokenKey);
    }
  }
}
```

### Automatic Token Injection

The `ApiManager` automatically injects JWT tokens into API request headers:

```dart
// Add JWT token to headers if available
try {
  final jwtToken = await _jwtAuthManager.getJwtToken();
  if (jwtToken != null) {
    headers['Authorization'] = 'Bearer $jwtToken';
  }
} catch (e) {
  print('Error getting JWT token: $e');
}
```

## Unified Authentication Check

The `isUserAuthenticated` getter in `auth_util.dart` provides a unified way to check authentication status:

```dart
bool get isUserAuthenticated {
  // Check Firebase authentication
  final hasFirebaseAuth = currentUser != null && currentPhoneNumber.isNotEmpty;
  
  // Check JWT authentication
  final hasJwtAuth = FFAppState().userId.isNotEmpty;
  
  return hasFirebaseAuth || hasJwtAuth;
}
```

## Debugging

### Debug Helper Methods

The `JwtDebugHelper` class provides comprehensive debugging capabilities:

```dart
// Test JWT configuration
await JwtDebugHelper.testJwtConfig();

// Test API connectivity
await JwtDebugHelper.testApiConnectivity();

// Get current authentication status
await JwtDebugHelper.getCurrentAuthStatus();

// Debug token details
await JwtDebugHelper.debugToken();

// Run all tests
await JwtDebugHelper.runAllTests();
```

### Debug Button

A debug button is available on the email login page to test JWT functionality:

```dart
ElevatedButton(
  onPressed: () async {
    await JwtDebugHelper.runAllTests();
  },
  child: const Text('Debug JWT System'),
)
```

## Error Handling

### Common Error Scenarios

1. **Token Expired**
   - System automatically attempts to refresh the token
   - If refresh fails, user is redirected to login

2. **Network Errors**
   - Fallback to Firebase authentication
   - User-friendly error messages displayed

3. **Invalid Credentials**
   - Clear error messages for login failures
   - Option to reset password or try again

### Error Messages

```dart
// Example error handling
if (response.statusCode != 200) {
  final errorData = jsonDecode(response.body);
  final errorMessage = errorData['message'] ?? 'Authentication failed';
  
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(errorMessage)),
  );
}
```

## Security Features

### Token Security

- Tokens are stored securely in `SharedPreferences`
- Automatic token refresh prevents session expiration
- Token validation on every API request

### API Security

- All API requests include JWT tokens in Authorization header
- HTTPS encryption for all API communications
- Token-based authentication instead of session-based

### Fallback Authentication

- Firebase Authentication as fallback
- Graceful degradation when JWT is unavailable
- Seamless user experience

## Configuration

### Environment Variables

Update `lib/auth/jwt_config.dart` with your backend URLs:

```dart
class JwtConfig {
  static const String apiBaseUrl = 'https://your-backend-url.com';
  static const String jwtSecret = 'your-jwt-secret';
  // ... other configuration
}
```

### Backend Requirements

The backend must support:

1. JWT token generation and validation
2. Firebase ID token verification
3. Token refresh functionality
4. User registration and login endpoints
5. Phone number verification

## Testing

### Manual Testing

1. **Email Login**: Test with valid/invalid credentials
2. **Phone Login**: Test OTP verification flow
3. **Registration**: Test new user creation
4. **Token Refresh**: Test automatic token refresh
5. **API Calls**: Test authenticated API requests

### Debug Testing

Use the debug button on the email login page to run comprehensive tests:

1. Configuration validation
2. API connectivity
3. Authentication status
4. Token inspection
5. Endpoint testing

## Troubleshooting

### Common Issues

1. **"Undefined name 'JwtAuthManager'"**
   - Ensure `jwt_auth_manager.dart` is properly imported
   - Check file exists in `lib/auth/` directory

2. **"Token expired" errors**
   - Check token refresh functionality
   - Verify backend refresh endpoint is working

3. **"Authentication failed"**
   - Check backend API endpoints
   - Verify request/response format
   - Check network connectivity

4. **"Firebase token is NULL"**
   - Ensure Firebase is properly configured
   - Check Firebase Authentication setup

### Debug Steps

1. Run `JwtDebugHelper.runAllTests()`
2. Check console logs for detailed error messages
3. Verify backend API endpoints are accessible
4. Test with Postman or similar tool
5. Check Firebase configuration

## Future Enhancements

### Planned Features

1. **Biometric Authentication**: Add fingerprint/face ID support
2. **Multi-factor Authentication**: Additional security layers
3. **Social Login**: Google, Facebook, Apple integration
4. **Offline Support**: Token caching for offline use
5. **Analytics**: Authentication event tracking

### Performance Optimizations

1. **Token Caching**: Implement memory caching for tokens
2. **Batch Requests**: Optimize multiple API calls
3. **Background Refresh**: Proactive token refresh
4. **Compression**: Reduce API payload sizes

## Support

For issues or questions regarding the JWT implementation:

1. Check the debug logs for detailed error information
2. Use the debug helper methods to test functionality
3. Verify backend API endpoints are working correctly
4. Ensure all dependencies are properly installed

## Dependencies

Required packages in `pubspec.yaml`:

```yaml
dependencies:
  http: ^1.1.0
  shared_preferences: ^2.2.2
  firebase_auth: ^4.15.3
  # ... other dependencies
```
