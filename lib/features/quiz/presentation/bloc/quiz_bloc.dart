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
              setRealTimeQuizControllerUseCase(BlocQuizRealTimeListener(quizBloc: this));
              emit(JoinQuizSuccessState());
            } else {
              emit(JoinQuizFailureState(message: "Error"));
            }
          },
        );
      }
    });
  }
}

class BlocQuizRealTimeListener extends QuizRealTimeListener {

  final QuizBloc quizBloc;

  BlocQuizRealTimeListener({required this.quizBloc});

  @override
  List<Object?> get props => [];

  @override
  void onSystemMessage(String message) {
    print("Controller: " + message);
  }

  @override
  void onNewQuizQuestion(QuizEntity quiz) {
    // TODO: implement onNewQuizQuestion
    print("Controller: " + quiz.toString());
  }

  @override
  void onQuizEnded() {
    // TODO: implement onQuizEnded
    print("Controller: " + "Quiz ended");
  }

  @override
  void onQuizQuestionAnswered(SolutionEntity ans) {
    // TODO: implement onQuizQuestionAnswered
    print("Controller: " + ans.toString());
  }

  @override
  void onQuizStarted() {
    // TODO: implement onQuizStarted
    print("Controller: " + "Quiz started");
  }

  @override
  void onQuizRanking(RankEntity rank) {
    // TODO: implement onQuizRanking
    print("Controller: " + rank.toString());
  }

  @override
  void onQuizReward(GameItemEntity? reward) {
    // TODO: implement onQuizReward
    print("Controller: " + reward.toString());
  }

  @override
  void onTimeRemaining(int timeRemaining) {
    // TODO: implement onTimeRemaining
    print("Controller: " + timeRemaining.toString());
  }

  @override
  void onError(String errorMessage) {
    // TODO: implement onError
    print("Controller: " + errorMessage);
  }
}
