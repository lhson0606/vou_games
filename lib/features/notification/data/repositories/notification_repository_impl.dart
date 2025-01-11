import 'package:dartz/dartz.dart';
import 'package:vou_games/configs/policies/general_policies.dart';
import 'package:vou_games/core/error/failures.dart';
import 'package:vou_games/core/services/network/network_info.dart';
import 'package:vou_games/core/services/user_credential_service.dart';
import 'package:vou_games/features/notification/data/datasources/notification_datasource_contract.dart';
import 'package:vou_games/features/notification/domain/entities/notification_entity.dart';
import 'package:vou_games/features/notification/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationDataSource notificationDataSource;
  final NetworkInfo networkInfo;
  final UserCredentialService userCredentialService;

  NotificationRepositoryImpl(
      {required this.notificationDataSource,
      required this.networkInfo,
      required this.userCredentialService});

  @override
  Future<Either<Failure, List<NotificationEntity>>> getUserNotification() async {
    if (await networkInfo.isConnected
        .timeout(const Duration(milliseconds: max_general_wait_time_ms), onTimeout: () => false)) {
      try {
        final notifications = await notificationDataSource.getUserNotification();
        return Right(notifications);
      } catch (e) {
        rethrow;
        return Left(UnknownFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
