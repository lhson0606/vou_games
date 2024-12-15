import 'package:get_it/get_it.dart';
import 'package:vou_games/core/network/network_info.dart';
import 'package:vou_games/features/authentication/data/datasources/auth_firebase_data_source.dart';
import 'package:vou_games/features/authentication/data/datasources/auth_remote_data_source_contract.dart';
import 'package:vou_games/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:vou_games/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:vou_games/features/authentication/domain/usescases/sign_in_usecase.dart';
import 'package:vou_games/features/authentication/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //============= Features - posts =============

  //============= Bloc =============
  sl.registerFactory(() => AuthBloc(signInUsecase: sl<SignInUsecase>()));
  //============= Usecases =============
  sl.registerLazySingleton(() => SignInUsecase(sl<AuthenticationRepository>()));


  //============= Repository =============
  sl.registerLazySingleton<AuthenticationRepository>(() => AuthRepositoryImpl(networkInfo: sl(), authDataSource: sl()));
  //============= Datasources =============
  sl.registerLazySingleton<AuthDataSource>(() => AuthFirebaseDataSource());

  //============= Core =============
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  //============= External =================
  // sl.registerLazySingleton(() => InternetConnection());
}