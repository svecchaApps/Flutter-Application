#!/bin/bash

# Production Build Script
# Builds the app for production environment

echo "🚀 Building for PRODUCTION environment..."

# Set environment variable
export ENVIRONMENT=production

# Build for production
flutter build apk --release --dart-define=ENVIRONMENT=production

echo "✅ Production build completed!"
echo "📱 APK location: build/app/outputs/flutter-apk/app-release.apk"
echo "🌍 Environment: Production"
echo "🔗 Base URL: https://indigo-rhapsody-backend-ten.vercel.app"
