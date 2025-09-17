import 'package:flutter/material.dart';
import 'share_helper.dart';

class ShareTest {
  /// Test the new share functionality
  static void testShareFunctionality(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Share Functionality Test'),
          content: const Text(
              'Testing the new share functionality without share_plus'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ShareHelper.showShareOptions(
                  context: context,
                  videoId: 'test123',
                  videoTitle: 'Test Video',
                  videoDescription:
                      'This is a test video for sharing functionality',
                );
              },
              child: const Text('Test Share Options'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await ShareHelper.copyVideoLink('test123', 'Test Video');
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Test: Link copied to clipboard!'),
                    ),
                  );
                }
              },
              child: const Text('Test Copy Link'),
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

  /// Test URL generation
  static void testUrlGeneration(BuildContext context) {
    final url =
        ShareHelper.generateVideoShareUrl('test123', videoTitle: 'Test Video');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('URL Generation Test'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Generated URL:'),
              const SizedBox(height: 8),
              SelectableText(url),
              const SizedBox(height: 16),
              const Text('This URL should work with deep linking!'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
