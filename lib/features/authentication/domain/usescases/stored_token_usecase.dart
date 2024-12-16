import 'package:dartz/dartz.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/features/authentication/domain/entities/auth_info_entity.dart';
import 'package:vou_games/features/authentication/domain/repositories/authentication_repository.dart';

class auth_info_usecase {
  final AuthenticationRepository repository;

  auth_info_usecase(this.repository);

  Future<Either<Failure, AuthInfoEntity>> call() async {
    return await repository.checkAuthInfo();
  }
}