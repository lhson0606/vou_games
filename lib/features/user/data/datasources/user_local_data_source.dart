import 'dart:convert';

import 'package:vou_games/configs/mock/user_mock.dart';
import 'package:vou_games/features/user/data/datasources/user_data_source_contract.dart';
import 'package:vou_games/features/user/data/models/user_profile_model.dart';

class UserLocalDataSource extends UserDataSource {
  @override
  Future<UserProfileModel> getUserProfile() {
    final dynamic jsonData = json.decode(USER_MOCK_JSON);
    return Future.value(UserProfileModel.fromJson(jsonData));
  }
}
