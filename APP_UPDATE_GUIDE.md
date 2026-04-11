# App Update System Guide

## Overview
This document describes the in-app update system for both Android (Play Store) and iOS (App Store) platforms.

## Features

### Android Updates (Google Play)
- **Flexible Updates**: Download in background, install when user restarts
- **Immediate Updates**: Force update for critical versions (7+ days old)
- **Update Priority**: Based on version staleness
- **In-App Install**: Users don't need to leave the app

### iOS Updates (App Store)
- **Version Check**: Compares local version with App Store version
- **Update Dialog**: Shows "What's New" from release notes
- **Optional Updates**: Users can choose "Later" or "Update Now"
- **Automatic Check**: Runs on app launch

## Configuration

### App Store IDs

#### Android (Play Store)
- **Package ID**: `com.mycompany.lsdapp`
- **Location**: `android/app/build.gradle`
- **Update in**: `lib/services/app_update_service.dart`

#### iOS (App Store)
- **App ID**: `6471662460`
- **App Store URL**: https://apps.apple.com/app/id6471662460
- **Update in**: `lib/services/app_update_service.dart`

## Implementation

### 1. Automatic Updates on App Launch

The app automatically checks for updates when launched:

```dart
// In lib/main.dart
Future.delayed(
  const Duration(milliseconds: 1000),
  () {
    _appStateNotifier.stopShowingSplashImage();
    _checkForUpdates(); // Automatic update check
  },
);
```

### 2. Using the Update Service

```dart
import 'package:indigo_rhapsody_dupli/services/app_update_service.dart';

// Check for updates
await AppUpdateService.checkForUpdates(context);

// Manual update check (for settings page)
await AppUpdateService.manualUpdateCheck(context);

// Launch app store directly
await AppUpdateService.launchAppStore();
```

### 3. Adding Update Check to Settings Page

You can add a manual update check button in your settings:

```dart
ListTile(
  leading: Icon(Icons.system_update),
  title: Text('Check for Updates'),
  subtitle: Text('Version ${packageInfo.version}'),
  onTap: () {
    AppUpdateService.manualUpdateCheck(context);
  },
)
```

## Update Flow

### Android Flow

```
1. App Launch
   ↓
2. Check Play Store for Updates
   ↓
3. Update Available?
   ├─ Yes (High Priority) → Immediate Update (Full Screen)
   ├─ Yes (Normal) → Flexible Update (Background)
   └─ No → Continue Normal Operation
   ↓
4. [Flexible Update] Download Completes
   ↓
5. Show Snackbar with "RESTART" Button
   ↓
6. User Taps Restart → App Restarts with New Version
```

### iOS Flow

```
1. App Launch
   ↓
2. Check App Store API
   ↓
3. Compare Versions
   ↓
4. Newer Version Available?
   ├─ Yes → Show Update Dialog
   │         ├─ "Later" → Dismiss
   │         └─ "Update Now" → Open App Store
   └─ No → Continue Normal Operation
```

## Visual Examples

### Android Flexible Update

```
┌─────────────────────────────────────┐
│  App continues to work normally     │
│                                     │
│  [Download happening in background] │
│                                     │
│  ╔════════════════════════════════╗│
│  ║ Update downloaded. Restart app ║│
│  ║ to apply.          [RESTART]   ║│
│  ╚════════════════════════════════╝│
└─────────────────────────────────────┘
```

### Android Immediate Update

```
┌─────────────────────────────────────┐
│                                     │
│       🔄 Updating App                │
│                                     │
│    [==========>        ] 67%        │
│                                     │
│    Please wait...                   │
│                                     │
└─────────────────────────────────────┘
```

### iOS Update Dialog

```
┌─────────────────────────────────────┐
│  🔄 Update Available                │
│                                     │
│  Version 2.1.0 is now available.   │
│                                     │
│  What's New:                        │
│  • Bug fixes and improvements       │
│  • New features added               │
│  • Performance enhancements         │
│                                     │
│         [Later]    [Update Now]     │
└─────────────────────────────────────┘
```

## Update Priorities

### Android

| Priority | Condition | Update Type | User Action |
|----------|-----------|-------------|-------------|
| Critical | 7+ days old | Immediate | Required, full screen |
| Normal | < 7 days old | Flexible | Optional, background |

### iOS

| Priority | Condition | Update Type | User Action |
|----------|-----------|-------------|-------------|
| All | New version | Dialog | Optional (Later/Update) |

