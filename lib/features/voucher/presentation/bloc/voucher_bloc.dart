import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:vou_games/features/voucher/presentation/bloc/voucher_state.dart';

part 'voucher_event.dart';

class VoucherBloc extends Bloc<VoucherEvent, VoucherState> {
  VoucherBloc() : super(VoucherInitialState()) {
    on<VoucherEvent>((event, emit) {
      if(event is RequestNavigateToVoucherHomepageEvent){
        emit(RequestNavigateToVoucherHomepageState());
      }
    });
  }
}
