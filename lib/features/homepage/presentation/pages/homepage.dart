import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vou_games/core/services/navigation_service.dart';
import 'package:vou_games/core/widgets/display/custom_navigation_bar.dart';
import 'package:vou_games/core/widgets/display/snack_bar.dart';
import 'package:vou_games/features/authentication/presentation/pages/auth/sign_in_page.dart';
import 'package:vou_games/injection_container.dart' as di;

import '../../../authentication/presentation/bloc/auth_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _afterBuild();
    });
  }

  void _afterBuild() {
    di.setupNavigationService();
    NavigationService navigationService = di.sl<NavigationService>();
    navigationService.navigateToHomePages(0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedOutState) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const SignIn()));
          } else if (state is AuthErrorState) {
            final errorMessage = state.message;
            showSnackBar(context, errorMessage, type: SnackBarType.error);
          } else if (state is AuthLoadingLoggedOutState) {
            showSnackBar(context, "Logging out...", type: SnackBarType.info);
          }
        },
        child: Scaffold(
          body: Center(
            child: ValueListenableBuilder<Widget>(
              valueListenable: di.sl<NavigationService>().currentScreen,
              builder: (context, currentScreen, child) {
                return currentScreen;
              },
            ),
          ),
          bottomNavigationBar: CustomBottomNavigationBar(
                  key: di.sl<NavigationService>().getBottomNavigationBarKey())
              as Widget,
        ),
      ),
    );
  }
}
