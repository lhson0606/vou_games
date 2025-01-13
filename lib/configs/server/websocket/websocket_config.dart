import 'dart:io';

const isDeployed = bool.fromEnvironment('IS_DEPLOYED', defaultValue: false);

/// Get the host based on the platform because the emulator uses a different host than the physical device
String getHost() {
  if(isDeployed) {
    return 'deployed host address here';
  }
  try {
    if (Platform.isAndroid || Platform.isIOS) {
      return 'ws://10.0.2.2:';
    } else {
      return 'ws://localhost:';
    }
  }
  catch (e) {
    // use default host if the platform is not recognized
    return 'ws://localhost:';
  }
}

const int port = 8080;

const Map<String, String> headers = {
  'Connection': 'Upgrade',
  'Upgrade': 'websocket',
  'Sec-WebSocket-Version': '13',
  'Sec-WebSocket-Extensions': 'permessage-deflate; client_max_window_bits',
};

Map<String, String> getWSAuthorizedHeaders(String? token) {
  if(token == null) {
    return headers;
  }

  return {
    ...headers,
    'Authorization': 'Bearer $token',
  };
}

//--- Quiz ---
class Quiz {
  static final String host = getHost();
  static const String requestMapping = '/quiz';
  static final String baseUrl = '$host$port$requestMapping';
}