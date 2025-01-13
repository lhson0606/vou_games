import 'package:equatable/equatable.dart';

class RankEntity extends Equatable {
  final int rank;
  final int totalScore;
  final double totalTime;

  const RankEntity({
    required this.rank,
    required this.totalScore,
    required this.totalTime,
  });

  @override
  List<Object?> get props => [rank];
}
