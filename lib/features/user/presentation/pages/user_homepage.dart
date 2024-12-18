import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/presentation/bloc/auth_bloc.dart';

class UserHomepage extends StatelessWidget {
  const UserHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Homepage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to the User Homepage',
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: state is AuthLoadingLoggedOutState
                      ? null
                      : () {
                    BlocProvider.of<AuthBloc>(context)
                        .add(AuthLoggedOutEvent());
                  },
                  child: const Text('Log out',
                      style: TextStyle(color: Colors.red)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}