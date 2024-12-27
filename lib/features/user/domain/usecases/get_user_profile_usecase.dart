import 'package:dartz/dartz.dart';
import 'package:vou_games/features/user/domain/entities/user_profile_entity.dart';

import '../../../../core/error/failures.dart';
import '../repositories/user_repository.dart';

class GetUserProfileUseCase {
  final UserRepository _userRepository;

  GetUserProfileUseCase(this._userRepository);

  Future<Either<Failure, UserProfileEntity>> call() async {
    return await _userRepository.getUserProfile();
  }
}