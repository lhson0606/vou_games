import 'dart:convert';

import 'package:vou_games/configs/mock/notification_mock.dart';
import 'package:vou_games/features/notification/data/datasources/notification_datasource_contract.dart';
import 'package:vou_games/features/notification/data/models/notification_model.dart';

class NotificationLocalDataSource extends NotificationDataSource {
  @override
  Future<List<NotificationModel>> getUserNotification() {
    final List<dynamic> jsonList = json.decode(MOCK_NOTIFICATIONS_JSON);
    return Future.value(
        jsonList.map((e) => NotificationModel.fromJson(e)).toList());
  }
}
