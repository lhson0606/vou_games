import 'package:equatable/equatable.dart';
import 'package:vou_games/features/games/domain/entities/game_type_entity.dart';

class GameEntity extends Equatable {
  final int id;
  final bool allowPiecesExchange;
  final DateTime? startAt;
  final GameTypeEntity gameType;
  final int campaignId;

  const GameEntity({
    required this.id,
    required this.allowPiecesExchange,
    required this.startAt,
    required this.gameType,
    required this.campaignId,
  });

  @override
  List<Object?> get props => [id];
}