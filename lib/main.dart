import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vou_games/configs/themes/main_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vou_games/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:vou_games/features/authentication/presentation/pages/home/landing_page.dart';
import 'package:vou_games/features/authentication/presentation/bloc/splash_cubit.dart';
import 'package:vou_games/features/authentication/presentation/pages/splash_screen.dart';
import 'package:vou_games/features/campaign/presentation/bloc/campaign_bloc.dart';
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
      ],
      child: MaterialApp(
        title: 'VouGames',
        theme: MainTheme.themeData,
        home: const SplashScreen(),
      ),
    );
  }
}
