import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/features/authentication/domain/entities/sign_in_entity.dart';
import 'package:vou_games/features/authentication/domain/repositories/authentication_repository.dart';

class SignInUsecase {
  final AuthenticationRepository repository;

  SignInUsecase(this.repository);

  Future<Either<Failure, UserCredential>> call(
      SignInEntity signInPayload) async {
    return await repository.signIn(signInPayload);
  }
}
