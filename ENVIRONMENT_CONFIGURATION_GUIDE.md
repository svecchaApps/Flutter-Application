# Environment Configuration Guide

## 🌍 Environment Setup

This app now supports **development** and **production** environments with automatic URL switching.

## 📁 Files Created/Updated

### 1. Environment Configuration (`lib/config/environment_config.dart`)
- ✅ **Environment Detection** - Automatically detects dev/prod
- ✅ **URL Management** - Switches between dev and prod URLs
- ✅ **Debug Logging** - Enhanced logging for development
- ✅ **API Timeouts** - Different timeouts per environment

### 2. Updated Files
- ✅ `lib/backend/api_requests/api_calls.dart` - Main API calls
- ✅ `lib/backend/api_requests/banners_api.dart` - Banner API
- ✅ `lib/backend/api_requests/trending_products_api.dart` - Trending API
- ✅ `lib/backend/api_requests/recently_viewed_api.dart` - Recently viewed API
- ✅ `lib/auth/jwt_config.dart` - JWT configuration
- ✅ `lib/designer/paymentpage/paymentpage_widget.dart` - Payment webhook
- ✅ `lib/designer/homepage/homepage_widget.dart` - Homepage API calls
- ✅ `lib/designer/video_content/video_content_widget.dart` - Video API calls
- ✅ `lib/designer/pages/otp_login/otp_login_widget.dart` - OTP login
- ✅ `lib/designer/pages/searchpage1/searchpage1_widget.dart` - Search API

## 🔧 Environment Detection

### Development Environment
```dart
// Automatically detected when:
// 1. kDebugMode = true (Flutter debug mode)
// 2. ENVIRONMENT=development (build-time flag)
// 3. ENVIRONMENT=dev (build-time flag)

EnvironmentConfig.isDevelopment // true
EnvironmentConfig.baseUrl // 'https://indigo-rhapsody-backend-vzge.vercel.app'
```

### Production Environment
```dart
// Automatically detected when:
// 1. kDebugMode = false (Flutter release mode)
// 2. ENVIRONMENT=production (build-time flag)
// 3. ENVIRONMENT=prod (build-time flag)

EnvironmentConfig.isProduction // true
EnvironmentConfig.baseUrl // 'https://indigo-rhapsody-backend-ten.vercel.app'
```

## 🚀 Usage Examples

### Basic Usage
```dart
import '/config/environment_config.dart';

// Get current environment
String env = EnvironmentConfig.environmentName; // 'development' or 'production'

// Get base URL
String baseUrl = EnvironmentConfig.baseUrl;

// Check environment
if (EnvironmentConfig.isDevelopment) {
  print('Running in development mode');
}
```

### API Calls
```dart
// Before (hardcoded)
final response = await http.get(
  Uri.parse('https://indigo-rhapsody-backend-ten.vercel.app/products'),
);

// After (environment-aware)
final response = await http.get(
  Uri.parse('${EnvironmentConfig.baseUrl}/products'),
);
```

### Debug Information
```dart
// Print environment info
EnvironmentConfig.printEnvironmentInfo();

// Get debug info
Map<String, dynamic> info = EnvironmentConfig.debugInfo;
print('Environment: ${info['environment']}');
print('Base URL: ${info['baseUrl']}');
```

## 🛠️ Build Commands

### Development Build
```bash
# Debug mode (automatically development)
flutter run

# Explicit development
flutter run --dart-define=ENVIRONMENT=development

# Alternative
flutter run --dart-define=ENVIRONMENT=dev
```

### Production Build
```bash
# Release mode (automatically production)
flutter build apk --release

# Explicit production
flutter build apk --release --dart-define=ENVIRONMENT=production

# Alternative
flutter build apk --release --dart-define=ENVIRONMENT=prod
```

### Web Build
```bash
# Development
flutter build web --dart-define=ENVIRONMENT=development

# Production
flutter build web --dart-define=ENVIRONMENT=production
```

## 📱 Environment URLs

### Development
- **Base URL**: `https://indigo-rhapsody-backend-vzge.vercel.app`
- **API Timeout**: 30 seconds
- **Debug Logging**: Enabled
- **Features**: Extended logging, longer timeouts

### Production
- **Base URL**: `https://indigo-rhapsody-backend-ten.vercel.app`
- **API Timeout**: 15 seconds
- **Debug Logging**: Disabled
- **Features**: Optimized performance, minimal logging

## 🔍 Environment Detection Logic

