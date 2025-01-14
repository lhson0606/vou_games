import 'package:equatable/equatable.dart';

class PlayerAnswerEntity extends Equatable {
  final int questionNumber;
  final String answer;

  const PlayerAnswerEntity(
      {required this.questionNumber, required this.answer});

  @override
  List<Object?> get props => [questionNumber, answer];
}
