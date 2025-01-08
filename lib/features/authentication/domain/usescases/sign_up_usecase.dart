import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/features/authentication/domain/entities/post_sign_up_entity.dart';
import 'package:vou_games/features/authentication/domain/entities/sign_in_entity.dart';
import 'package:vou_games/features/authentication/domain/entities/sign_up_entity.dart';
import 'package:vou_games/features/authentication/domain/repositories/authentication_repository.dart';

import '../entities/auth_info_entity.dart';

class SignUpUseCase {
  final AuthenticationRepository repository;

  SignUpUseCase(this.repository);

  Future<Either<Failure, PostSignUpEntity>> call(
      SignUpEntity signUpPayload) async {
    return await repository.signUp(signUpPayload);
  }
}
