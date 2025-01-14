import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:vou_games/core/services/audios/audio_service.dart';
import 'package:vou_games/core/services/audios/tts_service.dart';
import 'package:vou_games/core/services/contract/audio_service_contract.dart';
import 'package:vou_games/core/services/contract/tts_service_contract.dart';
import 'package:vou_games/core/services/network/network_info.dart';
import 'package:vou_games/core/services/shared_preferences_service.dart';
import 'package:vou_games/core/services/user_credential_service.dart';
import 'package:vou_games/features/authentication/data/datasources/auth_http_data_source.dart';
import 'package:vou_games/features/authentication/data/datasources/auth_remote_data_source_contract.dart';
import 'package:vou_games/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:vou_games/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:vou_games/features/authentication/domain/usescases/check_logged_in_usecase.dart';
import 'package:vou_games/features/authentication/domain/usescases/log_out_usecase.dart';
import 'package:vou_games/features/authentication/domain/usescases/sign_in_usecase.dart';
import 'package:vou_games/features/authentication/domain/usescases/sign_up_usecase.dart';
import 'package:vou_games/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:vou_games/features/campaign/data/datasources/campaign_data_source_contract.dart';
import 'package:vou_games/features/campaign/data/datasources/campaign_http_data_source.dart';
import 'package:vou_games/features/campaign/data/repositories/campaign_repository_impl.dart';
import 'package:vou_games/features/campaign/domain/repositories/campaign_repository.dart';
import 'package:vou_games/features/campaign/domain/usecases/get_up_coming_campaign_usecase.dart';
import 'package:vou_games/features/campaign/domain/usecases/search_campaign_usecase.dart';
import 'package:vou_games/features/campaign/presentation/bloc/campaign_bloc.dart';
import 'package:vou_games/features/dice/data/datasources/dice_http_data_source.dart';
import 'package:vou_games/features/dice/data/datasources/dice_remote_data_source_contract.dart';
import 'package:vou_games/features/dice/data/repositories/dice_repository_impl.dart';
import 'package:vou_games/features/dice/domain/repositories/dice_repository.dart';
import 'package:vou_games/features/dice/domain/usecases/roll_dice_use_case.dart';
import 'package:vou_games/features/dice/presentation/bloc/dice_bloc.dart';
import 'package:vou_games/features/games/data/datasources/game_data_source_contract.dart';
import 'package:vou_games/features/games/data/datasources/game_http_data_source.dart';
import 'package:vou_games/features/games/data/repositories/game_repository_impl.dart';
import 'package:vou_games/features/games/domain/repositories/game_repository.dart';
import 'package:vou_games/features/games/domain/usecases/get_campaign_games_usecase.dart';
import 'package:vou_games/features/games/presentation/bloc/game_bloc.dart';
import 'package:vou_games/features/homepage/presentation/bloc/homepage_navigator_bloc.dart';
import 'package:vou_games/features/notification/data/datasources/notification_datasource_contract.dart';
import 'package:vou_games/features/notification/data/datasources/notification_local_data_source.dart';
import 'package:vou_games/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:vou_games/features/notification/domain/repositories/notification_repository.dart';
import 'package:vou_games/features/notification/domain/usecases/get_user_notification_usecase.dart';
import 'package:vou_games/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:vou_games/features/quiz/data/datasources/quiz_ai_mc_datasource_contract.dart';
import 'package:vou_games/features/quiz/data/datasources/quiz_datasource_contract.dart';
import 'package:vou_games/features/quiz/data/datasources/quiz_http_datasource.dart';
import 'package:vou_games/features/quiz/data/datasources/quiz_open_ai_mc_datasource.dart';
import 'package:vou_games/features/quiz/data/datasources/quiz_real_time_datasource_contract.dart';
import 'package:vou_games/features/quiz/data/datasources/quiz_websocket_datasource.dart';
import 'package:vou_games/features/quiz/data/repositories/quiz_ai_mc_repository_impl.dart';
import 'package:vou_games/features/quiz/data/repositories/quiz_repository_impl.dart';
import 'package:vou_games/features/quiz/domain/repositories/quiz_ai_mc_repository.dart';
import 'package:vou_games/features/quiz/domain/repositories/quiz_repository.dart';
import 'package:vou_games/features/quiz/domain/usecases/connect_quiz_game_usecase.dart';
import 'package:vou_games/features/quiz/domain/usecases/inform_ai_mc_usecase.dart';
import 'package:vou_games/features/quiz/domain/usecases/new_mc_session_usecase.dart';
import 'package:vou_games/features/quiz/domain/usecases/player_answer_quiz_usecase.dart';
import 'package:vou_games/features/quiz/domain/usecases/set_real_time_quiz_controller_usecase.dart';
import 'package:vou_games/features/quiz/domain/usecases/text_to_speech_usecase.dart';
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
  //============= Features =============

  //============= Bloc =============
  sl.registerFactory(() => AuthBloc(
        signInUsecase: sl<SignInUseCase>(),
        signUpUseCase: sl<SignUpUseCase>(),
        logOutUseCase: sl<LogOutUseCase>(),
        checkLoggedInUseCase: sl<CheckLoggedInUseCase>(),
      ));
  sl.registerFactory(() => CampaignBloc(
      getUpComingCampaignUseCase: sl(), searchCampaignUseCase: sl()));
  sl.registerFactory(() => VoucherBloc(getAllUserVoucherUsecase: sl()));
  sl.registerFactory(() => ShopBloc());
  sl.registerFactory(() => NotificationBloc(getUserNotificationUseCase: sl()));
  sl.registerFactory(() => UserBloc(getUserProfileUseCase: sl()));
  sl.registerFactory(() => HomepageNavigatorBloc());
  sl.registerFactory(() => GameBloc(getCampaignGamesUseCase: sl()));
  sl.registerFactory(() => QuizBloc(
      connectQuizGameUseCase: sl(),
      setRealTimeQuizControllerUseCase: sl(),
      playerAnswerQuizUseCase: sl(),
      informAiMcUseCase: sl(),
      textToSpeechUsecase: sl(),
      newMCSessionUseCase: sl()));
  sl.registerFactory(() => DiceBloc(rollDiceUseCase: sl()));
  //============= UseCases =============
  //----------------- Authentication -----------------
  sl.registerLazySingleton(() => SignInUseCase(sl<AuthenticationRepository>()));
  sl.registerLazySingleton(() => SignUpUseCase(sl<AuthenticationRepository>()));
  sl.registerLazySingleton(() => LogOutUseCase(sl<AuthenticationRepository>()));
  sl.registerLazySingleton(
      () => CheckLoggedInUseCase(sl<AuthenticationRepository>()));
  sl.registerLazySingleton(() => SearchCampaignUseCase(sl()));
  //----------------- Campaign -----------------
  sl.registerLazySingleton(
      () => GetUpComingCampaignUseCase(sl<CampaignRepository>()));
  //----------------- Voucher -----------------
  sl.registerLazySingleton(() => GetAllUserVoucherUsecase(sl()));
  //----------------- Shop -----------------
  //----------------- Game -----------------
  sl.registerLazySingleton(() => GetCampaignGamesUseCase(sl()));
  //----------------- Dice -----------------
  sl.registerLazySingleton(() => RollDiceUseCase(sl()));
  //----------------- Quiz -----------------
  sl.registerLazySingleton(() => ConnectQuizGameUseCase(quizRepository: sl()));
  sl.registerLazySingleton(
      () => SetRealTimeQuizControllerUseCase(quizRepository: sl()));
  sl.registerLazySingleton(() => PlayerAnswerQuizUseCase(quizRepository: sl()));
  sl.registerLazySingleton(() => InformAiMcUseCase(quizAIMCRepository: sl()));
  sl.registerLazySingleton(() => TextToSpeechUsecase(ttsService: sl()));
  sl.registerLazySingleton(() => NewMCSessionUseCase(quizRepository: sl()));
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
  sl.registerLazySingleton<GameRepository>(() => GameRepositoryImpl(
        dataSource: sl(),
        networkInfo: sl(),
        userCredentialService: sl(),
      ));
  sl.registerLazySingleton<DiceRepository>(() => DiceRepositoryImpl(
        diceDataSource: sl(),
        networkInfo: sl(),
        sharedPreferencesService: sl(),
        userCredentialService: sl(),
      ));
  sl.registerLazySingleton<QuizRepository>(() => QuizRepositoryImpl(
        networkInfo: sl(),
        userCredentialService: sl(),
        quizDataSource: sl(),
        quizRealTimeDataSource: sl(),
      ));
  sl.registerLazySingleton<QuizAIMCRepository>(() => QuizAIMCRepositoryImpl(
        networkInfo: sl(),
        quizAIMCDataSource: sl(),
      ));
  //============= Datasources =============
  sl.registerLazySingleton<AuthDataSource>(() => AuthHttpDataSource());
  sl.registerLazySingleton<CampaignDataSource>(() => CampaignHttpDataSource());
  sl.registerLazySingleton<VoucherDataSource>(() => VoucherLocalDataSource());
  sl.registerLazySingleton<NotificationDataSource>(
      () => NotificationLocalDataSource());
  sl.registerLazySingleton<UserDataSource>(() => UserLocalDataSource());
  sl.registerLazySingleton<GameDataSource>(
      () => GameHttpDataSource(userCredentialService: sl()));
  sl.registerLazySingleton<DiceDataSource>(
      () => DiceHttpDataSource(userCredentialService: sl()));
  sl.registerLazySingleton<QuizDataSource>(() => QuizHttpDataSource());
  sl.registerLazySingleton<QuizRealTimeDataSource>(
      () => RealTimeQuizWebSocketDataSource());
  sl.registerLazySingleton<QuizAIMCDataSource>(() => QuizOpenAIMCDataSource());
  //============= Core =============
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => UserCredentialService());
  //sl.registerLazySingleton(() => NavigationService());
  sl.registerLazySingleton<AudioService>(() => AudioServiceImpl());
  sl.registerLazySingleton<TtsService>(() => TtsServiceImpl());

  //============= External =================
  sl.registerLazySingleton(() => InternetConnection());
  sl.registerLazySingleton(() => SharedPreferencesService());

  // set up
  final openAIDataSource = sl<QuizAIMCDataSource>();
  await openAIDataSource.init();

  final ttsService = sl<TtsService>();
  await ttsService.init();

  final audioService = sl<AudioService>();
  audioService.init();
}
