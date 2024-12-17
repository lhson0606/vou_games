import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vou_games/configs/svg/app_vectors.dart';
import 'package:vou_games/features/authentication/presentation/pages/home/landing_page.dart';
import 'package:vou_games/features/authentication/presentation/bloc/splash_cubit.dart';
import 'package:vou_games/features/authentication/presentation/bloc/splash_state.dart';
import 'package:vou_games/injection_container.dart' as di;

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashLoaded) {
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => const LandingPage()
          ));
        }
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.inversePrimary,
        body: Center(
          child: SvgPicture.asset(
            AppVectors.logo,
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
