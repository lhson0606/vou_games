abstract class GameItemEntity {
  final int id;

  GameItemEntity({required this.id});

  String getDisplayImageUrl();

  String getDisplayName();

  String getDisplayDescription();
}