```dart
static bool get isDevelopment {
  // 1. Check build-time environment variable
  const String? env = String.fromEnvironment('ENVIRONMENT');
  if (env != null) {
    return env.toLowerCase() == 'development' || env.toLowerCase() == 'dev';
  }
  
  // 2. Fallback to Flutter debug mode
  return kDebugMode;
}
```

## 📊 Environment Features

| Feature | Development | Production |
|---------|-------------|------------|
| **Base URL** | `indigo-rhapsody-backend-vzge.vercel.app` | `indigo-rhapsody-backend-ten.vercel.app` |
| **API Timeout** | 30 seconds | 15 seconds |
| **Debug Logging** | ✅ Enabled | ❌ Disabled |
| **Error Details** | ✅ Full details | ⚠️ Minimal |
| **Performance** | ⚠️ Slower (debug) | ✅ Optimized |

## 🧪 Testing Environments

### Test Development Environment
```bash
# Run with development environment
flutter run --dart-define=ENVIRONMENT=development

# Check logs for:
# 🔧 [ENV] Using DEVELOPMENT environment
# 🔧 [ENV] Base URL: https://indigo-rhapsody-backend-dev.vercel.app
```

### Test Production Environment
```bash
# Run with production environment
flutter run --dart-define=ENVIRONMENT=production

# Check logs for:
# 🚀 [ENV] Using PRODUCTION environment
# 🚀 [ENV] Base URL: https://indigo-rhapsody-backend-ten.vercel.app
```

## 🔧 Configuration Options

### Custom Environment Variables
```dart
// You can add more environment variables
static String get customApiKey {
  const String? key = String.fromEnvironment('API_KEY');
  return key ?? 'default-key';
}

static bool get enableAnalytics {
  const String? analytics = String.fromEnvironment('ANALYTICS');
  return analytics?.toLowerCase() == 'true';
}
```

### Environment-Specific Features
```dart
// Different features per environment
static bool get enableCrashReporting {
  return isProduction; // Only in production
}

static bool get enableDebugTools {
  return isDevelopment; // Only in development
}

static String get logLevel {
  return isDevelopment ? 'DEBUG' : 'ERROR';
}
```

## 📝 Migration Summary

### Before (Hardcoded URLs)
```dart
// ❌ Hardcoded everywhere
const String baseUrl = 'https://indigo-rhapsody-backend-ten.vercel.app';
final response = await http.get(Uri.parse('$baseUrl/products'));
```

### After (Environment-Aware)
```dart
// ✅ Environment-aware
final response = await http.get(
  Uri.parse('${EnvironmentConfig.baseUrl}/products')
);
```

## 🎯 Benefits

### 1. **Automatic Environment Detection**
- No manual configuration needed
- Works in debug/release modes
- Supports build-time flags

### 2. **Centralized Configuration**
- Single source of truth
- Easy to maintain
- Consistent across app

### 3. **Development-Friendly**
- Enhanced logging in dev mode
- Longer timeouts for debugging
- Clear environment indicators

### 4. **Production-Optimized**
- Minimal logging
- Faster timeouts
- Optimized performance

### 5. **Flexible Deployment**
- Easy switching between environments
- Build-time configuration
- No code changes needed

## 🚀 Quick Start

### 1. Development
```bash
# Just run normally - automatically uses development
flutter run
```

### 2. Production
```bash
# Build for production
flutter build apk --release
```

### 3. Custom Environment
```bash
# Use specific environment
flutter run --dart-define=ENVIRONMENT=development
```

## 🔍 Debugging

### Check Current Environment
```dart
// In your app
print('Current environment: ${EnvironmentConfig.environmentName}');
print('Base URL: ${EnvironmentConfig.baseUrl}');
print('Is development: ${EnvironmentConfig.isDevelopment}');
```

### Environment Info
```dart
// Get full environment info
Map<String, dynamic> info = EnvironmentConfig.debugInfo;
print('Environment Info: $info');
```

## 📋 Checklist

- ✅ Environment configuration created
- ✅ All API files updated
- ✅ URL references replaced
- ✅ Import statements added
- ✅ Build commands documented
- ✅ Testing instructions provided
- ✅ Migration guide created

## 🎉 Result

Your app now has:
- 🌍 **Automatic environment detection**
- 🔄 **Dynamic URL switching**
- 🛠️ **Development-friendly features**
- 🚀 **Production-optimized performance**
- 📱 **Easy deployment options**

**All hardcoded URLs have been replaced with environment-aware configuration!** 🎊
