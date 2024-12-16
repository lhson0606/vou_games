import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/core/strings/failure_message.dart';
import 'package:vou_games/features/authentication/domain/entities/sign_in_entity.dart';
import 'package:vou_games/features/authentication/domain/usescases/log_out_usecase.dart';
import 'package:vou_games/features/authentication/domain/usescases/sign_in_usecase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase signInUsecase;
  final LogOutUseCase logOutUseCase;

  AuthBloc({
    required this.signInUsecase,
    required this.logOutUseCase,
  }) : super(AuthInitialState()) {
    on<AuthEvent>((event, emit) async {
      if (event is SignInWithEmailAndPassEvent) {
        emit(AuthLoadingState());
        var signInEntity = event.signInEntity;
        final failureOrUserCredential = await signInUsecase(signInEntity);
        emit(eitherToState(failureOrUserCredential, AuthSignedInState()));
      } else if (event is AuthLoggedOutEvent) {
        emit(AuthLoadingLoggedOutState());
        // mock waiting for 2 seconds
        await Future.delayed(const Duration(seconds: 2));
        final failureOrUnit = await logOutUseCase();
        // mock failure
        emit(AuthErrorState(message: failureToErrorMessage(UnknownFailure())));
        // emit(eitherToState(failureOrUnit, AuthLoggedOutState()));
      } else if (event is CheckLoggingInEvent) {
        emit(AuthLoadingState());
        bool isSignedIn = false;

        if (isSignedIn) {
          emit(AuthSignedInState());
        } else {
          emit(AuthNotAuthenticatedState());
        }
      } else if (event is AuthSignedInEvent) {
        emit(AuthLoadingState());
        emit(AuthSignedInState());
      }
    });
  }

  AuthState eitherToState(Either either, AuthState state) {
    return either.fold(
        (failure) => AuthErrorState(message: failureToErrorMessage(failure)),
        (_) => state);
  }

  String failureToErrorMessage(Failure failure) {
    switch (failure) {
      case ServerFailure():
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure():
        return OFFLINE_FAILURE_MESSAGE;
      case TooManyRequestsFailure():
        return TOO_MANY_REQUESTS_FAILURE_MESSAGE;
      case NoUserFailure():
        return NO_USER_FAILURE_MESSAGE;
      case WrongPasswordFailure():
        return WRONG_PASSWORD_FAILURE_MESSAGE;
      default:
        return UNEXPECTED_FAILURE_MESSAGE;
    }
  }
}
