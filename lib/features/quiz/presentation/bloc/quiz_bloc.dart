import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:vou_games/features/quiz/presentation/pages/quiz_page.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(QuizInitialState()) {
    on<QuizEvent>((event, emit) {
      if(event is PlayQuizEvent){
        emit(RequestNavigateToQuizState(QuizPage(campaignId: event.campaignId)));
      }
    });
  }
}
