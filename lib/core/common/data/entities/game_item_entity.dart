import 'package:equatable/equatable.dart';

abstract class GameItemEntity extends Equatable{
  final int id;

  GameItemEntity({required this.id});

  String getDisplayImageUrl();

  String getDisplayName();

  String getDisplayDescription();

  @override
  List<Object?> get props => [id];
}
