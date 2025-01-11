abstract class GameItemEntity {
  final String id;

  GameItemEntity({required this.id});

  String getDisplayImageUrl();

  String getDisplayName();

  String getDisplayDescription();
}
