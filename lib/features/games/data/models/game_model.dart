import 'package:vou_games/core/network/json_model.dart';
import 'package:vou_games/features/games/domain/entities/game_entity.dart';

class GameModel extends GameEntity implements JsonModel {
  const GameModel({required super.id, required super.allowPieceExchange, required super.startAt, required super.type, required super.campaignId});

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