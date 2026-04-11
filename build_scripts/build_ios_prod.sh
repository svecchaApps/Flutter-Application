#!/bin/bash

# iOS Production Build Script for App Store
# This script builds the iOS app for App Store submission

set -e  # Exit on error

echo "🚀 Building iOS app for PRODUCTION (App Store)..."

# Set environment variable
export ENVIRONMENT=production

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Install/Update CocoaPods
echo "📱 Installing CocoaPods dependencies..."
cd ios
pod install --repo-update
cd ..

# Build iOS app for release (App Store)
echo "🔨 Building iOS app for App Store..."
flutter build ipa --release \
  --dart-define=ENVIRONMENT=production \
  --build-name=6.1.9 \
  --build-number=131

echo ""
echo "✅ Production iOS build completed!"
echo "📱 IPA location: build/ios/ipa/indigo_rhapsody_dupli.ipa"
echo "🌍 Environment: Production"
echo "🔗 Base URL: https://indigo-rhapsody-backend-ten.vercel.app"
echo ""
echo "📋 Next steps:"
echo "   1. Open Xcode: open ios/Runner.xcworkspace"
echo "   2. Select 'Any iOS Device' as target"
echo "   3. Product > Archive"
echo "   4. Distribute App > App Store Connect"
echo "   5. Follow the upload wizard"
echo ""
echo "   OR use the IPA directly:"
echo "   - Upload build/ios/ipa/indigo_rhapsody_dupli.ipa to App Store Connect"
echo "   - Use Transporter app or Xcode Organizer"




