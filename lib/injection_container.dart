import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:vou_games/core/services/network/network_info.dart';
import 'package:vou_games/core/services/shared_preferences_service.dart';
import 'package:vou_games/core/services/user_credential_service.dart';
import 'package:vou_games/features/authentication/data/datasources/auth_firebase_data_source.dart';
import 'package:vou_games/features/authentication/data/datasources/auth_remote_data_source_contract.dart';
import 'package:vou_games/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:vou_games/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:vou_games/features/authentication/domain/usescases/check_logged_in_usecase.dart';
import 'package:vou_games/features/authentication/domain/usescases/log_out_usecase.dart';
import 'package:vou_games/features/authentication/domain/usescases/sign_in_usecase.dart';
import 'package:vou_games/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:vou_games/features/campaign/data/datasources/campaign_data_source_contract.dart';
import 'package:vou_games/features/campaign/data/datasources/campaign_local_data_source.dart';
import 'package:vou_games/features/campaign/data/repositories/campaign_repository_impl.dart';
import 'package:vou_games/features/campaign/domain/repositories/campaign_repository.dart';
import 'package:vou_games/features/campaign/domain/usecases/get_up_coming_campaign_usecase.dart';
import 'package:vou_games/features/campaign/presentation/bloc/campaign_bloc.dart';
import 'package:vou_games/features/homepage/presentation/bloc/homepage_navigator_bloc.dart';
import 'package:vou_games/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:vou_games/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:vou_games/features/shop/presentation/bloc/shop_bloc.dart';
import 'package:vou_games/features/user/presentation/bloc/user_bloc.dart';
import 'package:vou_games/features/voucher/presentation/bloc/voucher_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //============= Features - posts =============

  //============= Bloc =============
  sl.registerFactory(() => AuthBloc(
        signInUsecase: sl<SignInUseCase>(),
        logOutUseCase: sl<LogOutUseCase>(),
        checkLoggedInUseCase: sl<CheckLoggedInUseCase>(),
      ));
  sl.registerFactory(() => CampaignBloc(getUpComingCampaignUseCase: sl()));
  sl.registerFactory(() => VoucherBloc());
  sl.registerFactory(() => ShopBloc());
  sl.registerFactory(() => NotificationBloc());
  sl.registerFactory(() => UserBloc());
  sl.registerFactory(() => HomepageNavigatorBloc());
  sl.registerFactory(() => QuizBloc());
  //============= Usecases =============
  //----------------- Authentication -----------------
  sl.registerLazySingleton(() => SignInUseCase(sl<AuthenticationRepository>()));
  sl.registerLazySingleton(() => LogOutUseCase(sl<AuthenticationRepository>()));
  sl.registerLazySingleton(
      () => CheckLoggedInUseCase(sl<AuthenticationRepository>()));
  //----------------- Campaign -----------------
  sl.registerLazySingleton(
      () => GetUpComingCampaignUseCase(sl<CampaignRepository>()));

  //============= Repository =============
  sl.registerLazySingleton<AuthenticationRepository>(() => AuthRepositoryImpl(
        networkInfo: sl(),
        authDataSource: sl(),
        sharedPreferencesService: sl(),
        userCredentialService: sl(),
      ));
  sl.registerLazySingleton<CampaignRepository>(() => CampaignRepositoryImpl(
        campaignDataSource: sl(),
        networkInfo: sl(),
        sharedPreferencesService: sl(),
        userCredentialService: sl(),
      ));
  //============= Datasources =============
  sl.registerLazySingleton<AuthDataSource>(() => AuthFirebaseDataSource());
  sl.registerLazySingleton<CampaignDatasource>(() => CampaignLocalDataSource());

  //============= Core =============
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => UserCredentialService());
  //sl.registerLazySingleton(() => NavigationService());

  //============= External =================
  sl.registerLazySingleton(() => InternetConnection());
  sl.registerLazySingleton(() => SharedPreferencesService());
}

// void setupNavigationService() {
//   NavigationService navigationService = sl<NavigationService>();
//   final List<Destination> allDestinations = <Destination>[
//     const Destination(0, 'Campaign', Icons.event, Colors.cyan),
//     const Destination(1, 'Voucher', Icons.discount_outlined, Colors.orange),
//     const Destination(2, 'Shop', Icons.location_pin, Colors.orange),
//     const Destination(3, 'Notification', Icons.notifications, Colors.blue),
//     const Destination(4, 'User', Icons.person, Colors.green),
//   ];
//   navigationService.registerFeature(
//       allDestinations[0], const CampaignHomePage());
//   navigationService.registerFeature(
//       allDestinations[1], const VoucherHomepage());
//   navigationService.registerFeature(allDestinations[2], const ShopHomepage());
//   navigationService.registerFeature(
//       allDestinations[3], const NotificationHomepage());
//   navigationService.registerFeature(allDestinations[4], const UserHomepage());
//
//   navigationService.showNavigationBar();
//   navigationService.setUp();
// }
