import 'package:flutter/foundation.dart';

/// Environment configuration for the app
/// Supports development and production environments
class EnvironmentConfig {
  static const String _devBaseUrl =
      'https://indigo-rhapsody-backend-vzge.vercel.app';
  static const String _prodBaseUrl =
      'https://indigo-rhapsody-backend-ten.vercel.app';

  // Environment detection
  static bool get isDevelopment {
    // Check environment variable first
    const String env = String.fromEnvironment('ENVIRONMENT', defaultValue: '');
    if (env.isNotEmpty) {
      return env.toLowerCase() == 'development' || env.toLowerCase() == 'dev';
    }

    // Fallback to debug mode
    return kDebugMode;
  }

  static bool get isProduction => !isDevelopment;

  /// Get the base URL based on current environment
  static String get baseUrl {
    if (isDevelopment) {
      print('🔧 [ENV] Using DEVELOPMENT environment');
      print('🔧 [ENV] Base URL: $_devBaseUrl');
      return _devBaseUrl;
    } else {
      print('🚀 [ENV] Using PRODUCTION environment');
      print('🚀 [ENV] Base URL: $_prodBaseUrl');
      return _prodBaseUrl;
    }
  }

  /// Get environment name
  static String get environmentName {
    return isDevelopment ? 'development' : 'production';
  }

  /// Get API timeout duration based on environment
  static Duration get apiTimeout {
    return isDevelopment
        ? const Duration(seconds: 30) // Longer timeout for dev
        : const Duration(seconds: 15); // Shorter timeout for prod
  }

  /// Get logging level
  static bool get enableDetailedLogging {
    return isDevelopment;
  }

  /// Get debug information
  static Map<String, dynamic> get debugInfo {
    return {
      'environment': environmentName,
      'baseUrl': baseUrl,
      'isDevelopment': isDevelopment,
      'isProduction': isProduction,
      'apiTimeout': apiTimeout.inSeconds,
      'enableDetailedLogging': enableDetailedLogging,
    };
  }

  /// Print environment information
  static void printEnvironmentInfo() {
    print('🌍 [ENVIRONMENT CONFIG]');
    print('   Environment: $environmentName');
    print('   Base URL: $baseUrl');
    print('   API Timeout: ${apiTimeout.inSeconds}s');
    print('   Detailed Logging: $enableDetailedLogging');
    print('   Debug Mode: $kDebugMode');
  }
}
