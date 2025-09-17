# 🔗 Deep Link Testing Guide

This guide explains how to test the comprehensive deep linking and sharing functionality implemented in your Flutter app.

## 🚀 **Quick Start Testing**

### **Method 1: In-App Testing**
1. **Navigate to Video Content page** in your app
2. **Tap the link icon (🔗)** in the AppBar to open the Deep Link Demo
3. **Use the comprehensive test interface** to test all features

### **Method 2: Direct Testing**
1. **Navigate to Video Content page**
2. **Tap the share icon (📤)** in the AppBar for share testing
3. **Tap the link icon (🔗)** in the AppBar for deep link testing

## 🧪 **Testing Features**

### **1. Share Options Testing**
- **Share**: Opens native share dialog with video info and links
- **Copy Link**: Copies both web URL and app deep link to clipboard
- **Open in App**: Attempts to open app, redirects to app store if not installed
- **Open in Browser**: Opens web URL in external browser

### **2. Deep Link Testing**
- **App Installation Check**: Verifies if the app can handle deep links
- **URL Generation**: Shows generated web and app URLs
- **App Store Fallback**: Tests redirect to app store when app not installed
- **Navigation Testing**: Tests in-app navigation to specific videos

### **3. Comprehensive Demo**
The Deep Link Demo page provides:
- **App Information**: Package name, version, build number
- **Installation Status**: Shows if app can handle deep links
- **Generated URLs**: Displays web and app deep link URLs
- **Test Functions**: All sharing and deep linking features
- **Advanced Tests**: Comprehensive testing suite

## 🔧 **External Testing Methods**

### **Method 1: ADB (Android Debug Bridge)**
```bash
# Test app deep link
adb shell am start -W -a android.intent.action.VIEW -d "indigorhaposy://video/test123" com.example.indigo_rhapsody_dupli

# Test web URL
adb shell am start -W -a android.intent.action.VIEW -d "https://indigorhaposy.com/video/test123"
```

### **Method 2: Browser Testing**
1. **Open browser** on your device
2. **Navigate to**: `https://indigorhaposy.com/video/test123`
3. **Should redirect** to app if installed, or show web page

### **Method 3: Cross-Device Testing**
1. **Share a video link** from the app
2. **Send to another device** (phone, tablet, computer)
3. **Test opening the link** on the receiving device
4. **Verify behavior** based on app installation status

### **Method 4: Manual URL Testing**
1. **Copy generated URLs** from the demo page
2. **Paste in different apps**: WhatsApp, Telegram, Email, etc.
3. **Test opening** from various sources

## 📱 **Expected Behaviors**

### **When App is Installed:**
- **App Deep Links**: Should open app and navigate to specific video
- **Web URLs**: Should open app (if configured) or web page
- **Share Options**: Should include both app and web links

### **When App is NOT Installed:**
- **App Deep Links**: Should redirect to appropriate app store
- **Web URLs**: Should open web page with app download option
- **Share Options**: Should still work with web fallback

## 🔍 **Debug Information**

### **Console Logs**
Look for these debug messages:
```
🔍 [DEEP_LINK] Deep link service initialized
🔍 [DEEP_LINK] App scheme: indigorhaposy
🔍 [DEEP_LINK] Web base URL: https://indigorhaposy.com
🔍 [DEEP_LINK] App info: {appName: ..., packageName: ..., version: ...}
🔍 [SHARE] Video shared successfully: videoId
🔍 [SHARE] Share URL: https://indigorhaposy.com/video/videoId
🔍 [SHARE] App deep link: indigorhaposy://video/videoId
```

### **Generated URLs**
- **Web URL**: `https://indigorhaposy.com/video/{videoId}`
- **App Deep Link**: `indigorhaposy://video/{videoId}`

## ⚙️ **Configuration**

### **App Store URLs**
Update these in `lib/services/deep_link_service.dart`:
```dart
static const String _playStoreUrl = 'https://play.google.com/store/apps/details?id=YOUR_APP_ID';
static const String _appStoreUrl = 'https://apps.apple.com/app/YOUR_APP_NAME/YOUR_APP_ID';
```

### **Web Domain**
Update in both services:
```dart
static const String _webBaseUrl = 'https://yourdomain.com';
```

## 🐛 **Troubleshooting**

### **Common Issues:**

1. **Deep links not working**
   - Check Android Manifest configuration
   - Verify iOS Info.plist settings
   - Ensure app scheme matches configuration

2. **App store not opening**
   - Verify app store URLs are correct
   - Check if URLs are accessible
   - Test on different platforms

3. **Share not working**
   - Check if share_plus is properly installed
   - Verify platform-specific permissions
   - Test on physical device (not emulator)

4. **Navigation not working**
   - Verify route names match
   - Check if navigator key is properly set
   - Ensure video content page exists

### **Testing Checklist:**
- [ ] App can handle deep links when installed
- [ ] App store opens when app not installed
- [ ] Web URLs work in browsers
- [ ] Share options work on all platforms
- [ ] Clipboard functionality works
- [ ] Navigation to specific videos works
- [ ] Cross-device sharing works
- [ ] Debug logs show correct information

## 📋 **Test Scenarios**

### **Scenario 1: Fresh Install**
1. Install app on device
2. Share video link
3. Open link on same device
4. Verify navigation to video

### **Scenario 2: Cross-Device Sharing**
1. Share video from device A
2. Send to device B (without app)
3. Open link on device B
4. Verify app store redirect

### **Scenario 3: Web Fallback**
1. Open web URL in browser
2. Verify web page loads
3. Check for app download option
4. Test app installation flow

### **Scenario 4: Multiple Apps**
1. Share video to WhatsApp
2. Share video to Email
3. Share video to Telegram
4. Verify all work correctly

## 🎯 **Success Criteria**

✅ **Deep links open app when installed**  
✅ **App store opens when app not installed**  
✅ **Web URLs work in browsers**  
✅ **Share options work on all platforms**  
✅ **Clipboard functionality works**  
✅ **Navigation to specific videos works**  
✅ **Cross-device sharing works**  
✅ **Debug information is logged**  

## 📞 **Support**

If you encounter issues:
1. Check console logs for error messages
2. Verify configuration settings
3. Test on different devices/platforms
4. Review troubleshooting section above

---

**Happy Testing! 🚀**
