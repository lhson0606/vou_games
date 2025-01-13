import 'package:vou_games/features/quiz/domain/entities/rank_entity.dart';

class RankModel extends RankEntity {
  const RankModel(
      {required super.rank,
      required super.totalScore,
      required super.totalTime});

  factory RankModel.fromJson(Map<String, dynamic> json) {
    return RankModel(
      rank: json['rank'],
      totalScore: json['totalScore'],
      totalTime: json['totalTime'],
    );
  }
}
