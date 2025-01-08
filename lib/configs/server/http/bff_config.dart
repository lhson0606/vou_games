import 'dart:io';

/// Get the host based on the platform because the emulator uses a different host than the physical device
String getHost() {
  if (Platform.isAndroid || Platform.isIOS) {
    return 'http://10.0.2.2:';
  } else {
    return 'http://localhost:';
  }
}

const int port = 8080;
const Map<String, String> headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Cache-Control': 'no-cache, no-store, must-revalidate',
  'Pragma': 'no-cache',
  'Expires': '0',
};

// --- Auth ---
class Auth {
  static final String host = getHost();
  static const String requestMapping = '/api/auth';
  static final String baseUrl = '$host$port$requestMapping';
  static final String register = '$baseUrl/register';
  static final String verifyEmail = '$baseUrl/verify-email';
  static final String login = '$baseUrl/login';
}