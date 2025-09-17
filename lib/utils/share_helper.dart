import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/deep_link_service.dart';

class ShareHelper {
  static const String _appScheme = 'indigorhaposy';
  static const String _webBaseUrl = 'https://indigorhaposy.com';

  /// Generate a shareable URL for a video
  static String generateVideoShareUrl(String videoId, {String? videoTitle}) {
    // Create a web URL that can be shared
    final webUrl = '$_webBaseUrl/video/$videoId';
    return webUrl;
  }

  /// Generate app deep link URL
  static String generateAppDeepLink(String videoId) {
    return DeepLinkService.generateAppDeepLink(videoId);
  }

  /// Share a video with intelligent deep linking
  static Future<void> shareVideo({
    required String videoId,
    required String videoTitle,
    String? videoDescription,
    String? videoThumbnail,
  }) async {
    try {
      final shareUrl = generateVideoShareUrl(videoId, videoTitle: videoTitle);
      final appDeepLink = generateAppDeepLink(videoId);

      String shareText = 'Check out this amazing video: $videoTitle\n\n';
      if (videoDescription != null && videoDescription.isNotEmpty) {
        shareText += '$videoDescription\n\n';
      }
      shareText += 'Watch here: $shareUrl\n\n';
      shareText += '📱 Open in app: $appDeepLink';

      // Use system share (works on mobile)
      if (Platform.isAndroid || Platform.isIOS) {
        // For mobile, try to open share intent
        final uri = Uri.parse(
            'intent://share#Intent;action=android.intent.action.SEND;type=text/plain;S.android.intent.extra.TEXT=${Uri.encodeComponent(shareText)};end');
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        } else {
          // Fallback to clipboard
          await Clipboard.setData(ClipboardData(text: shareText));
        }
      } else {
        // For web or other platforms, copy to clipboard
        await Clipboard.setData(ClipboardData(text: shareText));
      }

      print('🔍 [SHARE] Video shared successfully: $videoId');
      print('🔍 [SHARE] Share URL: $shareUrl');
      print('🔍 [SHARE] App deep link: $appDeepLink');
    } catch (e) {
      print('🔍 [SHARE] Error sharing video: $e');
      rethrow;
    }
  }

  /// Copy video link to clipboard
  static Future<void> copyVideoLink(String videoId, String videoTitle) async {
    try {
      final shareUrl = generateVideoShareUrl(videoId, videoTitle: videoTitle);
      final appDeepLink = generateAppDeepLink(videoId);

      final fullText = 'Watch: $videoTitle\n\n'
          'Web: $shareUrl\n'
          'App: $appDeepLink';

      await Clipboard.setData(ClipboardData(text: fullText));

      print('🔍 [SHARE] Video link copied to clipboard');
      print('🔍 [SHARE] Share URL: $shareUrl');
      print('🔍 [SHARE] App deep link: $appDeepLink');
    } catch (e) {
      print('🔍 [SHARE] Error copying link: $e');
      rethrow;
    }
  }

  /// Open video in app or redirect to app store
  static Future<void> openVideoInApp(String videoId,
      {String? videoTitle}) async {
    return DeepLinkService.openVideoInApp(videoId, videoTitle: videoTitle);
  }

  /// Generate QR code data for video sharing
  static String generateVideoQRData(String videoId) {
    return generateVideoShareUrl(videoId);
  }

  /// Show comprehensive share options dialog
  static Future<void> showShareOptions({
    required BuildContext context,
    required String videoId,
    required String videoTitle,
    String? videoDescription,
  }) async {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Share Video',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Share button
                  Column(
                    children: [
                      IconButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await shareVideo(
                            videoId: videoId,
                            videoTitle: videoTitle,
                            videoDescription: videoDescription,
                          );
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Video shared!'),
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.share, size: 30),
                        color: Colors.blue,
                      ),
                      const Text('Share'),
                    ],
                  ),
                  // Copy link button
                  Column(
                    children: [
                      IconButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await copyVideoLink(videoId, videoTitle);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Link copied to clipboard!'),
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.copy, size: 30),
                        color: Colors.green,
                      ),
                      const Text('Copy Link'),
                    ],
                  ),
                  // Open in app button
                  Column(
                    children: [
                      IconButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await openVideoInApp(videoId, videoTitle: videoTitle);
                        },
                        icon: const Icon(Icons.open_in_new, size: 30),
                        color: Colors.orange,
                      ),
                      const Text('Open in App'),
                    ],
                  ),
                  // Open in browser button
                  Column(
                    children: [
                      IconButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          final url = generateVideoShareUrl(videoId,
                              videoTitle: videoTitle);
                          final uri = Uri.parse(url);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri,
                                mode: LaunchMode.externalApplication);
                          }
                        },
                        icon: const Icon(Icons.open_in_browser, size: 30),
                        color: Colors.purple,
                      ),
                      const Text('Open in Browser'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  /// Test deep linking functionality
  static Future<void> testDeepLinking(BuildContext context) async {
    return DeepLinkService.testDeepLinking(context);
  }

  /// Get app package info for debugging
  static Future<Map<String, String>> getAppInfo() async {
    return DeepLinkService.getAppInfo();
  }
}
