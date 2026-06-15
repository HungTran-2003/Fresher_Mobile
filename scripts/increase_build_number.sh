#!/usr/bin/env bash

cd "$(dirname "$0")/.." || exit

#Path to pubspec.yaml file
PUBSPEC_FILE="pubspec.yaml"

# Check if pubspec.yaml exists
if [ ! -f "$PUBSPEC_FILE" ]; then
    echo "Error: pubspec.yaml not found!" >&2
    exit 1
fi

# Extract current version line
CURRENT_VERSION=$(grep "^version:" "$PUBSPEC_FILE")

if [ -z "$CURRENT_VERSION" ]; then
    echo "Error: No version found in pubspec.yaml!" >&2
    exit 1
fi

# Extract version name and build number
VERSION_NAME=$(echo "$CURRENT_VERSION" | sed 's/version: \([0-9]*\.[0-9]*\.[0-9]*\)+.*/\1/')
BUILD_NUMBER=$(echo "$CURRENT_VERSION" | sed 's/version: [0-9]*\.[0-9]*\.[0-9]*+\([0-9]*\)/\1/')

# Increment build number
NEW_BUILD_NUMBER=$((BUILD_NUMBER + 1))
NEW_VERSION="${VERSION_NAME}+${NEW_BUILD_NUMBER}"

# Send debug info to stderr so it doesn't interfere with the output
echo "Current version: $CURRENT_VERSION" >&2
echo "New version: $NEW_VERSION" >&2

# Replace the version line in pubspec.yaml
# Escape the + character in NEW_VERSION for sed
ESCAPED_VERSION=$(echo "$NEW_VERSION" | sed 's/+/\\+/g')
sed -i "" "s/^version:.*/version: $ESCAPED_VERSION/" "$PUBSPEC_FILE"

# Run flutter pub get quietly
if ! flutter pub get > /dev/null 2>&1; then
    echo "Error: flutter pub get failed!" >&2
    exit 1
fi

# Print ONLY the new version to stdout (this is what gets captured)
echo "$NEW_VERSION"

exit 0
