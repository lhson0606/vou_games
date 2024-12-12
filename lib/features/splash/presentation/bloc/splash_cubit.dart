import 'package:vou_games/features/splash/presentation/bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void loadApp() async{
    emit(SplashLoading());
    await Future.delayed(const Duration(milliseconds: 1024));
    emit(SplashLoaded());
  }
}