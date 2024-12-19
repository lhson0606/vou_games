part of 'homepage_navigator_bloc.dart';

abstract class HomepageNavigatorEvent extends Equatable{}

class ChangeHomePageNavigatorVisibilityEvent extends HomepageNavigatorEvent {
  final bool isVisible;

  ChangeHomePageNavigatorVisibilityEvent(this.isVisible);

  @override
  List<Object?> get props => [isVisible];
}

class ChangeHomepageNavigatorIndexEvent extends HomepageNavigatorEvent {
  final int index;

  ChangeHomepageNavigatorIndexEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class ChangeHomepageCurrentScreenEvent extends HomepageNavigatorEvent {
  final Widget screen;

  ChangeHomepageCurrentScreenEvent(this.screen);

  @override
  List<Object?> get props => [screen];
}

class AddDestinationEvent extends HomepageNavigatorEvent {
  final Destination destination;

  AddDestinationEvent(this.destination);

  @override
  List<Object?> get props => [destination];
}

class LoadFirstScreenEvent extends HomepageNavigatorEvent {
  @override
  List<Object?> get props => [];
}