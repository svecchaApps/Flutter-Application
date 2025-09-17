# Share Functionality with Dynamic Linking

This implementation provides a complete video sharing system with dynamic linking for the Indigo Rhapsody app.

## 🚀 Features

- **Video Sharing**: Share videos via native share sheet
- **Dynamic Linking**: Custom URL scheme for deep linking
- **Web Fallback**: Beautiful web page for shared links
- **Multiple Share Options**: Share, Copy Link, QR Code (placeholder)
- **Cross-Platform**: Works on Android and iOS

## 📦 Dependencies Added

Add these to your `pubspec.yaml`:

```yaml
dependencies:
  share_plus: ^7.2.1
  url_launcher: 6.3.0  # Already included
```

## 🔧 Setup Instructions

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Android Configuration

Add to `android/app/src/main/AndroidManifest.xml` inside the `<application>` tag:

```xml
<activity>
    <!-- ... existing activity configuration ... -->
    
    <!-- Deep linking intent filter -->
    <intent-filter android:autoVerify="true">
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        
        <!-- Custom app scheme -->
        <data android:scheme="indigorhaposy" />
        
        <!-- Web URL scheme -->
        <data android:scheme="https" 
              android:host="indigorhaposy.com" />
    </intent-filter>
</activity>
```

### 3. iOS Configuration

Add to `ios/Runner/Info.plist`:

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLName</key>
        <string>com.indigorhaposy.app</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>indigorhaposy</string>
        </array>
    </dict>
</array>

<key>LSApplicationQueriesSchemes</key>
<array>
    <string>indigorhaposy</string>
</array>
```

### 4. Web Hosting Setup

1. **Upload the HTML file**: Upload `web/video_redirect.html` to your web server
2. **Configure URL routing**: Set up your web server to serve this file for `/video/*` routes
3. **Update domain**: Replace `indigorhaposy.com` with your actual domain in:
   - `lib/utils/share_helper.dart`
   - `lib/services/deep_link_service.dart`
   - `web/video_redirect.html`

## 🎯 Usage

### Basic Video Sharing

```dart
import '/utils/share_helper.dart';

// Share a video
await ShareHelper.shareVideo(
  videoId: 'video123',
  videoTitle: 'Amazing Fashion Video',
  videoDescription: 'Check out this incredible fashion content!',
);
```

### Show Share Options Dialog

```dart
ShareHelper.showShareOptions(
  context: context,
  videoId: 'video123',
  videoTitle: 'Amazing Fashion Video',
  videoDescription: 'Check out this incredible fashion content!',
);
```

### Copy Link to Clipboard

```dart
await ShareHelper.copyVideoLink('video123', 'Amazing Fashion Video');
```

## 🔗 URL Formats

### App URLs (Deep Links)
```
indigorhaposy://video/video123
```

### Web URLs (Shareable)
```
https://indigorhaposy.com/video/video123
```

## 📱 How It Works

1. **User shares video**: Taps share button in app
2. **Share dialog opens**: Shows options (Share, Copy Link, QR Code)
3. **Link generated**: Creates web URL with video ID
4. **Recipient clicks link**: Opens web page
5. **Web page redirects**: Attempts to open app with deep link
6. **App opens**: Navigates directly to the video

## 🛠️ Implementation Details

### ShareHelper (`lib/utils/share_helper.dart`)
- Handles video sharing functionality
- Generates shareable URLs
- Manages share options dialog
- Copy link to clipboard

### DeepLinkService (`lib/services/deep_link_service.dart`)
- Handles incoming deep links
- Manages app navigation from links
- URL validation and parsing

### Web Page (`web/video_redirect.html`)
- Beautiful landing page for shared links
- Auto-redirects to app
- Fallback to app store if app not installed
- Responsive design

## 🔄 Integration Points

### Video Content Widget
The share functionality is already integrated into:
- Shopping tab share button
- Fashion tab share button
- Comment section (if needed)

### Main App
Deep linking is initialized in `main.dart`:
```dart
await DeepLinkService.initialize();
```

## 🎨 Customization

### Change App Scheme
Update in both files:
- `lib/utils/share_helper.dart`
- `lib/services/deep_link_service.dart`

### Customize Web Page
Edit `web/video_redirect.html`:
- Colors and styling
- App store URLs
- Branding and messaging

### Add QR Code Generation
Install a QR code package and implement in `ShareHelper`:
```dart
// Example with qr_flutter package
import 'package:qr_flutter/qr_flutter.dart';

Widget generateQRCode(String videoId) {
  return QrImageView(
    data: ShareHelper.generateVideoQRData(videoId),
    version: QrVersions.auto,
    size: 200.0,
  );
}
```

## 🧪 Testing

### Test Deep Links
1. **App installed**: `adb shell am start -W -a android.intent.action.VIEW -d "indigorhaposy://video/test123" com.indigorhaposy.app`
2. **App not installed**: Open `https://indigorhaposy.com/video/test123` in browser

### Test Sharing
1. Open video content page
2. Tap share button
3. Choose share option
4. Verify link generation and sharing

## 🚨 Troubleshooting

### Deep Links Not Working
1. Check AndroidManifest.xml configuration
2. Verify iOS Info.plist setup
3. Ensure app scheme is unique
4. Test with adb commands

### Web Page Not Loading
1. Verify web server configuration
2. Check URL routing setup
3. Test direct web URL access
4. Validate HTML file upload

### Share Not Working
1. Check share_plus dependency
2. Verify platform permissions
3. Test on physical device
4. Check console logs for errors

## 📈 Analytics (Optional)

Add analytics tracking to monitor share usage:

```dart
// In ShareHelper.shareVideo()
analytics.logEvent(
  name: 'video_shared',
  parameters: {
    'video_id': videoId,
    'share_method': 'native_share',
  },
);
```

## 🔒 Security Considerations

1. **URL validation**: Always validate incoming deep links
2. **Video access control**: Ensure users can only access authorized videos
3. **Rate limiting**: Implement share rate limiting if needed
4. **Content moderation**: Consider content filtering for shared videos

## 🎯 Future Enhancements

1. **QR Code Generation**: Add QR code generation for easy sharing
2. **Social Media Integration**: Direct sharing to specific platforms
3. **Analytics Dashboard**: Track share performance and engagement
4. **A/B Testing**: Test different share messages and URLs
5. **Viral Features**: Add referral tracking and rewards

---

## 📞 Support

For issues or questions:
1. Check console logs for error messages
2. Verify all configuration steps
3. Test on both Android and iOS
4. Ensure web hosting is properly configured

The share functionality is now fully integrated and ready to use! 🎉
