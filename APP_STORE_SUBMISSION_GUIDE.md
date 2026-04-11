# App Store Submission Guide

This guide will walk you through creating a production build and submitting your iOS app to the App Store.

## Prerequisites

1. **Apple Developer Account** - Active paid membership ($99/year)
2. **Xcode** - Latest version installed
3. **App Store Connect Access** - Access to your app's App Store Connect page
4. **Certificates & Provisioning Profiles** - Set up in Apple Developer Portal

## Step 1: Prepare Your App

### 1.1 Update Version Numbers
Your current version is: `6.1.9+131`
- Version (6.1.9) = User-facing version
- Build Number (131) = Internal build number (must increment for each submission)

To update, edit `pubspec.yaml`:
```yaml
version: 6.1.9+132  # Increment build number
```

### 1.2 Verify Bundle Identifier
Current bundle ID: `com.mycompany.lsdapp`
- Ensure this matches your App Store Connect app
- Check in: Xcode → Runner target → General → Bundle Identifier

### 1.3 Verify App Store Configuration
- App name: IndigoRhapsody
- Bundle ID: com.mycompany.lsdapp
- Ensure all required app icons are present (1024x1024 required)

## Step 2: Build the Production IPA

### Option A: Using the Build Script (Recommended)

```bash
cd "/Users/rajat/Downloads/indigorhaposyfluttercode 2"
./build_scripts/build_ios_prod.sh
```

This will:
- Clean previous builds
- Install dependencies
- Build the IPA for App Store
- Output location: `build/ios/ipa/indigo_rhapsody_dupli.ipa`

### Option B: Manual Build

```bash
# Clean and get dependencies
flutter clean
flutter pub get

# Install CocoaPods
cd ios
pod install
cd ..

# Build IPA
flutter build ipa --release \
  --dart-define=ENVIRONMENT=production \
  --build-name=6.1.9 \
  --build-number=131
```

## Step 3: Archive in Xcode (Alternative Method)

If you prefer using Xcode directly:

1. **Open the workspace:**
   ```bash
   open ios/Runner.xcworkspace
   ```

2. **Select target:**
   - In Xcode, select "Any iOS Device" (not a simulator)

3. **Create Archive:**
   - Product → Archive
   - Wait for the build to complete

4. **Distribute App:**
   - In Organizer window, click "Distribute App"
   - Select "App Store Connect"
   - Choose "Upload"
   - Follow the wizard

## Step 4: Upload to App Store Connect

### Option A: Using Xcode Organizer

1. Open Xcode → Window → Organizer
2. Select your archive
3. Click "Distribute App"
4. Choose "App Store Connect"
5. Select "Upload"
6. Follow the signing and upload wizard

### Option B: Using Transporter App

1. Download "Transporter" from Mac App Store
2. Open Transporter
3. Drag and drop your `.ipa` file
4. Click "Deliver"
5. Wait for upload to complete

### Option C: Using Command Line (xcrun altool)

```bash
xcrun altool --upload-app \
  --type ios \
  --file "build/ios/ipa/indigo_rhapsody_dupli.ipa" \
  --username "your-apple-id@email.com" \
  --password "app-specific-password"
```

## Step 5: Configure App in App Store Connect

1. **Log in to App Store Connect:**
   - https://appstoreconnect.apple.com

2. **Select Your App:**
   - Go to "My Apps"
   - Select "IndigoRhapsody" (or create new app if needed)

3. **Prepare for Submission:**
   - Go to the app version you want to submit
   - Fill in required information:
     - Screenshots (required for all device sizes)
     - Description
     - Keywords
     - Support URL
     - Marketing URL (optional)
     - Privacy Policy URL (required)
     - App Category
     - Age Rating
     - App Review Information

4. **Select Build:**
   - After upload completes (may take 10-30 minutes)
   - Go to "Build" section
   - Select the uploaded build
   - Click "Done"

5. **Submit for Review:**
   - Review all information
   - Click "Submit for Review"
   - Answer export compliance questions if prompted

## Step 6: Monitor Submission

- **Processing:** Build is being processed (10-30 minutes)
- **Waiting for Review:** App is in queue for review
- **In Review:** Apple is reviewing your app
- **Pending Developer Release:** Approved, waiting for you to release
- **Ready for Sale:** App is live on App Store

## Important Notes

### Version & Build Number
- **Version:** User-facing version (e.g., 6.1.9)
- **Build Number:** Must be unique and incrementing (e.g., 131, 132, 133...)
- Each submission requires a new build number

### Certificates & Provisioning
- Ensure you have a valid **Distribution Certificate**
- Ensure you have a valid **App Store Provisioning Profile**
- Xcode can manage these automatically, or set up manually in Apple Developer Portal

### Testing
Before submitting:
- Test on a real device
- Test all critical features
- Verify push notifications work (production environment)
- Test in-app purchases if applicable
- Verify deep linking works

### Common Issues

1. **"Invalid Bundle" error:**
   - Check bundle identifier matches App Store Connect
   - Verify signing certificates are valid

2. **"Missing Compliance" error:**
   - Answer export compliance questions in App Store Connect
   - May need to provide encryption information

3. **"Missing Screenshots" error:**
   - Upload screenshots for all required device sizes
   - Minimum: iPhone 6.7" and 6.5" displays

4. **Build not appearing:**
   - Wait 10-30 minutes after upload
   - Check email for processing notifications
   - Verify build number is unique

## Quick Reference

### Build Command
```bash
flutter build ipa --release --dart-define=ENVIRONMENT=production
```

### Check Build Status
```bash
flutter build ipa --release --verbose
```

### Verify IPA
```bash
xcrun altool --validate-app \
  --type ios \
  --file "build/ios/ipa/indigo_rhapsody_dupli.ipa" \
  --username "your-apple-id@email.com" \
  --password "app-specific-password"
```

## Environment Configuration

Your app uses environment configuration:
- **Production:** `https://indigo-rhapsody-backend-ten.vercel.app`
- Set via: `--dart-define=ENVIRONMENT=production`

## Support

For issues:
- Apple Developer Support: https://developer.apple.com/support
- App Store Connect Help: https://help.apple.com/app-store-connect
- Flutter iOS Deployment: https://docs.flutter.dev/deployment/ios




