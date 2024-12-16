import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:vou_games/core/services/network/network_info.dart';
import 'package:vou_games/core/services/shared_preferences_service.dart';
import 'package:vou_games/core/services/user_credential_service.dart';
import 'package:vou_games/features/authentication/data/datasources/auth_firebase_data_source.dart';
import 'package:vou_games/features/authentication/data/datasources/auth_remote_data_source_contract.dart';
import 'package:vou_games/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:vou_games/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:vou_games/features/authentication/domain/usescases/log_out_usecase.dart';
import 'package:vou_games/features/authentication/domain/usescases/sign_in_usecase.dart';
import 'package:vou_games/features/authentication/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //============= Features - posts =============

  //============= Bloc =============
  sl.registerFactory(() => AuthBloc(
        signInUsecase: sl<SignInUseCase>(),
        logOutUseCase: sl<LogOutUseCase>(),
      ));
  //============= Usecases =============
  sl.registerLazySingleton(() => SignInUseCase(sl<AuthenticationRepository>()));
  sl.registerLazySingleton(() => LogOutUseCase(sl<AuthenticationRepository>()));

  //============= Repository =============
  sl.registerLazySingleton<AuthenticationRepository>(() => AuthRepositoryImpl(
        networkInfo: sl(),
        authDataSource: sl(),
        sharedPreferencesService: sl(),
        userCredentialService: sl(),
      ));
  //============= Datasources =============
  sl.registerLazySingleton<AuthDataSource>(() => AuthFirebaseDataSource());

  //============= Core =============
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //============= External =================
  sl.registerLazySingleton(() => InternetConnection());
  sl.registerLazySingleton(() => SharedPreferencesService());
  sl.registerLazySingleton(() => UserCredentialService());
}
