import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:vou_games/core/common/data/entities/game_item_entity.dart';
import 'package:vou_games/core/utils/failures/failure_utils.dart';
import 'package:vou_games/features/quiz/domain/controllers/quiz_real_time_listener.dart';
import 'package:vou_games/features/quiz/domain/entities/player_answer_entity.dart';
import 'package:vou_games/features/quiz/domain/entities/quiz_entity.dart';
import 'package:vou_games/features/quiz/domain/entities/rank_entity.dart';
import 'package:vou_games/features/quiz/domain/entities/solution_entity.dart';
import 'package:vou_games/features/quiz/domain/usecases/connect_quiz_game_usecase.dart';
import 'package:vou_games/features/quiz/domain/usecases/inform_ai_mc_usecase.dart';
import 'package:vou_games/features/quiz/domain/usecases/new_mc_session_usecase.dart';
import 'package:vou_games/features/quiz/domain/usecases/player_answer_quiz_usecase.dart';
import 'package:vou_games/features/quiz/domain/usecases/set_real_time_quiz_controller_usecase.dart';
import 'package:vou_games/features/quiz/domain/usecases/text_to_speech_usecase.dart';
import 'package:vou_games/features/quiz/presentation/pages/quiz_page.dart';

part 'quiz_event.dart';

part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  ConnectQuizGameUseCase connectQuizGameUseCase;
  SetRealTimeQuizControllerUseCase setRealTimeQuizControllerUseCase;
  PlayerAnswerQuizUseCase playerAnswerQuizUseCase;
  InformAiMcUseCase informAiMcUseCase;
  TextToSpeechUsecase textToSpeechUsecase;
  NewMCSessionUseCase newMCSessionUseCase;

  QuizBloc(
      {required this.connectQuizGameUseCase,
      required this.setRealTimeQuizControllerUseCase,
      required this.playerAnswerQuizUseCase,
      required this.informAiMcUseCase,
      required this.textToSpeechUsecase,
      required this.newMCSessionUseCase})
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
      } else if (event is PlayerAnswerQuizEvent) {
        final failureOrUnit =
            await playerAnswerQuizUseCase(event.gameId, event.answer);
        failureOrUnit.fold(
          (failure) =>
              emit(QuizErrorState(message: failureToErrorMessage(failure))),
          (unit) => emit(PlayerAnswerSuccessState(
              gameId: event.gameId, answer: event.answer)),
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
      } else if (event is AIMcSpeakingEvent) {
        emit(AIMCSpeakingState());
      } else if (event is AIMcStopSpeakingEvent) {
        emit(AIMcStopSpeakingState());
      }
    });
  }
}

class BlocQuizRealTimeListener extends QuizRealTimeListener {
  final QuizBloc quizBloc;
  String debugString = "";

  BlocQuizRealTimeListener({required this.quizBloc});


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
    informMCAndReadResponse("Question number ${quiz.questionNumber}. \n"
        "Question: ${quiz.questionTitle}. \n"
        "Extra content: ${quiz.questionContent}. \n"
        "Answer A: ${quiz.answerA}. \n"
        "Answer B: ${quiz.answerB}. \n"
        "Answer C: ${quiz.answerC}. \n"
        "Answer D: ${quiz.answerD}. \n");
    quizBloc.add(ControllerNewQuizQuestionEvent(quiz: quiz));
  }

  @override
  void onQuizEnded() {
    print(debugString);
    quizBloc.add(ControllerQuizEndedEvent());
    informMCAndReadResponse("The Quiz Game ended");
  }

  @override
  void onQuizQuestionAnswered(SolutionEntity ans) {
    debugString += ans.toString() + "\n";
    quizBloc.add(ControllerQuizSolutionEvent(solution: ans));
    informMCAndReadResponse(
        "The correct answer has been broadcast to all players:"
        " The answer for question number ${ans.questionNumber}is: ${ans.correctAnswer}. "
        "Explanation: ${ans.answerExplanation}.");
  }

  @override
  Future<void> onQuizStarted() async {
    debugString = 'quiz started' + "\n";
    quizBloc.newMCSessionUseCase();
    informMCAndReadResponse("The Quiz Game started");
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
    // informMCAndReadResponse("Say something random");
  }

  void informMCAndReadResponse(String message) async {
    final failureOrMcResponses = await quizBloc.informAiMcUseCase(message);
    failureOrMcResponses.fold(
      (failure) => quizBloc.add(
          ControllerQuizErrorEvent(message: failureToErrorMessage(failure))),
      (mcResponses) async {
        quizBloc.add(AIMcSpeakingEvent());
        for (final mcResponse in mcResponses) {
          await quizBloc.textToSpeechUsecase(mcResponse);
        }
        quizBloc.add(AIMcStopSpeakingEvent());
      },
    );
  }
}
