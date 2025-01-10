import 'package:vou_games/core/network/json_model.dart';
import 'package:vou_games/features/games/domain/entities/game_entity.dart';

class GameTypeModel extends GameEntity implements JsonModel {
  const GameTypeModel({required super.id, required super.allowPieceExchange, required super.startAt, required super.type, required super.campaignId});

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

}