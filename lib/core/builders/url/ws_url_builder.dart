import 'package:vou_games/configs/server/websocket/websocket_config.dart' as ws_config;

class WsUrlBuilderFactory {
  static JoinQuizUrlBuilder createJoinQuizUrlBuilder() {
    return JoinQuizUrlBuilder();
  }

  static AnswerQuizUrlBuilder createAnswerQuizUrlBuilder() {
    return AnswerQuizUrlBuilder();
  }
}

class JoinQuizUrlBuilder {
  String _urlString = ws_config.Quiz.baseUrl;

  JoinQuizUrlBuilder gameId(int gameId) {
    if(!_urlString.contains("gameId=")) {
      _urlString += "?gameId=$gameId";
    } else {
      _urlString = _urlString.replaceFirst(RegExp(r'gameId=\d+'), "gameId=$gameId");
    }

    return this;
  }

  Uri build() {
    return Uri.parse(_urlString);
  }
}

class AnswerQuizUrlBuilder {
  String _urlString = ws_config.Quiz.baseUrl;

  AnswerQuizUrlBuilder gameId(int gameId) {
    if(!_urlString.contains("gameId=")) {
      _urlString += "?gameId=$gameId";
    } else {
      _urlString = _urlString.replaceFirst(RegExp(r'gameId=\d+'), "gameId=$gameId");
    }

    return this;
  }

  Uri build() {
    return Uri.parse(_urlString);
  }
}