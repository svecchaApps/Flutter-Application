import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/deep_link_service.dart';
import 'share_helper.dart';

class DeepLinkDemo extends StatefulWidget {
  const DeepLinkDemo({super.key});

  @override
  State<DeepLinkDemo> createState() => _DeepLinkDemoState();
}

class _DeepLinkDemoState extends State<DeepLinkDemo> {
  Map<String, String> _appInfo = {};
  bool _isAppInstalled = false;
  final String _testVideoId = 'demo123';
  final String _testVideoTitle = 'Demo Video';

  @override
  void initState() {
    super.initState();
    _loadAppInfo();
    _checkAppInstallation();
  }

  Future<void> _loadAppInfo() async {
    final info = await DeepLinkService.getAppInfo();
    setState(() {
      _appInfo = info;
    });
  }

  Future<void> _checkAppInstallation() async {
    final installed = await DeepLinkService.isAppInstalled();
    setState(() {
      _isAppInstalled = installed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deep Link Demo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Info Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'App Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('App Name: ${_appInfo['appName'] ?? 'Unknown'}'),
                    Text('Package: ${_appInfo['packageName'] ?? 'Unknown'}'),
                    Text('Version: ${_appInfo['version'] ?? 'Unknown'}'),
                    Text('Build: ${_appInfo['buildNumber'] ?? 'Unknown'}'),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _isAppInstalled ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'App Installed: ${_isAppInstalled ? "Yes" : "No"}',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // URL Generation Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Generated URLs',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('Web URL:'),
                    SelectableText(
                      DeepLinkService.generateWebUrl(_testVideoId),
                      style: const TextStyle(
                        backgroundColor: Colors.grey,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('App Deep Link:'),
                    SelectableText(
                      DeepLinkService.generateAppDeepLink(_testVideoId),
                      style: const TextStyle(
                        backgroundColor: Colors.grey,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Test Buttons Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Test Functions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Share Options
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          ShareHelper.showShareOptions(
                            context: context,
                            videoId: _testVideoId,
                            videoTitle: _testVideoTitle,
                            videoDescription:
                                'This is a demo video for testing deep linking functionality.',
                          );
                        },
                        icon: const Icon(Icons.share),
                        label: const Text('Show Share Options'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Open in App
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          await DeepLinkService.openVideoInApp(
                            _testVideoId,
                            videoTitle: _testVideoTitle,
                          );
                        },
                        icon: const Icon(Icons.open_in_new),
                        label: const Text('Open Video in App'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Open in Browser
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final url =
                              DeepLinkService.generateWebUrl(_testVideoId);
                          final uri = Uri.parse(url);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri,
                                mode: LaunchMode.externalApplication);
                          }
                        },
                        icon: const Icon(Icons.open_in_browser),
                        label: const Text('Open in Browser'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // App Store
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          await DeepLinkService.openAppStore();
                        },
                        icon: const Icon(Icons.store),
                        label: const Text('Open App Store'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Copy Link
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          await ShareHelper.copyVideoLink(
                              _testVideoId, _testVideoTitle);
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Link copied to clipboard!'),
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.copy),
                        label: const Text('Copy Link to Clipboard'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Advanced Test Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Advanced Tests',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          DeepLinkService.testDeepLinking(context);
                        },
                        icon: const Icon(Icons.bug_report),
                        label: const Text('Run Deep Link Tests'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Instructions Section
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How to Test',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '1. Use "Show Share Options" to test the complete sharing flow\n'
                      '2. Use "Open Video in App" to test deep linking (will redirect to app store if app not installed)\n'
                      '3. Use "Open in Browser" to test web URL handling\n'
                      '4. Use "Copy Link" to test clipboard functionality\n'
                      '5. Use "Run Deep Link Tests" for comprehensive testing\n\n'
                      'For external testing:\n'
                      '- Share a link with another device\n'
                      '- Try opening the generated URLs in different apps\n'
                      '- Test on devices with and without the app installed',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
