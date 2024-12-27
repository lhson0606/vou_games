import 'package:dartz/dartz.dart';
import 'package:vou_games/features/notification/domain/entities/notification_entity.dart';

import '../../../../core/error/failures.dart';
import '../repositories/notification_repository.dart';

class GetUserNotificationUseCase {
  final NotificationRepository _notificationRepository;

  GetUserNotificationUseCase(this._notificationRepository);

  Future<Either<Failure, List<NotificationEntity>>> call() async {
    return _notificationRepository.getUserNotification();
  }
}
