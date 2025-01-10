import 'package:equatable/equatable.dart';
import 'package:vou_games/features/games/domain/entities/game_type_entity.dart';

class GameEntity extends Equatable {
  final int id;
  final bool allowPieceExchange;
  final DateTime startAt;
  final GameTypeEntity type;
  final int campaignId;

  const GameEntity({
    required this.id,
    required this.allowPieceExchange,
    required this.startAt,
    required this.type,
    required this.campaignId,
  });

  @override
  List<Object?> get props => [id];
}