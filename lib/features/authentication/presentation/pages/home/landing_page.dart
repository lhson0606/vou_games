import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vou_games/core/widgets/display/loading_widget.dart';
import 'package:vou_games/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:vou_games/features/authentication/presentation/pages/auth/sign_in_page.dart';
import 'package:vou_games/features/homepage/presentation/pages/homepage.dart';

class LandingPage extends StatefulWidget {
  final String title = 'Landing Page';

  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedOutState) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const SignIn()));
          } else if (state is AuthNotAuthenticatedState) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const SignIn()));
          } else if(state is AuthSignedInState) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomePage()));
          }
        },
        child: const LoadingWidget(),
      ),
    );
  }
}