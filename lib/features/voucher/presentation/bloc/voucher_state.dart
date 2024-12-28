import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import '../../domain/entities/voucher_entity.dart';
import '../pages/voucher_homepage.dart';

abstract class VoucherState extends Equatable {}

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

final class LoadingUserVouchersState extends VoucherState {
  @override
  List<Object?> get props => [];
}

final class UserVouchersLoadedState extends VoucherState {
  final List<VoucherEntity> vouchers;

  UserVouchersLoadedState({required this.vouchers});

  @override
  List<Object?> get props => [vouchers];
}

final class UserVouchersErrorState extends VoucherState {
  final String error;

  UserVouchersErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}
