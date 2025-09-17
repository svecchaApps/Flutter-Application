import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:io';

class DeepLinkService {
  static const String _appScheme = 'indigorhaposy';
  static const String _webBaseUrl = 'https://indigorhaposy.com';

  // App store URLs - Update these with your actual app URLs
  static const String _playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.example.indigo_rhapsody_dupli';
  static const String _appStoreUrl =
      'https://apps.apple.com/app/indigorhaposy/id123456789'; // Replace with actual App Store ID

  static final DeepLinkService _instance = DeepLinkService._internal();
  factory DeepLinkService() => _instance;
  DeepLinkService._internal();

  // Global navigator key for navigation
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Initialize deep link handling
  static Future<void> initialize() async {
    try {
      print('🔍 [DEEP_LINK] Deep link service initialized');
      print('🔍 [DEEP_LINK] App scheme: $_appScheme');
      print('🔍 [DEEP_LINK] Web base URL: $_webBaseUrl');

      // Get app info for debugging
      final appInfo = await getAppInfo();
      print('🔍 [DEEP_LINK] App info: $appInfo');
    } catch (e) {
      print('🔍 [DEEP_LINK] Error initializing deep link service: $e');
    }
  }

  /// Generate app deep link URL
  static String generateAppDeepLink(String videoId) {
    return '$_appScheme://video/$videoId';
  }

  /// Generate web URL for sharing
  static String generateWebUrl(String videoId) {
    return '$_webBaseUrl/video/$videoId';
  }

  /// Check if app is installed by trying to open a deep link
  static Future<bool> isAppInstalled() async {
    try {
      const testUrl = '$_appScheme://test';
      final uri = Uri.parse(testUrl);
      return await canLaunchUrl(uri);
    } catch (e) {
      return false;
    }
  }

  /// Open app store based on platform
  static Future<void> openAppStore() async {
    try {
      String storeUrl;
      if (Platform.isAndroid) {
        storeUrl = _playStoreUrl;
      } else if (Platform.isIOS) {
        storeUrl = _appStoreUrl;
      } else {
        // For web or other platforms, use Play Store as default
        storeUrl = _playStoreUrl;
      }

      final uri = Uri.parse(storeUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        print('🔍 [DEEP_LINK] Opened app store: $storeUrl');
      } else {
        print('🔍 [DEEP_LINK] Could not open app store');
      }
    } catch (e) {
      print('🔍 [DEEP_LINK] Error opening app store: $e');
    }
  }

  /// Open video in app or redirect to app store
  static Future<void> openVideoInApp(String videoId,
      {String? videoTitle}) async {
    try {
      final appDeepLink = generateAppDeepLink(videoId);
      final uri = Uri.parse(appDeepLink);

      print('🔍 [DEEP_LINK] Attempting to open: $appDeepLink');

      if (await canLaunchUrl(uri)) {
        // Try to open the app
        final launched = await launchUrl(uri);
        if (launched) {
          print('🔍 [DEEP_LINK] Successfully opened app with video: $videoId');
          return;
        }
      }

      // If app couldn't be opened, redirect to app store
      print('🔍 [DEEP_LINK] App not installed, redirecting to app store');
      await openAppStore();
    } catch (e) {
      print('🔍 [DEEP_LINK] Error opening video in app: $e');
      // Fallback to app store
      await openAppStore();
    }
  }

  /// Handle deep link URI
  static void _handleDeepLink(Uri uri) {
    print('🔍 [DEEP_LINK] Received deep link: $uri');

    if (uri.scheme == _appScheme) {
      final pathSegments = uri.pathSegments;

      if (pathSegments.isNotEmpty && pathSegments[0] == 'video') {
        if (pathSegments.length > 1) {
          final videoId = pathSegments[1];
          print('🔍 [DEEP_LINK] Opening video: $videoId');

          // Navigate to the video content page
          _navigateToVideo(videoId);
        }
      }
    } else if (uri.host.contains('indigorhaposy.com') ||
        uri.host.contains('indigorhaposy')) {
      // Handle web URLs
      final pathSegments = uri.pathSegments;

      if (pathSegments.isNotEmpty && pathSegments[0] == 'video') {
        if (pathSegments.length > 1) {
          final videoId = pathSegments[1];
          print('🔍 [DEEP_LINK] Opening video from web URL: $videoId');

          // Navigate to the video content page
          _navigateToVideo(videoId);
        }
      }
    }
  }

  /// Navigate to video content page
  static void _navigateToVideo(String videoId) {
    try {
      if (navigatorKey.currentState != null) {
        // Navigate to video content page with the specific video
        navigatorKey.currentState!.pushNamed(
          'VideoContent',
          arguments: {
            'videoId': videoId,
            'fromDeepLink': true,
          },
        );
        print('🔍 [DEEP_LINK] Navigated to video: $videoId');
      } else {
        print('🔍 [DEEP_LINK] Navigator not available');
      }
    } catch (e) {
      print('🔍 [DEEP_LINK] Error navigating to video: $e');
    }
  }

  /// Check if URL is a valid deep link
  static bool isValidDeepLink(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.scheme == _appScheme ||
          uri.host.contains('indigorhaposy.com') ||
          uri.host.contains('indigorhaposy');
    } catch (e) {
      return false;
    }
  }

  /// Get app package info for debugging
  static Future<Map<String, String>> getAppInfo() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      return {
        'appName': packageInfo.appName,
        'packageName': packageInfo.packageName,
        'version': packageInfo.version,
        'buildNumber': packageInfo.buildNumber,
      };
    } catch (e) {
      print('🔍 [DEEP_LINK] Error getting app info: $e');
      return {};
    }
  }

  /// Test deep linking functionality
  static Future<void> testDeepLinking(BuildContext context) async {
    try {
      const videoId = 'test123';
      const videoTitle = 'Test Video';

      // Test app installation check
      final isInstalled = await isAppInstalled();
      print('🔍 [DEEP_LINK] App installed: $isInstalled');

      // Test URL generation
      final shareUrl = generateWebUrl(videoId);
      final appDeepLink = generateAppDeepLink(videoId);

      print('🔍 [DEEP_LINK] Generated URLs:');
      print('  - Share URL: $shareUrl');
      print('  - App Deep Link: $appDeepLink');

      // Show test results
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Deep Link Test Results'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('App Installed: ${isInstalled ? "Yes" : "No"}'),
                  const SizedBox(height: 8),
                  const Text('Share URL:'),
                  SelectableText(shareUrl),
                  const SizedBox(height: 8),
                  const Text('App Deep Link:'),
                  SelectableText(appDeepLink),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await openVideoInApp(videoId, videoTitle: videoTitle);
                        },
                        child: const Text('Test App Link'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          final uri = Uri.parse(shareUrl);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri,
                                mode: LaunchMode.externalApplication);
                          }
                        },
                        child: const Text('Test Web Link'),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('🔍 [DEEP_LINK] Error testing deep linking: $e');
    }
  }
}
