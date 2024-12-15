import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/core/strings/failure_message.dart';
import 'package:vou_games/features/authentication/domain/entities/sign_in_entity.dart';
import 'package:vou_games/features/authentication/domain/usescases/sign_in_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUsecase signInUsecase;

  AuthBloc({
    required this.signInUsecase,
  }) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if(event is SignInWithEmailAndPassEvent) {
        emit(AuthLoading());
        var signInEntity = event.signInEntity;
        final failureOrUserCredential = await signInUsecase(signInEntity);
        emit(eitherToState(failureOrUserCredential, AuthSignedIn()));
      }
      else if(event is AuthLoggedOutEvent){
        emit(AuthLoading());
        emit(AuthLoggedOut());
      }
      else if(event is CheckLoggingInEvent){
        emit(AuthLoading());
        bool isSignedIn = false;

        if(isSignedIn) {
          emit(AuthSignedIn());
        } else{
          emit(AuthNotAuthenticated());
        }
      }
      else if(event is AuthSignedInEvent) {
        emit(AuthLoading());
        emit(AuthSignedIn());
      }
    });
  }

  AuthState eitherToState(Either either, AuthState state) {
    return either.fold(
        (failure) => AuthError(message: failureToErrorMessage(failure)),
        (_) => state);
  }

  String failureToErrorMessage(Failure failure) {
    switch (failure) {
      case ServerFailure():
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure():
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return UNEXPECTED_FAILURE_MESSAGE;
    }
  }
}
