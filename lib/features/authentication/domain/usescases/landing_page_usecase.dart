import 'package:vou_games/features/authentication/domain/entities/landing_page_entity.dart';
import 'package:vou_games/features/authentication/domain/repositories/authentication_repository.dart';

class LandingPageUsecase {
  final AuthenticationRepository repository;

  LandingPageUsecase(this.repository);

  LandingPageEntity call() {
    return repository.landingPage();
  }
}
