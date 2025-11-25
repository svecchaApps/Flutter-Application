#!/bin/bash

# Production Run Script
# Runs the app in production environment

echo "🚀 Running in PRODUCTION environment..."

# Set environment variable
export ENVIRONMENT=production

# Run with production environment
flutter run --dart-define=ENVIRONMENT=production

echo "🌍 Environment: Production"
echo "🔗 Base URL: https://indigo-rhapsody-backend-ten.vercel.app"
