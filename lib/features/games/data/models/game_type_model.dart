import 'package:vou_games/core/network/json_model.dart';
import 'package:vou_games/core/utils/strings/string_utils.dart';
import 'package:vou_games/features/games/domain/entities/game_entity.dart';
import 'package:vou_games/features/games/domain/entities/game_type_entity.dart';

class GameTypeModel extends GameTypeEntity implements JsonModel {
  const GameTypeModel({required super.id, required super.name, required super.isRealTime, required super.imageUrl, required super.instruction});

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  @override
  String toJsonString() {
    // TODO: implement toJsonString
    throw UnimplementedError();
  }

  factory GameTypeModel.fromJson(Map<String, dynamic> json) {
    return GameTypeModel(
      id: json['id'],
      name: json['name'],
      isRealTime: json['isRealtime'],
      imageUrl: json['imageUrl'],
      instruction: StringUtils.decodeVNString(json['instruction']),
    );
  }
}
