import 'package:dartz/dartz.dart';
import 'package:vou_games/features/authentication/domain/entities/auth_info_entity.dart';

import '../../../../core/error/failures.dart';
import '../repositories/authentication_repository.dart';

class CheckLoggedInUseCase {
  final AuthenticationRepository _repository;

  CheckLoggedInUseCase(this._repository);

  Future<Either<Failure, AuthInfoEntity>> call() async {
    return _repository.checkAuthInfo();
  }
}