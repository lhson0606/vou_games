import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import '../pages/voucher_homepage.dart';


abstract class VoucherState extends Equatable{}

final class VoucherInitialState extends VoucherState {
  @override
  List<Object?> get props => [];
}

final class RequestNavigateToVoucherHomepageState extends VoucherState {
  final Widget homepage = const VoucherHomepage();
  final DateTime timestamp = DateTime.now();

  @override
  List<Object?> get props => [timestamp];
}


