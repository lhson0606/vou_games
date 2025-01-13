import 'package:equatable/equatable.dart';

class QuizConnectionEntity extends Equatable {
  final bool isConnected;

  const QuizConnectionEntity({required this.isConnected});

  @override
  List<Object> get props => [isConnected];
}
