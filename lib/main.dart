import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vou_games/configs/navigation/destination_indices.dart';
import 'package:vou_games/configs/themes/main_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vou_games/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:vou_games/features/authentication/presentation/pages/home/landing_page.dart';
import 'package:vou_games/features/authentication/presentation/bloc/splash_cubit.dart';
import 'package:vou_games/features/authentication/presentation/pages/splash_screen.dart';
import 'package:vou_games/features/campaign/presentation/bloc/campaign_bloc.dart';
import 'package:vou_games/features/homepage/presentation/bloc/homepage_navigator_bloc.dart';
import 'package:vou_games/features/notification/presentation/bloc/notification_bloc.dart';
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
    final List<Destination> allDestinations = <Destination>[
      const Destination(
          CAMPAIGN_HOMEPAGE_INDEX, 'Campaign', Icons.event, Colors.cyan),
      const Destination(VOUCHER_HOMEPAGE_INDEX, 'Voucher',
          Icons.discount_outlined, Colors.orange),
      const Destination(
          SHOP_HOMEPAGE_INDEX, 'Shop', Icons.location_pin, Colors.orange),
      const Destination(NOTIFICATION_HOMEPAGE_INDEX, 'Notification',
          Icons.notifications, Colors.blue),
      const Destination(
          USER_HOMEPAGE_INDEX, 'User', Icons.person, Colors.green),
    ];

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
        BlocProvider(create: (context) {
          final bloc = di.sl<HomepageNavigatorBloc>();
          // for each destination in allDestinations
          for (var destination in allDestinations) {
            // add the destination to the bloc
            bloc.add(AddDestinationEvent(destination));
          }
          bloc.add(LoadFirstScreenEvent());
          return bloc;
        }),
      ],
      child: MaterialApp(
        title: 'VouGames',
        theme: MainTheme.themeData,
        home: const SplashScreen(),
      ),
    );
  }
}
