import 'package:vou_games/core/common/data/entities/reward_piece_entity.dart';

class RewardPieceModel extends RewardPieceEntity {
  RewardPieceModel({required super.id, required super.imageUrl});

  factory RewardPieceModel.fromJson(Map<String, dynamic> json) {
    return RewardPieceModel(
      id: json['id'],
      imageUrl: json['imageUrl'],
    );
  }
}