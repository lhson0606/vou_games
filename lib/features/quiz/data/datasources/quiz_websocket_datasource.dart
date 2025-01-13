import 'dart:async';
import 'dart:convert';
import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:vou_games/configs/server/websocket/websocket_config.dart';
import 'package:vou_games/core/builders/url/ws_url_builder.dart';
import 'package:vou_games/core/common/data/models/reward_piece_model.dart';
import 'package:vou_games/core/common/data/models/reward_voucher_model.dart';
import 'package:vou_games/core/error/exceptions.dart';
import 'package:vou_games/features/quiz/data/datasources/quiz_real_time_datasource_contract.dart';
import 'package:vou_games/features/quiz/data/models/quiz_connection_model.dart';
import 'package:vou_games/features/quiz/data/models/quiz_model.dart';
import 'package:vou_games/features/quiz/data/models/rank_model.dart';
import 'package:vou_games/features/quiz/data/models/solution_model.dart';
import 'package:vou_games/features/quiz/domain/controllers/quiz_real_time_listener.dart';
import 'package:web_socket_channel/io.dart';

class RealTimeQuizWebSocketDataSource implements QuizRealTimeDataSource {
  final GameSession _gameSession = GameSession(gameId: 0, token: "");

  @override
  Future<QuizConnectionModel> connectQuizGame(int gameId, String token) async {
    final url =
        WsUrlBuilderFactory.createJoinQuizUrlBuilder().gameId(gameId).build();
    final headers = getWSAuthorizedHeaders(token);

    if (_gameSession.hasSession()) {
      throw ExceptionWithMessage("Connection already established");
    }

    try {
      final channel = IOWebSocketChannel.connect(
        url,
        headers: headers,
      );
      await channel.ready;
      _gameSession.newGame(gameId, token, channel);
    } catch (e) {
      throw ExceptionWithMessage("Error connecting to the server");
    }

    return Future.value(const QuizConnectionModel(isConnected: true));
  }

  @override
  void setController(QuizRealTimeListener controller) {
    if (!_gameSession.hasSession()) {
      throw ExceptionWithMessage("Connection not established");
    }

    _gameSession.setController(controller);
  }

  @override
  void closeConnection() {
    if (_gameSession.hasSession()) {
      _gameSession.onDispose();
    }
  }
}

enum GameSessionState {
  NOT_STARTED,
  RECEIVING_NEW_QUESTION,
  RECEIVING_ANSWER,
  RECEIVING_RANKING,
  RECEIVING_REWARD,
  ENDED
}

class GameSession implements Disposable {
  IOWebSocketChannel? channel;
  QuizRealTimeListener? controller;
  int gameId;
  String token;
  GameSessionState state = GameSessionState.NOT_STARTED;
  Timer? _timer;
  int _timeRemaining = 10;

  GameSession({required this.gameId, required this.token});

  void newGame(int gameId, String token, IOWebSocketChannel channel) {
    if (hasSession()) {
      onDispose();
    }

    this.gameId = gameId;
    this.token = token;
    this.channel = channel;
    state = GameSessionState.NOT_STARTED;
  }

  void setController(QuizRealTimeListener controller) {
    this.controller = controller;
    channel?.stream.listen(
      (message) {
        switch (state) {
          case GameSessionState.NOT_STARTED:
            _handleGameStart(message);
            break;
          case GameSessionState.RECEIVING_NEW_QUESTION:
            _handleNewQuestion(message);
            break;
          case GameSessionState.RECEIVING_ANSWER:
            _handleAnswer(message);
            break;
          case GameSessionState.RECEIVING_RANKING:
            _handleRanking(message);
            break;
          case GameSessionState.RECEIVING_REWARD:
            _handleReward(message);
            break;
          case GameSessionState.ENDED:
            break;
        }
      },
      onDone: () {
        _handleGameEnded();
      },
      onError: (error) {
        _handleGameError(error);
      },
    );
  }

  void _handleGameStart(String welcomeMessage) {
    if (welcomeMessage == "Game is not open.") {
      controller?.onError(welcomeMessage);
      state = GameSessionState.ENDED;
      onDispose();
      return;
    }

    controller?.onSystemMessage(welcomeMessage);
    // game is now started, receiving first question
    state = GameSessionState.RECEIVING_NEW_QUESTION;
  }

  void _handleNewQuestion(message) {
    try {
      // need to check if the server is sending rank or question
      final json = jsonDecode(message) as Map<String, dynamic>;
      QuizModel quiz = QuizModel.fromJson(json);
      controller?.onNewQuizQuestion(quiz);
      // game is now receiving the answer for this question
      state = GameSessionState.RECEIVING_ANSWER;
      // start timer
      _startTimer();
    } catch (e) {
      // if it's not a question, it's the ranking
      _handleRanking(message);
    }
  }

  void _startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    _timeRemaining = 10; // Reset timer to 10 seconds
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        _timeRemaining--;
        controller?.onTimeRemaining(_timeRemaining);
      } else {
        timer.cancel();
        // Handle timeout if needed
      }
    });
  }

  void _handleAnswer(message) {
    final json = jsonDecode(message) as Map<String, dynamic>;
    controller?.onQuizQuestionAnswered(SolutionModel.fromJson(json));
    // game is now receiving the next question
    state = GameSessionState.RECEIVING_NEW_QUESTION;
  }

  void _handleRanking(message) {
    final json = jsonDecode(message) as Map<String, dynamic>;
    controller?.onQuizRanking(RankModel.fromJson(json));
    // game is now receiving the reward
    state = GameSessionState.RECEIVING_REWARD;
  }

  void _handleReward(message) {
    try {
      _handleRanking(message);
      return;
    } catch (e) {
      // it's a reward
    }
    // the ranking sometimes is duplicated, so we need to check if it's a reward
    try {
      final json = jsonDecode(message) as Map<String, dynamic>;
      // two types of reward:
      try {
        RewardPieceModel reward = RewardPieceModel.fromJson(json);
        controller?.onQuizReward(reward);
      } catch (e) {}

      try {
        RewardVoucherModel reward = RewardVoucherModel.fromJson(json);
        controller?.onQuizReward(reward);
      } catch (e) {}

      // no reward, game is now ended
      state = GameSessionState.ENDED;
      controller?.onQuizEnded();
      // clean up
      onDispose();
    } catch (e) {
      // it's a ranking, not a reward
      _handleRanking(message);
    }
  }

  void _handleGameEnded() {
    state = GameSessionState.ENDED;
    controller?.onSystemMessage("Game ended");
    onDispose();
  }

  void _handleGameError(error) {
    state = GameSessionState.ENDED;
    controller?.onSystemMessage("Game error: $error");
    onDispose();
  }

  bool hasSession() {
    return channel != null;
  }

  @override
  FutureOr onDispose() {
    _timer?.cancel(); // Clean up the timer
    channel?.sink.close();
    channel = null;
    controller = null;
    state = GameSessionState.ENDED;
    gameId = -1;
    token = "";
  }
}
