import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vou_games/configs/navigation/destination_indices.dart';
import 'package:vou_games/configs/themes/main_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vou_games/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:vou_games/features/authentication/presentation/bloc/splash_cubit.dart';
import 'package:vou_games/features/authentication/presentation/pages/splash_screen.dart';
import 'package:vou_games/features/campaign/presentation/bloc/campaign_bloc.dart';
import 'package:vou_games/features/dice/presentation/bloc/dice_bloc.dart';
import 'package:vou_games/features/homepage/presentation/bloc/homepage_navigator_bloc.dart';
import 'package:vou_games/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:vou_games/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:vou_games/features/shop/presentation/bloc/shop_bloc.dart';
import 'package:vou_games/features/user/presentation/bloc/user_bloc.dart';
import 'package:vou_games/features/voucher/presentation/bloc/voucher_bloc.dart';
import 'core/widgets/display/custom_navigation_bar.dart';
import 'firebase_options.dart';
import 'package:vou_games/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SplashCubit()..loadApp(),
        ),
        BlocProvider(
          create: (context) => di.sl<AuthBloc>()..add(CheckLoggingInEvent()),
        ),
        BlocProvider(create: (context) => di.sl<CampaignBloc>()),
        BlocProvider(create: (context) => di.sl<VoucherBloc>()),
        BlocProvider(create: (context) => di.sl<ShopBloc>()),
        BlocProvider(create: (context) => di.sl<NotificationBloc>()),
        BlocProvider(create: (context) => di.sl<UserBloc>()),
        BlocProvider(create: (context) => di.sl<HomepageNavigatorBloc>()),
        BlocProvider(create: (context) => di.sl<QuizBloc>()),
        BlocProvider(create: (context) => di.sl<DiceBloc>()),
        BlocProvider(create: (context) => di.sl<NotificationBloc>()),
      ],
      child: MaterialApp(
        title: 'VouGames',
        theme: MainTheme.themeData,
        home: const SplashScreen(),
      ),
    );
  }
}
