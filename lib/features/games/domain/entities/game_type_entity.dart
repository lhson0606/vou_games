import 'package:equatable/equatable.dart';

class GameTypeEntity extends Equatable {
  final int id;
  final String name;
  final bool isRealTime;
  final String imageUrl;
  final String instruction;

  const GameTypeEntity({
    required this.id,
    required this.name,
    required this.isRealTime,
    required this.imageUrl,
    required this.instruction,
  });

  @override
  List<Object?> get props => [id];
}
