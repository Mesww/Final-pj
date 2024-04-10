import 'dart:io' show Platform;

const REFRESH_TOKEN_KEY = 'refresh_token';
const BACKEND_TOKEN_KEY = 'backend_token';
const GOOGLE_ISSUER = 'https://accounts.google.com';
const GOOGLE_CLIENT_ID_IOS =
    '104159606172-bs5erik9t22n4tp0d5mdavhc7opmj805.apps.googleusercontent.com';
const GOOGLE_REDIRECT_URI_IOS =
    'com.googleusercontent.apps.104159606172-bs5erik9t22n4tp0d5mdavhc7opmj805:/oauthredirect';
const GOOGLE_CLIENT_ID_ANDROID = '<ANDROID-CLIENT-ID>';
const GOOGLE_REDIRECT_URI_ANDROID =
    'com.googleusercontent.apps.<ANDROID-CLIENT-ID>:/oauthredirect';

String clientID() {
  if (Platform.isAndroid) {
    return GOOGLE_CLIENT_ID_ANDROID;
  } else if (Platform.isIOS) {
    return GOOGLE_CLIENT_ID_IOS;
  }
  return '';
}

String redirectUrl() {
  if (Platform.isAndroid) {
    // print("android");
    return GOOGLE_REDIRECT_URI_ANDROID;
  } else if (Platform.isIOS) {
    // print("ios");
    return GOOGLE_REDIRECT_URI_IOS;
  }
  return '';
}
