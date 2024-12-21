import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:vou_games/features/shop/presentation/pages/shop_homepage.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc() : super(ShopInitialState()) {
    on<ShopEvent>((event, emit) {
      if(event is RequestNavigateToShopHomepageEvent){
        emit(RequestNavigateToShopHomepageState());
      }
    });
  }
}
