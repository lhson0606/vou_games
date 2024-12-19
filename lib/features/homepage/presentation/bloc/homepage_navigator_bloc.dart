import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:vou_games/core/widgets/display/custom_navigation_bar.dart';

part 'homepage_navigator_event.dart';

part 'homepage_navigator_state.dart';

class HomepageNavigatorBloc
    extends Bloc<HomepageNavigatorEvent, HomepageNavigatorState> {
  HomepageNavigatorBloc() : super(HomepageNavigatorInitialState()) {
    on<HomepageNavigatorEvent>((event, emit) {
      if (event is ChangeHomePageNavigatorVisibilityEvent) {
        emit(ChangeHomePageNavigatorVisibilityState(event.isVisible));
      } else if (event is ChangeHomepageNavigatorIndexEvent) {
        emit(HomepageNavigatorIndexChange(event.index));
      } else if (event is AddDestinationEvent) {
        emit(AddDestinationState(event.destination));
      } else if(event is ChangeHomepageCurrentScreenEvent){
        emit(HomepageNavigatorChangeCurrentScreenState(event.screen));
      } else if(event is LoadFirstScreenEvent){
        emit(LoadFirstScreenState());
      }
    });
  }
}
