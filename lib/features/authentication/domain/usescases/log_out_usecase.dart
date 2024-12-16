import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/authentication_repository.dart';

class LogOutUseCase {
  final AuthenticationRepository _repository;

  LogOutUseCase(this._repository);

  Future<Either<Failure, Unit>> call() async {
    return await _repository.logOut();
  }
}
