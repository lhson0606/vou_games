import 'dart:io';

const isDeployed = bool.fromEnvironment('IS_DEPLOYED', defaultValue: false);

/// Get the host based on the platform because the emulator uses a different host than the physical device
String getHost() {
  if(isDeployed) {
    return 'deployed host address here';
  }
  try {
    if (Platform.isAndroid || Platform.isIOS) {
      return 'http://10.0.2.2:';
    } else {
      return 'http://localhost:';
    }
  }
  catch (e) {
    // use default host if the platform is not recognized
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

Map<String, String> getAuthorizedHeaders(String? token) {
  if(token == null) {
    return headers;
  }

  return {
    ...headers,
    'Authorization': 'Bearer $token',
  };
}

// --- Auth ---
class Auth {
  static final String host = getHost();
  static const String requestMapping = '/api/auth';
  static final String baseUrl = '$host$port$requestMapping';
  static final String register = '$baseUrl/register';
  static final String verifyEmail = '$baseUrl/verify-email';
  static final String login = '$baseUrl/login';
}

// --- Campaign ---
class Campaign {
  static final String host = getHost();
  static const String requestMapping = '/api/core/campaigns';
  static final String baseUrl = '$host$port$requestMapping';
  static final String campaigns = baseUrl;
  static final String search = '$baseUrl/search';
  static final String game = '$baseUrl/{campaignId}/games';
}

// --- Game ---
class ShakeGame {
  static final String host = getHost();
  static const String requestMapping = '/api/core/games';
  static final String baseUrl = '$host$port$requestMapping';
  static final String playShakeGame = '$baseUrl/shake';
}