import 'package:vou_games/features/user/data/models/user_profile_model.dart';

abstract class UserDataSource {
  Future<UserProfileModel> getUserProfile();
}