## Dependencies

### Required Packages (already in pubspec.yaml)

```yaml
dependencies:
  in_app_update:          # Android Play Store updates
  package_info_plus: ^8.3.0  # Get app version info
  url_launcher: 6.3.0     # Open App Store links
  http: 1.2.2             # iOS App Store API calls
```

## Testing

### Android Testing

1. **Test Update Flow**:
   - Build and publish app to Play Store (internal test track)
   - Increment version number in `pubspec.yaml`
   - Build new version and upload to Play Store
   - Install old version on device
   - Open app → Update dialog should appear

2. **Test Update Types**:
   - **Flexible**: Set `priority` to 3 or less in Play Console
   - **Immediate**: Set `priority` to 4 or 5 in Play Console

### iOS Testing

1. **Test Update Check**:
   - App must be published to App Store (can use TestFlight)
   - Ensure Bundle ID matches: Check in Xcode
   - Lower version number in `pubspec.yaml`
   - Run app → Update dialog should appear

2. **Test Without Publishing**:
   ```dart
   // Temporarily modify version check for testing
   if (_isNewerVersion('1.0.0', '2.0.0')) {
     _showIOSUpdateDialog(context, '2.0.0', 'Test update');
   }
   ```

## Console Logs

### Android Logs

```
🔄 [UPDATE] Checking for Android updates...
🔄 [UPDATE] Update availability: UpdateAvailability.updateAvailable
🔄 [UPDATE] Update available!
🔄 [UPDATE] Starting flexible update
🔄 [UPDATE] Flexible update completed
```

### iOS Logs

```
🔄 [UPDATE] Checking for iOS updates...
🔄 [UPDATE] Current iOS version: 1.0.0
🔄 [UPDATE] Bundle ID: com.mycompany.lsdapp
🔄 [UPDATE] Latest version: 1.0.1
🔄 [UPDATE] Update available!
🔄 [UPDATE] Launched app store: https://apps.apple.com/app/id6471662460
```

## Troubleshooting

### Android

**Issue**: Update not showing
- Ensure app is distributed through Play Store (not APK sideload)
- Check version number is incremented
- Verify package ID matches Play Store listing
- Updates may take time to propagate (up to 24 hours)

**Issue**: Immediate update not working
- Check priority is set to 4 or 5 in Play Console
- Ensure device has Play Services installed
- Check app version staleness (7+ days required)

### iOS

**Issue**: Update dialog not appearing
- Verify app is published on App Store
- Check Bundle ID matches App Store listing
- Ensure version numbers use semantic versioning (1.0.0, 1.0.1, etc.)
- Check network connectivity for App Store API

**Issue**: App Store not opening
- Verify App ID is correct (6471662460)
- Check URL launcher permissions
- Test URL in browser first

## Best Practices

1. **Version Numbering**:
   - Use semantic versioning: MAJOR.MINOR.PATCH
   - Example: 1.0.0 → 1.0.1 (patch) → 1.1.0 (minor) → 2.0.0 (major)

2. **Update Frequency**:
   - Don't force users to update for minor changes
   - Reserve immediate/forced updates for critical bug fixes
   - Test updates thoroughly before release

3. **User Experience**:
   - Provide clear release notes
   - Allow users to postpone non-critical updates
   - Don't interrupt critical user flows

4. **Testing**:
   - Always test updates on internal tracks first
   - Test both update types (flexible/immediate for Android)
   - Verify app works correctly after update

## Release Checklist

- [ ] Increment version in `pubspec.yaml`
- [ ] Update version in `android/app/build.gradle` (versionCode & versionName)
- [ ] Update version in `ios/Runner/Info.plist` (CFBundleShortVersionString & CFBundleVersion)
- [ ] Write clear release notes
- [ ] Test app thoroughly
- [ ] Build release APK/IPA
- [ ] Upload to Play Store/App Store
- [ ] Test update flow with previous version
- [ ] Monitor crash reports after release

## Files Modified

- `lib/main.dart` - Main app update logic
- `lib/services/app_update_service.dart` - Centralized update service
- `pubspec.yaml` - Dependencies (already configured)

## Support

For issues or questions:
1. Check console logs for error messages
2. Verify app store configuration
3. Test on different devices
4. Check platform-specific documentation:
   - Android: https://developer.android.com/guide/playcore/in-app-updates
   - iOS: https://developer.apple.com/app-store/connect/

