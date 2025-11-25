#!/bin/bash

# Development Run Script
# Runs the app in development environment

echo "🔧 Running in DEVELOPMENT environment..."

# Set environment variable
export ENVIRONMENT=development

# Run with development environment
flutter run --dart-define=ENVIRONMENT=development

echo "🌍 Environment: Development"
echo "🔗 Base URL: https://indigo-rhapsody-backend-vzge.vercel.app"
