import 'package:vou_games/core/network/json_model.dart';
import 'package:vou_games/features/games/domain/entities/game_entity.dart';
import 'package:vou_games/features/games/domain/entities/game_type_entity.dart';

import 'game_type_model.dart';

class GameModel extends GameEntity implements JsonModel {
  const GameModel({required super.id, required super.allowPiecesExchange, required super.startAt, required super.gameType, required super.campaignId});

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

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'],
      allowPiecesExchange: json['allowPiecesExchange'],
      startAt: json['startAt'] != null ? DateTime.tryParse(json['startAt']) : null,
      gameType: GameTypeModel.fromJson(json['type']) as GameTypeEntity,
      campaignId: json['campaignId'],
    );
  }
}