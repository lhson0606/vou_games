import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:vou_games/core/utils/failures/failure_utils.dart';
import 'package:vou_games/features/authentication/domain/entities/sign_in_entity.dart';
import 'package:vou_games/features/authentication/domain/usescases/check_logged_in_usecase.dart';
import 'package:vou_games/features/authentication/domain/usescases/log_out_usecase.dart';
import 'package:vou_games/features/authentication/domain/usescases/sign_in_usecase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase signInUsecase;
  final LogOutUseCase logOutUseCase;
  final CheckLoggedInUseCase checkLoggedInUseCase;

  AuthBloc({
    required this.signInUsecase,
    required this.logOutUseCase,
    required this.checkLoggedInUseCase,
  }) : super(AuthInitialState()) {
    on<AuthEvent>((event, emit) async {
      if (event is SignInWithEmailAndPassEvent) {
        emit(AuthLoadingState());
        var signInEntity = event.signInEntity;
        final failureOrUserCredential = await signInUsecase(signInEntity);
        emit(eitherToState(failureOrUserCredential, AuthSignedInState()));
      } else if (event is AuthLoggedOutEvent) {
        emit(AuthLoadingLoggedOutState());
        // mock waiting for 1 seconds
        await Future.delayed(const Duration(seconds: 1));
        final failureOrUnit = await logOutUseCase();
        emit(eitherToState(failureOrUnit, AuthLoggedOutState()));
      } else if (event is CheckLoggingInEvent) {
        emit(AuthLoadingState());
        final failureOrAuthInfo = await checkLoggedInUseCase();
        failureOrAuthInfo.fold(
                (failure) => emit(AuthErrorState(message: failureToErrorMessage(failure))),
                (authInfo) {
              if (authInfo.isLoggedIn) {
                emit(AuthSignedInState());
              } else {
                emit(AuthNotAuthenticatedState());
              }
            }
        );

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
}
