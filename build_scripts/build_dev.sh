#!/bin/bash

# Development Build Script
# Builds the app for development environment

echo "🔧 Building for DEVELOPMENT environment..."

# Set environment variable
export ENVIRONMENT=development

# Build for development
flutter build apk --debug --dart-define=ENVIRONMENT=development

echo "✅ Development build completed!"
echo "📱 APK location: build/app/outputs/flutter-apk/app-debug.apk"
echo "🌍 Environment: Development"
echo "🔗 Base URL: https://indigo-rhapsody-backend-vzge.vercel.app"
