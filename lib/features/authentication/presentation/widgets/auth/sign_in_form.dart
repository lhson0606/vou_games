import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vou_games/core/utils/validators/validators.dart';
import 'package:vou_games/features/authentication/domain/entities/sign_in_entity.dart';
import 'package:vou_games/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:vou_games/features/authentication/presentation/pages/auth/sign_up_page.dart';
import 'package:vou_games/features/homepage/presentation/pages/homepage.dart';

import '../../../../../core/widgets/input/validation_textfield.dart';
import '../../pages/auth/sign_in_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  ValidationTextField usernameField = ValidationTextField(
    hintText: 'Username',
    labelText: 'Username',
    keyboardType: TextInputType.emailAddress,
    validator: emailValidator,
  );

  ValidationTextField passwordField = ValidationTextField(
    hintText: 'Password',
    labelText: 'Password',
    keyboardType: TextInputType.visiblePassword,
    validator: passwordValidator,
  );

  bool isVisible = false;

  bool _isFormValid() {
    return _formKey.currentState!.validate() &&
        usernameField.isValid &&
        passwordField.isValid;
  }

  void _submitForm() {
    if (_isFormValid()) {
      BlocProvider.of<AuthBloc>(context).add(SignInWithEmailAndPassEvent(
          signInEntity: SignInEntity(
              password: passwordField.text, email: usernameField.text)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter valid details')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: usernameField,
            ),
            const SizedBox(
              height: 20,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: passwordField,
            ),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<AuthBloc, AuthState>(builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AuthError) {
                return Column(
                  children: [
                    Center(
                      child: Text(state.message),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _submitForm();
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                        minimumSize:
                            MaterialStateProperty.all(const Size(500, 50)),
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontSize: 18)),
                      ),
                      child: const Text('Login'),
                    ),
                  ],
                );
              }
              return ElevatedButton(
                onPressed: () {
                  _submitForm();
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
                  minimumSize: MaterialStateProperty.all(const Size(500, 50)),
                  textStyle:
                      MaterialStateProperty.all(const TextStyle(fontSize: 18)),
                ),
                child: const Text('Login'),
              );
            }, listener: (context, state) {
              if (state is AuthSignedIn) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const HomePage()));
              }
            }),
            Container(
                margin: const EdgeInsets.all(20),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: const Divider(
                          thickness: 2,
                          color: Colors.grey,
                        )),
                    Positioned(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 3),
                        child: const Text(
                          'OR',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    )
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                optionsBox(
                    color: Colors.blue,
                    imagePath: "assets/facebook_icon.png",
                    onPressed: () {}),
                optionsBox(
                    color: Colors.red,
                    imagePath: "assets/google_icon.png",
                    onPressed: () {}),
                optionsBox(
                    color: Colors.blue,
                    imagePath: "assets/twitter_icon.png",
                    onPressed: () {}),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Need an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()));
                    },
                    child: const Text("Signup"))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget optionsBox(
      {Color? color,
      required String? imagePath,
      required Function? onPressed}) {
    return InkWell(
      onTap: () {
        onPressed!();
      },
      child: Container(
          height: 50,
          margin:
              const EdgeInsets.only(top: 0, bottom: 20, left: 10, right: 10),
          width: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                imagePath!,
                color: color,
              ))),
    );
  }
}
