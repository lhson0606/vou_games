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
import 'package:vou_games/features/dice/presentation/bloc/dice_bloc.dart';
import 'package:vou_games/features/homepage/presentation/bloc/homepage_navigator_bloc.dart';
import 'package:vou_games/features/notification/data/datasources/notification_datasource_contract.dart';
import 'package:vou_games/features/notification/data/datasources/notification_local_data_source.dart';
import 'package:vou_games/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:vou_games/features/notification/domain/repositories/notification_repository.dart';
import 'package:vou_games/features/notification/domain/usecases/get_user_notification_usecase.dart';
import 'package:vou_games/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:vou_games/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:vou_games/features/shop/presentation/bloc/shop_bloc.dart';
import 'package:vou_games/features/user/data/datasources/user_data_source_contract.dart';
import 'package:vou_games/features/user/data/datasources/user_local_data_source.dart';
import 'package:vou_games/features/user/data/repositories/user_repository_impl.dart';
import 'package:vou_games/features/user/domain/repositories/user_repository.dart';
import 'package:vou_games/features/user/domain/usecases/get_user_profile_usecase.dart';
import 'package:vou_games/features/user/presentation/bloc/user_bloc.dart';
import 'package:vou_games/features/voucher/data/datasources/voucher_data_source_contract.dart';
import 'package:vou_games/features/voucher/data/datasources/voucher_local_data_source.dart';
import 'package:vou_games/features/voucher/data/repositories/voucher_repository_impl.dart';
import 'package:vou_games/features/voucher/domain/repositories/voucher_repository.dart';
import 'package:vou_games/features/voucher/domain/usecases/get_all_user_voucher_usecase.dart';
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
  sl.registerFactory(() => VoucherBloc(getAllUserVoucherUsecase: sl()));
  sl.registerFactory(() => ShopBloc());
  sl.registerFactory(() => NotificationBloc(getUserNotificationUseCase: sl()));
  sl.registerFactory(() => UserBloc());
  sl.registerFactory(() => HomepageNavigatorBloc());
  sl.registerFactory(() => QuizBloc());
  sl.registerFactory(() => DiceBloc());
  //============= UseCases =============
  //----------------- Authentication -----------------
  sl.registerLazySingleton(() => SignInUseCase(sl<AuthenticationRepository>()));
  sl.registerLazySingleton(() => LogOutUseCase(sl<AuthenticationRepository>()));
  sl.registerLazySingleton(
      () => CheckLoggedInUseCase(sl<AuthenticationRepository>()));
  //----------------- Campaign -----------------
  sl.registerLazySingleton(
      () => GetUpComingCampaignUseCase(sl<CampaignRepository>()));
  //----------------- Voucher -----------------
  sl.registerLazySingleton(() => GetAllUserVoucherUsecase(sl()));
  //----------------- Shop -----------------
  //----------------- Notification -----------------
  sl.registerLazySingleton(() => GetUserNotificationUseCase(sl()));
  //----------------- User -----------------
  sl.registerLazySingleton(() => GetUserProfileUseCase(sl()));

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
  sl.registerLazySingleton<VoucherRepository>(() => VoucherRepositoryImpl(
        voucherDataSource: sl(),
        networkInfo: sl(),
        userCredentialService: sl(),
      ));
  sl.registerLazySingleton<NotificationRepository>(() =>
      NotificationRepositoryImpl(
          notificationDataSource: sl(),
          networkInfo: sl(),
          userCredentialService: sl()));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      userDataSource: sl(), networkInfo: sl(), userCredentialService: sl()));
  //============= Datasources =============
  sl.registerLazySingleton<AuthDataSource>(() => AuthFirebaseDataSource());
  sl.registerLazySingleton<CampaignDataSource>(() => CampaignLocalDataSource());
  sl.registerLazySingleton<VoucherDataSource>(() => VoucherLocalDataSource());
  sl.registerLazySingleton<NotificationDataSource>(() => NotificationLocalDataSource());
  sl.registerLazySingleton<UserDataSource>(() => UserLocalDataSource());

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
