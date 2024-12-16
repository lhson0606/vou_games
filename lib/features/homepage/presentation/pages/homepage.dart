import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vou_games/core/widgets/display/snack_bar.dart';
import 'package:vou_games/features/authentication/presentation/pages/auth/sign_in_page.dart';

import '../../../authentication/presentation/bloc/auth_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text('Home page'),
              actions: [
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return TextButton(
                      onPressed: state is AuthLoadingLoggedOutState
                          ? null
                          : () {
                        BlocProvider.of<AuthBloc>(context).add(AuthLoggedOutEvent());
                      },
                      child: const Text('Log out', style: TextStyle(color: Colors.red)),
                    );
                  },
                ),
              ],
            ),
            body: const Center(
              child: Image(
                image: AssetImage('assets/home_page_background.gif'),
              ),
            ),
          ),
        ));
  }
}