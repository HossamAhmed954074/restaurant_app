#!/bin/bash

# Script to fix withOpacity deprecation issues in Flutter project
# Replaces .withOpacity(value) with .withValues(alpha: value)

cd "/home/hossamahmed/Flutter Project/resturant_app"

echo "🔧 Fixing withOpacity deprecation issues..."

# Find all Dart files and replace withOpacity with withValues
find lib -name "*.dart" -type f -exec sed -i 's/\.withOpacity(\([^)]*\))/\.withValues(alpha: \1)/g' {} \;

echo "✅ Fixed withOpacity deprecation issues!"
echo "🔍 Checking for remaining issues..."

# Count remaining withOpacity issues
remaining=$(flutter analyze --no-fatal-infos 2>/dev/null | grep -c "withOpacity")
echo "📊 Remaining withOpacity issues: $remaining"
