import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:vou_games/core/utils/failures/failure_utils.dart';
import 'package:vou_games/features/notification/domain/entities/notification_entity.dart';
import 'package:vou_games/features/notification/domain/usecases/get_user_notification_usecase.dart';
import 'package:vou_games/features/notification/presentation/pages/notification_homepage.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetUserNotificationUseCase getUserNotificationUseCase;

  NotificationBloc({required this.getUserNotificationUseCase}) : super(NotificationInitial()) {
    on<NotificationEvent>((event, emit) async{
      if(event is RequestNavigateToNotificationHomepageEvent){
        emit(RequestNavigateToNotificationHomepageState());
      } else if(event is FetchNotificationEvent) {
        emit(FetchingNotificationState());
        // mock awaiting for 0.5 seconds
        await Future.delayed(const Duration(milliseconds: 500));
        final eitherFailureOrNotifications = await getUserNotificationUseCase();
        eitherFailureOrNotifications.fold(
          (failure) => emit(NotificationErrorState(failureToErrorMessage(failure))),
          (notifications) => emit(NotificationLoadedState(notifications)),
        );
      }
    });
  }
}
