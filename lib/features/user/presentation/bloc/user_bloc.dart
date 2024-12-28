import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:vou_games/core/utils/failures/failure_utils.dart';
import 'package:vou_games/features/user/domain/entities/user_profile_entity.dart';
import 'package:vou_games/features/user/domain/usecases/get_user_profile_usecase.dart';
import 'package:vou_games/features/user/presentation/pages/user_homepage.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserProfileUseCase getUserProfileUseCase;

  UserBloc({required this.getUserProfileUseCase}) : super(UserInitialState()) {
    on<UserEvent>((event, emit) async {
      if (event is RequestNavigateToUserHomepageEvent) {
        emit(RequestNavigateToUserHomepageState());
      } else if (event is FetchUserProfileEvent) {
        emit(UserProfileLoadingState());
        // mock 0.5 second delay
        await Future.delayed(const Duration(milliseconds: 500));
        var failureOrUserProfile = await getUserProfileUseCase();
        failureOrUserProfile.fold(
          (failure) => emit(
              UserProfileErrorState(message: failureToErrorMessage(failure))),
          (userProfile) =>
              emit(UserProfileLoadedState(userProfile: userProfile)),
        );
      }
    });
  }
}
