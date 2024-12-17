import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:vou_games/core/services/navigation_service.dart';
import 'package:vou_games/core/services/network/network_info.dart';
import 'package:vou_games/core/services/shared_preferences_service.dart';
import 'package:vou_games/core/services/user_credential_service.dart';
import 'package:vou_games/core/widgets/display/custom_navigation_bar.dart';
import 'package:vou_games/features/authentication/data/datasources/auth_firebase_data_source.dart';
import 'package:vou_games/features/authentication/data/datasources/auth_remote_data_source_contract.dart';
import 'package:vou_games/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:vou_games/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:vou_games/features/authentication/domain/usescases/check_logged_in_usecase.dart';
import 'package:vou_games/features/authentication/domain/usescases/log_out_usecase.dart';
import 'package:vou_games/features/authentication/domain/usescases/sign_in_usecase.dart';
import 'package:vou_games/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:vou_games/features/campaign/presentation/pages/campaign_homepage.dart';
import 'package:vou_games/features/voucher/presentation/pages/voucher_homepage.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //============= Features - posts =============

  //============= Bloc =============
  sl.registerFactory(() => AuthBloc(
        signInUsecase: sl<SignInUseCase>(),
        logOutUseCase: sl<LogOutUseCase>(),
        checkLoggedInUseCase: sl<CheckLoggedInUseCase>(),
      ));
  //============= Usecases =============
  sl.registerLazySingleton(() => SignInUseCase(sl<AuthenticationRepository>()));
  sl.registerLazySingleton(() => LogOutUseCase(sl<AuthenticationRepository>()));
  sl.registerLazySingleton(() => CheckLoggedInUseCase(sl<AuthenticationRepository>()));

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
  sl.registerLazySingleton(() => UserCredentialService());
  sl.registerLazySingleton(() => NavigationService());

  //============= External =================
  sl.registerLazySingleton(() => InternetConnection());
  sl.registerLazySingleton(() => SharedPreferencesService());
}

void setupNavigationService() {
  NavigationService navigationService = sl<NavigationService>();
  final List<Destination> allDestinations = <Destination>[
    Destination(0, 'Teal', Icons.home, Colors.teal),
    Destination(1, 'Cyan', Icons.business, Colors.cyan),
    Destination(2, 'Orange', Icons.school, Colors.orange),
    Destination(3, 'Blue', Icons.flight, Colors.blue),
  ];
  navigationService.registerFeature(allDestinations[0], const CampaignHomePage());
  navigationService.registerFeature(allDestinations[1], const VoucherHomepage());
  navigationService.registerFeature(allDestinations[2], const CampaignHomePage());
  navigationService.registerFeature(allDestinations[3], const VoucherHomepage());
  navigationService.showNavigationBar();
  navigationService.setUp();
}
