#!/usr/bin/env bash

# Script để build Flutter app và upload lên Firebase App Distribution
# Lưu ý: Trước khi chạy script này, cần cài đặt Firebase CLI và đăng nhập bằng lệnh:
# npm install -g firebase-tools
# firebase login
#-----------------------------------------------------------------------------
# chmod +x build.sh: Cấp quyền build.sh để có thể chạy trực tiếp
#-----------------------------------------------------------------------------
# Sử dụng: ./build.sh <flavor> <platform>
# Ví dụ: ./build.sh dev all
# Các flavor: dev | stg | prod
# Các platform: android | ios | all (mặc định là all)


cd "$(dirname "$0")/.." || exit
set -e

FLAVOR=$1
PLATFORM=$2

if [ -z "$FLAVOR" ]; then
  echo "❌ Vui lòng cung cấp flavor (dev | stg | prod)"
  exit 1
fi

FLAVOR_LOWER=$(echo "$FLAVOR" | tr '[:upper:]' '[:lower:]')

# === CONFIG FIREBASE ===
# Map flavor to Firebase app ID (lấy từ Firebase Console > App settings)
# Cập nhật các app ID tương ứng với từng flavor
FIREBASE_ANDROID_APP_ID_DEV="1:138723244274:android:7ea3f2ebcc4dca2198b86b"
FIREBASE_ANDROID_APP_ID_STG="1:829508193260:android:3080211f540301fed70ec9"
FIREBASE_ANDROID_APP_ID_PROD="1:xxxx:android:ghi789"

FIREBASE_IOS_APP_ID_DEV="1:138723244274:ios:1d0cdda337ad5cac98b86b"
FIREBASE_IOS_APP_ID_STG="1:829508193260:ios:f108b4b0cfa0eda2d70ec9"
FIREBASE_IOS_APP_ID_PROD="1:xxxx:ios:ghi789"

# Nhận app_id theo flavor
get_firebase_app_id() {
  if [[ "$1" == "android" ]]; then
    case "$FLAVOR_LOWER" in
      dev) echo "$FIREBASE_ANDROID_APP_ID_DEV" ;;
      stg) echo "$FIREBASE_ANDROID_APP_ID_STG" ;;
      prod) echo "$FIREBASE_ANDROID_APP_ID_PROD" ;;
    esac
  elif [[ "$1" == "ios" ]]; then
    case "$FLAVOR_LOWER" in
      dev) echo "$FIREBASE_IOS_APP_ID_DEV" ;;
      stg) echo "$FIREBASE_IOS_APP_ID_STG" ;;
      prod) echo "$FIREBASE_IOS_APP_ID_PROD" ;;
    esac
  fi
}

#NEW_VERSION=$(scripts/increase_build_number.sh)
#if [ $? -ne 0 ]; then
#    echo "Build increment failed"
#    revert_changes ""
#    exit 1
#fi

build_android() {
  echo "🚀 Build Android ($FLAVOR_LOWER)..."
  # shellcheck disable=SC2086
  flutter build apk --flavor $FLAVOR_LOWER -t lib/main_$FLAVOR_LOWER.dart

  # shellcheck disable=SC2154
  APK_PATH="build/app/outputs/flutter-apk/app-$FLAVOR_LOWER-release.apk"
  FIREBASE_APP_ID=$(get_firebase_app_id android)

  echo "📤 Upload APK lên Firebase App Distribution..."
  firebase appdistribution:distribute "$APK_PATH" \
    --app "$FIREBASE_APP_ID" \
    --groups "internal-testers" \
    --release-notes "$(date '+%Y年%m月%d日')時点修正バージョン"

  echo "✅ Đã upload Android build lên Firebase Dis"
}

build_ios() {
  echo "🚀 Build iOS ($FLAVOR_LOWER)..."
  # shellcheck disable=SC2086
  flutter build ipa --flavor $FLAVOR_LOWER -t lib/main_"$FLAVOR_LOWER".dart \
  --export-options-plist=ios/ExportConfig/"$FLAVOR_LOWER"_export_config.plist

  IPA_PATH=$(find build/ios/ipa -type f -name "*.ipa" | head -n 1)

  if [ ! -f "$IPA_PATH" ]; then
    echo "❌ Không tìm thấy file IPA sau khi build"
    exit 1
  fi
  FIREBASE_APP_ID=$(get_firebase_app_id ios)

  echo "📤 Upload IPA lên Firebase App Distribution..."
  firebase appdistribution:distribute "$IPA_PATH" \
    --app "$FIREBASE_APP_ID" \
    --groups "internal-testers" \
    --release-notes "$(date '+%Y年%m月%d日')時点修正バージョン"

  echo "✅ Đã upload iOS build lên Firebase Dis"
}

create_tag_and_mr() {
    local version=$1

    if [ -z "$version" ]; then
        echo "Error: Version not provided"
        revert_changes ""
        return 1
    fi

    local release_branch="release/$version"

    echo "Creating release branch $release_branch..."

    # Create and checkout the release branch
    git checkout -b "$release_branch"

    if [ $? -ne 0 ]; then
        echo "Failed to create release branch"
        revert_changes ""
        return 1
    fi

    # Add app/build.gradle and pubspec.yaml to git
    echo "Adding app/build.gradle and pubspec.yaml to git..."
    git add android/app/build.gradle pubspec.yaml
    git commit -m "Update app/build.gradle and pubspec.yaml for release $version"

    # Push the release branch to remote
    git push origin "$release_branch"

    if [ $? -ne 0 ]; then
        echo "Failed to push release branch"
        revert_changes "$release_branch"
        return 1
    fi

    echo "Release branch $release_branch created and pushed successfully"

    echo "Creating tag v$version..."

    # Create an annotated tag on the release branch
    git tag -a "v$version" -m "Release version $version"

    # Push the tag to remote
    git push origin "v$version"

    if [ $? -eq 0 ]; then
        echo "Tag v$version created and pushed successfully"

        # Call create_merge_request with the release branch
        create_merge_request "$version" "$release_branch"
    else
        echo "Failed to push tag"
        revert_changes "$release_branch"
        return 1
    fi
}

create_merge_request() {
    local version=$1
    local source_branch=$2
    local target_branch="develop"

    echo "Creating merge request from $source_branch to $target_branch..."

    # For GitLab (using glab CLI)
    if command -v glab &> /dev/null; then
        glab mr create \
            --source-branch "$source_branch" \
            --target-branch "$target_branch" \
            --title "Release v$version" \
            --description "Release version $version

- Tag: v$version
- Source: $source_branch
- Target: $target_branch"

        echo "GitLab merge request created"
        return 0
    fi
}


(./scripts/build_start.sh)

case "$PLATFORM" in
  android)
    build_android
    ;;
  ios)
    build_ios
    ;;
  all|"")
    build_android
    build_ios
    ;;
  *)
    echo "❌ Platform không hợp lệ. Sử dụng: android | ios | all"
    exit 1
    ;;
esac

#create_tag_and_mr "$NEW_VERSION"

