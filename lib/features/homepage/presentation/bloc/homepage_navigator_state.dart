part of 'homepage_navigator_bloc.dart';

abstract class HomepageNavigatorState extends Equatable {}

final class HomepageNavigatorInitialState extends HomepageNavigatorState {
  @override
  List<Object?> get props => [];
}

final class ChangeHomePageNavigatorVisibilityState
    extends HomepageNavigatorState {
  final bool isVisible;

  ChangeHomePageNavigatorVisibilityState(this.isVisible);

  @override
  List<Object?> get props => [isVisible];
}

final class HomepageNavigatorIndexChange extends HomepageNavigatorState {
  final int index;

  HomepageNavigatorIndexChange(this.index);

  @override
  List<Object?> get props => [index];
}

final class HomepageNavigatorChangeCurrentScreenState
    extends HomepageNavigatorState {
  final Widget screen;

  HomepageNavigatorChangeCurrentScreenState(this.screen);

  @override
  List<Object?> get props => [screen];
}

final class AddDestinationState extends HomepageNavigatorState {
  final Destination destination;

  AddDestinationState(this.destination);

  @override
  List<Object?> get props => [destination];
}

final class LoadFirstScreenState extends HomepageNavigatorState {
  @override
  List<Object?> get props => [];
}
