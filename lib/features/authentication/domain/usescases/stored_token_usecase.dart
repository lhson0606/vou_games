import 'package:dartz/dartz.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/features/authentication/domain/entities/stored_token_entity.dart';
import 'package:vou_games/features/authentication/domain/repositories/authentication_repository.dart';

class StoredTokenUsecase {
  final AuthenticationRepository repository;

  StoredTokenUsecase(this.repository);

  Future<Either<Failure, StoredTokenEntity>> call() async {
    return await repository.storedToken();
  }
}