import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vou_games/core/utils/failures/failure_utils.dart';
import 'package:vou_games/features/voucher/domain/usecases/get_all_user_voucher_usecase.dart';
import 'package:vou_games/features/voucher/presentation/bloc/voucher_state.dart';

part 'voucher_event.dart';

class VoucherBloc extends Bloc<VoucherEvent, VoucherState> {
  final GetAllUserVoucherUsecase getAllUserVoucherUsecase;

  VoucherBloc({required this.getAllUserVoucherUsecase}) : super(VoucherInitialState()) {
    on<VoucherEvent>((event, emit) async {
      if(event is RequestNavigateToVoucherHomepageEvent){
        emit(RequestNavigateToVoucherHomepageState());
      } else if(event is FetchUserVouchersEvent) {
        emit(LoadingUserVouchersState());
        // mock waiting for 0.5 seconds
        await Future.delayed(const Duration(milliseconds: 500));
        final failureOrVouchers = await getAllUserVoucherUsecase();
        failureOrVouchers.fold(
            (failure) => emit(UserVouchersErrorState(
                error: failureToErrorMessage(failure))),
            (vouchers) =>
                emit(UserVouchersLoadedState(vouchers: vouchers)));
      }
    });
  }
}
