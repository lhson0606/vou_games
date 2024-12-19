part of 'shop_bloc.dart';

abstract class ShopState extends Equatable{}

final class ShopInitialState extends ShopState {
  @override
  List<Object?> get props => [];
}

final class RequestNavigateToShopHomepageState extends ShopState {
  final Widget homepage = const ShopHomepage();
  final DateTime timestamp = DateTime.now();

  @override
  List<Object?> get props => [timestamp];
}
