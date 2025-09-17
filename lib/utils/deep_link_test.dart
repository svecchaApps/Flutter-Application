import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/deep_link_service.dart';

class DeepLinkTest {
  /// Test deep link functionality
  static Future<void> testDeepLink(BuildContext context) async {
    const videoId = 'test123';
    const appUrl = 'indigorhaposy://video/$videoId';
    const webUrl = 'https://indigorhaposy.com/video/$videoId';

    print('🔍 [DEEP_LINK_TEST] Testing deep link functionality...');
    print('🔍 [DEEP_LINK_TEST] App URL: $appUrl');
    print('🔍 [DEEP_LINK_TEST] Web URL: $webUrl');

    try {
      // Test app URL
      final appUri = Uri.parse(appUrl);
      if (await canLaunchUrl(appUri)) {
        await launchUrl(appUri);
        print('🔍 [DEEP_LINK_TEST] App URL launched successfully');
      } else {
        print('🔍 [DEEP_LINK_TEST] Cannot launch app URL');
      }

      // Test web URL
      final webUri = Uri.parse(webUrl);
      if (await canLaunchUrl(webUri)) {
        await launchUrl(webUri);
        print('🔍 [DEEP_LINK_TEST] Web URL launched successfully');
      } else {
        print('🔍 [DEEP_LINK_TEST] Cannot launch web URL');
      }
    } catch (e) {
      print('🔍 [DEEP_LINK_TEST] Error testing deep links: $e');
    }
  }

  /// Show test options dialog
  static void showTestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deep Link Test'),
          content: const Text('Choose a test option:'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                testDeepLink(context);
              },
              child: const Text('Test Deep Links'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                DeepLinkService.testDeepLinking(context);
              },
              child: const Text('Advanced Test'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  /// Test app store fallback
  static Future<void> testAppStoreFallback(BuildContext context) async {
    try {
      print('🔍 [DEEP_LINK_TEST] Testing app store fallback...');
      await DeepLinkService.openAppStore();
    } catch (e) {
      print('🔍 [DEEP_LINK_TEST] Error testing app store fallback: $e');
    }
  }

  /// Test video opening in app
  static Future<void> testVideoInApp(BuildContext context) async {
    try {
      const videoId = 'test123';
      const videoTitle = 'Test Video';

      print('🔍 [DEEP_LINK_TEST] Testing video opening in app...');
      await DeepLinkService.openVideoInApp(videoId, videoTitle: videoTitle);
    } catch (e) {
      print('🔍 [DEEP_LINK_TEST] Error testing video in app: $e');
    }
  }
}
