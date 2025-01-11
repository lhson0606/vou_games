import 'game_item_entity.dart';

class RewardPieceEntity extends GameItemEntity {
  final String imageUrl;

  RewardPieceEntity({required super.id, required this.imageUrl});

  @override
  String getDisplayDescription() {
    return "A reward piece, that can be used to redeem a reward once completed the puzzle!";
  }

  @override
  String getDisplayImageUrl() {
    return imageUrl;
  }

  @override
  String getDisplayName() {
    // return the final part of the image url, excluded the file extension for now
    return imageUrl.split("/").last.split(".").first;
  }
}
