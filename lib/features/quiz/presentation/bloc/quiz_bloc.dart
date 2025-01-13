import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:vou_games/core/common/data/entities/game_item_entity.dart';
import 'package:vou_games/core/utils/failures/failure_utils.dart';
import 'package:vou_games/features/quiz/domain/controllers/quiz_real_time_listener.dart';
import 'package:vou_games/features/quiz/domain/entities/quiz_connection_entity.dart';
import 'package:vou_games/features/quiz/domain/entities/quiz_entity.dart';
import 'package:vou_games/features/quiz/domain/entities/rank_entity.dart';
import 'package:vou_games/features/quiz/domain/entities/solution_entity.dart';
import 'package:vou_games/features/quiz/domain/usecases/connect_quiz_game_usecase.dart';
import 'package:vou_games/features/quiz/domain/usecases/set_real_time_quiz_controller_usecase.dart';
import 'package:vou_games/features/quiz/presentation/pages/quiz_page.dart';

part 'quiz_event.dart';

part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  ConnectQuizGameUseCase connectQuizGameUseCase;
  SetRealTimeQuizControllerUseCase setRealTimeQuizControllerUseCase;

  QuizBloc(
      {required this.connectQuizGameUseCase,
      required this.setRealTimeQuizControllerUseCase})
      : super(QuizInitialState()) {
    on<QuizEvent>((event, emit) async {
      if (event is PlayQuizEvent) {
        emit(RequestNavigateToQuizState(QuizPage(
            campaignId: event.campaignId,
            gameId: event.gameId,
            startAt: event.startAt)));
      } else if (event is JoinQuizEvent) {
        final failureOrCon = await connectQuizGameUseCase(event.gameId);
        failureOrCon.fold(
          (failure) => emit(
              JoinQuizFailureState(message: failureToErrorMessage(failure))),
          (connection) {
            if (connection.isConnected) {
              setRealTimeQuizControllerUseCase(
                  BlocQuizRealTimeListener(quizBloc: this));
              emit(JoinQuizSuccessState());
            } else {
              emit(JoinQuizFailureState(message: "Error"));
            }
          },
        );
      } else if (event is ControllerSystemMessageEvent) {
        emit(SystemMessageState(message: event.message));
      } else if (event is ControllerQuizStartedEvent) {
        emit(QuizStartedState());
      } else if (event is ControllerNewQuizQuestionEvent) {
        emit(NewQuizState(quiz: event.quiz));
      } else if (event is ControllerQuizEndedEvent) {
        emit(QuizEndedState());
      } else if (event is ControllerQuizSolutionEvent) {
        emit(ShowQuizSolutionState(ans: event.solution));
      } else if (event is ControllerQuizStartedEvent) {
        emit(QuizStartedState());
      } else if (event is ControllerQuizRankingEvent) {
        emit(QuizRankingState(rank: event.rank));
      } else if (event is ControllerQuizRewardEvent) {
        emit(QuizRewardState(reward: event.reward));
      } else if (event is ControllerTimeRemainingEvent) {
        emit(TimeRemainingState(timeRemaining: event.timeRemaining));
      } else if (event is ControllerQuizErrorEvent) {
        emit(QuizErrorState(message: event.message));
      }
    });
  }
}

class BlocQuizRealTimeListener extends QuizRealTimeListener {
  final QuizBloc quizBloc;

  BlocQuizRealTimeListener({required this.quizBloc});

  String debugString = "";

  @override
  List<Object?> get props => [];

  @override
  void onSystemMessage(String message) {
    debugString += message.toString() + "\n";
    quizBloc.add(ControllerSystemMessageEvent(message: message));
  }

  @override
  void onNewQuizQuestion(QuizEntity quiz) {
    debugString += quiz.toString() + "\n";
    quizBloc.add(ControllerNewQuizQuestionEvent(quiz: quiz));
  }

  @override
  void onQuizEnded() {
    print(debugString);
    quizBloc.add(ControllerQuizEndedEvent());
  }

  @override
  void onQuizQuestionAnswered(SolutionEntity ans) {
    debugString += ans.toString() + "\n";
    quizBloc.add(ControllerQuizSolutionEvent(solution: ans));
  }

  @override
  void onQuizStarted() {
    debugString = 'quiz started' + "\n";
    quizBloc.add(ControllerQuizStartedEvent());
  }

  @override
  void onQuizRanking(RankEntity rank) {
    debugString += rank.toString() + "\n";
    quizBloc.add(ControllerQuizRankingEvent(rank: rank));
  }

  @override
  void onQuizReward(GameItemEntity? reward) {
    debugString += reward.toString() + "\n";
    quizBloc.add(ControllerQuizRewardEvent(reward: reward!));
  }

  @override
  void onTimeRemaining(int timeRemaining) {
    debugString += timeRemaining.toString() + " ";
    quizBloc.add(ControllerTimeRemainingEvent(timeRemaining: timeRemaining));
  }

  @override
  void onError(String errorMessage) {
    debugString += errorMessage.toString() + "\n";
    quizBloc.add(ControllerQuizErrorEvent(message: errorMessage));
  }

  @override
  void onPing() {
    print("alive");
  }
}
