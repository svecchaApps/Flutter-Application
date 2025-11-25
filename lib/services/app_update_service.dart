import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '/flutter_flow/flutter_flow_theme.dart';

/// Service to handle app updates for both Android and iOS
class AppUpdateService {
  static const String androidPackageId = 'com.mycompany.lsdapp';
  static const String iosAppId = '6471662460';

  /// Check for updates on both platforms
  static Future<void> checkForUpdates(BuildContext context) async {
    if (Platform.isAndroid) {
      await checkForAndroidUpdate(context);
    } else if (Platform.isIOS) {
      await checkForIOSUpdate(context);
    }
  }

  /// Android update check using in_app_update
  static Future<void> checkForAndroidUpdate(BuildContext context) async {
    try {
      print('🔄 [UPDATE] Checking for Android updates...');
      final updateInfo = await InAppUpdate.checkForUpdate();

      print(
          '🔄 [UPDATE] Update availability: ${updateInfo.updateAvailability}');

      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        print('🔄 [UPDATE] Update available!');

        // Check if update is high priority (staleness days)
        final int? staleDays = updateInfo.clientVersionStalenessDays;
        final bool isHighPriority = staleDays != null && staleDays >= 7;

        if (updateInfo.immediateUpdateAllowed && isHighPriority) {
          // For critical updates (app is 7+ days old), perform immediate update
          print('🔄 [UPDATE] Performing immediate update (high priority)');
          await InAppUpdate.performImmediateUpdate();
        } else if (updateInfo.flexibleUpdateAllowed) {
          // For regular updates, use flexible update
          print('🔄 [UPDATE] Starting flexible update');
          await InAppUpdate.startFlexibleUpdate();

          // Show snackbar when download completes
          _showUpdateCompletedSnackbar(context);
        }
      } else {
        print('🔄 [UPDATE] No updates available');
      }
    } catch (e) {
      print('🔄 [UPDATE] Android update error: $e');
    }
  }

  /// iOS update check using App Store API
  static Future<void> checkForIOSUpdate(BuildContext context) async {
    try {
      print('🔄 [UPDATE] Checking for iOS updates...');
      final packageInfo = await PackageInfo.fromPlatform();
      final bundleId = packageInfo.packageName;
      final currentVersion = packageInfo.version;
      print('🔄 [UPDATE] Current iOS version: $currentVersion');
      print('🔄 [UPDATE] Bundle ID: $bundleId');

      final url =
          Uri.parse('https://itunes.apple.com/lookup?bundleId=$bundleId');
      final response = await http.get(url);

      if (response.statusCode != 200) {
        print(
            '🔄 [UPDATE] Failed to check for updates: ${response.statusCode}');
        return;
      }

      final data = json.decode(response.body);

      if (data['resultCount'] == 1) {
        final latestVersion = data['results'][0]['version'];
        final releaseNotes =
            data['results'][0]['releaseNotes'] ?? 'Bug fixes and improvements';

        print('🔄 [UPDATE] Latest version: $latestVersion');

        if (_isNewerVersion(currentVersion, latestVersion)) {
          print('🔄 [UPDATE] Update available!');
          // Wait a bit before showing dialog to ensure context is ready
          Future.delayed(const Duration(milliseconds: 500), () {
            _showIOSUpdateDialog(context, latestVersion, releaseNotes);
          });
        } else {
          print('🔄 [UPDATE] App is up to date');
        }
      } else {
        print('🔄 [UPDATE] App not found in App Store');
      }
    } catch (e) {
      print('🔄 [UPDATE] iOS update check error: $e');
    }
  }

  /// Compare version numbers
  static bool _isNewerVersion(String currentVersion, String latestVersion) {
    try {
      List<int> current = currentVersion.split('.').map(int.parse).toList();
      List<int> latest = latestVersion.split('.').map(int.parse).toList();

      // Pad shorter version with zeros
      while (current.length < latest.length) current.add(0);
      while (latest.length < current.length) latest.add(0);

      for (int i = 0; i < current.length; i++) {
        if (latest[i] > current[i]) return true;
        if (latest[i] < current[i]) return false;
      }
      return false;
    } catch (e) {
      print('🔄 [UPDATE] Version comparison error: $e');
      return false;
    }
  }

  /// Show iOS update dialog
  static void _showIOSUpdateDialog(
    BuildContext context,
    String latestVersion,
    String releaseNotes,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(
                Icons.system_update,
                color: FlutterFlowTheme.of(dialogContext).primary,
              ),
              const SizedBox(width: 8),
              const Text('Update Available'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Version $latestVersion is now available.',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "What's New:",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: FlutterFlowTheme.of(dialogContext).secondaryText,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                releaseNotes,
                style: TextStyle(
                  color: FlutterFlowTheme.of(dialogContext).secondaryText,
                  fontSize: 14,
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Later',
                style: TextStyle(
                  color: FlutterFlowTheme.of(dialogContext).secondaryText,
                ),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: FlutterFlowTheme.of(dialogContext).primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Update Now'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                launchAppStore();
              },
            ),
          ],
        );
      },
    );
  }

  /// Show snackbar when Android update is downloaded
  static void _showUpdateCompletedSnackbar(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Update downloaded. Restart app to apply.'),
            action: SnackBarAction(
              label: 'RESTART',
              onPressed: () {
                InAppUpdate.completeFlexibleUpdate();
              },
            ),
            duration: const Duration(seconds: 10),
            backgroundColor: FlutterFlowTheme.of(context).primary,
          ),
        );
      }
    });
  }

  /// Launch the appropriate app store
  static Future<void> launchAppStore() async {
    final url = Uri.parse(
      Platform.isIOS
          ? 'https://apps.apple.com/app/id$iosAppId'
          : 'https://play.google.com/store/apps/details?id=$androidPackageId',
    );

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
        print('🔄 [UPDATE] Launched app store: $url');
      } else {
        print('🔄 [UPDATE] Could not launch $url');
      }
    } catch (e) {
      print('🔄 [UPDATE] Error launching app store: $e');
    }
  }

  /// Manual update check (can be called from settings)
  static Future<void> manualUpdateCheck(BuildContext context) async {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    await checkForUpdates(context);

    // Close loading indicator
    if (context.mounted) {
      Navigator.of(context).pop();

      // If no update was shown, show a message
      Future.delayed(const Duration(milliseconds: 500), () {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('You are using the latest version'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      });
    }
  }
}
