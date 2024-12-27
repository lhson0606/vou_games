import 'package:dartz/dartz.dart';
import 'package:vou_games/features/notification/domain/entities/notification_entity.dart';

import '../../../../core/error/failures.dart';

abstract class NotificationRepository {
  Future<Either<Failure, List<NotificationEntity>>> getUserNotification();
}
