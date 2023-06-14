echo $DESKTOP_CREDENTIALS_BASE64  | base64 -di > lib/desktop_credentials.dart
   echo $FIREBASE_OPTIONS_BASE64  | base64 -di > lib/firebase_options.dart
echo $WEB_INDEX_HTML_BASE64  | base64 -di > web/index.html