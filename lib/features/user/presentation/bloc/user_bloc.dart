import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:vou_games/features/user/presentation/pages/user_homepage.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState()) {
    on<UserEvent>((event, emit) {
      if(event is RequestNavigateToUserHomepageEvent){
        emit(RequestNavigateToUserHomepageState());
      }
    });
  }
}
