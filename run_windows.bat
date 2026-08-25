@echo off
setlocal
where flutter >nul 2>nul
if errorlevel 1 (
  echo Flutter was not found on PATH.
  echo Install Flutter from https://docs.flutter.dev/get-started/install/windows-desktop
  exit /b 1
)
flutter config --enable-windows-desktop
if not exist windows\CMakeLists.txt (
  flutter create --platforms=windows .
)
flutter pub get
flutter run -d windows
endlocal
