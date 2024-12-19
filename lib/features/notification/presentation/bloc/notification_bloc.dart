import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:vou_games/features/notification/presentation/pages/notification_homepage.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<NotificationEvent>((event, emit) {
      if(event is RequestNavigateToNotificationHomepageEvent){
        emit(RequestNavigateToNotificationHomepageState());
      }
    });
  }
}
