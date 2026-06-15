cd "$(dirname "$0")" || exit 1

echo "Script running in: $(pwd)"

# go to project root
cd ..

echo "Project root: $(pwd)"
flutter clean
flutter pub get
flutter pub run intl_utils:generate
flutter pub run build_runner build --delete-conflicting-outputs

rm -rf build

## shellcheck disable=SC2164
#cd ios || { echo "Folder ios not found"; exit 1; }
#
#rm -rf Pods
#rm -f Podfile.lock
#rm -rf .symlinks
#
## shellcheck disable=SC2103
#cd ..
