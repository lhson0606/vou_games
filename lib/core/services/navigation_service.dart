import 'package:flutter/material.dart';
import 'package:vou_games/core/widgets/display/custom_navigation_bar.dart';

class NavigationService {
  final ValueNotifier<Widget> currentScreen =
      ValueNotifier<Widget>(const SizedBox());
  final GlobalKey<CustomBottomNavigationBarState> bottomNavigationBarKey =
      GlobalKey<CustomBottomNavigationBarState>();
  final List<Widget> screens = [];

  GlobalKey<CustomBottomNavigationBarState> getBottomNavigationBarKey() {
    return bottomNavigationBarKey;
  }

  void navigateTo(Widget screen) {
    currentScreen.value = screen;
  }

  void navigateToHomePages(int index) {
    if (index < screens.length || index >= 0) {
      currentScreen.value = screens[index];
    }
  }

  void showNavigationBar() {
    bottomNavigationBarKey.currentState?.showNavigationBar();
  }

  void hideNavigationBar() {
    bottomNavigationBarKey.currentState?.hideNavigationBar();
  }

  void registerFeature(Destination destination, Widget homepage) {
    screens.add(homepage);
    bottomNavigationBarKey.currentState?.addDestination(destination);
  }

  void _onIndexChanged(int index) {
    if (index < screens.length) {
      navigateTo(screens[index]);
    }
  }

  void setUp() {
    bottomNavigationBarKey.currentState?.widget.onIndexChanged
        .add(_onIndexChanged);
  }
}
