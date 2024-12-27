import 'package:dartz/dartz.dart';
import 'package:vou_games/features/user/domain/entities/user_profile_entity.dart';

import '../../../../core/error/failures.dart';

abstract class UserRepository {
  Future<Either<Failure, UserProfileEntity>> getUserProfile();
}