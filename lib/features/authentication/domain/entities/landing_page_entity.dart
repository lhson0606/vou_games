import 'package:equatable/equatable.dart';

class LandingPageEntity extends Equatable {
  final String title;
  final String description;
  final String image;
  final bool isLoggedIn;

  LandingPageEntity({
    required this.title,
    required this.description,
    required this.image,
    required this.isLoggedIn,
  });

  @override
  List<Object?> get props => [title, description, image, isLoggedIn];
}