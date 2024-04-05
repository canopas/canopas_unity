echo $DESKTOP_CREDENTIALS_BASE64 | base64 -di > lib/desktop_credentials.dart
echo $FIREBASE_OPTIONS_BASE64 | base64 -di > lib/firebase_options.dart
echo $GOOGLE_SERVICES_JSON_BASE64 | base64 -di > android/app/google-services.json
echo $GOOGLE_SERVICES_PLIST_IOS_BASE64 | base64 -di > ios/Runner/GoogleService-Info.plist
echo $GOOGLE_SERVICES_PLIST_MACOS_BASE64 | base64 -di > macos/Runner/GoogleService-Info.plist
echo $DESKTOP_CREDENTIALS_BASE64  | base64 -di > lib/desktop_credentials.dart
echo $WEB_INDEX_HTML_BASE64  | base64 -di > web/index.html