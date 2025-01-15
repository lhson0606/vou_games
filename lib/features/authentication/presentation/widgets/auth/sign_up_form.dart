import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vou_games/core/utils/validators/validators.dart';
import 'package:vou_games/core/widgets/display/snack_bar.dart';
import 'package:vou_games/features/authentication/domain/entities/sign_up_entity.dart';
import 'package:vou_games/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:vou_games/features/homepage/presentation/pages/homepage.dart';

import '../../../../../core/widgets/input/validation_textfield.dart';
import '../../pages/auth/sign_in_page.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameFieldKey = GlobalKey<ValidationTextFieldState>();
  final _emailFieldKey = GlobalKey<ValidationTextFieldState>();
  final _phoneNumberFieldKey = GlobalKey<ValidationTextFieldState>();
  final _passwordFieldKey = GlobalKey<ValidationTextFieldState>();
  final _confirmPasswordFieldKey = GlobalKey<ValidationTextFieldState>();

  final String initialUsername = "newuser";
  final String initialPassword = "password123";
  final String initialEmail = "lehoangson01633892497@gmail.com";
  final String initialPhoneNumber = "1234567890";
  final String initialRole = "PLAYER";

  // set initial values for fields
  @override
  void initState() {
    super.initState();
    // for demo purposes
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _usernameFieldKey.currentState!.setValue(initialUsername);
    //   _emailFieldKey.currentState!.setValue(initialEmail);
    //   _phoneNumberFieldKey.currentState!.setValue(initialPhoneNumber);
    //   _passwordFieldKey.currentState!.setValue(initialPassword);
    //   _confirmPasswordFieldKey.currentState!.setValue(initialPassword);
    // });
  }

  bool _isFormValid() {
    _usernameFieldKey.currentState!.validate();
    _emailFieldKey.currentState!.validate();
    _phoneNumberFieldKey.currentState!.validate();
    _passwordFieldKey.currentState!.validate();
    _confirmPasswordFieldKey.currentState!.validate();
    return _usernameFieldKey.currentState!.isValid() &&
        _emailFieldKey.currentState!.isValid() &&
        _phoneNumberFieldKey.currentState!.isValid() &&
        _passwordFieldKey.currentState!.isValid() &&
        _confirmPasswordFieldKey.currentState!.isValid();
  }

  void _submitForm() {
    if (_isFormValid()) {
      BlocProvider.of<AuthBloc>(context).add(SignUpWithEmailAndPassEvent(
          signUpEntity: SignUpEntity(
              username: _usernameFieldKey.currentState!.text,
              email: _emailFieldKey.currentState!.text,
              phoneNumber: _phoneNumberFieldKey.currentState!.text,
              password: _passwordFieldKey.currentState!.text)));
    } else {
      showSnackBar(context, "Form contains errors", type: SnackBarType.error);
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
              child: ValidationTextField(
                key: _usernameFieldKey,
                hintText: 'Username',
                labelText: 'Username',
                validator: usernameValidator,
                icon: Icons.person,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: ValidationTextField(
                key: _emailFieldKey,
                hintText: 'E-Mail',
                labelText: 'E-Mail',
                validator: emailValidator,
                icon: Icons.email,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: ValidationTextField(
                key: _phoneNumberFieldKey,
                hintText: 'Phone Number',
                labelText: 'Phone Number',
                validator: phoneNumberValidator,
                icon: Icons.phone,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: ValidationTextField(
                key: _passwordFieldKey,
                hintText: 'Create password',
                labelText: 'Create password',
                validator: passwordValidator,
                icon: Icons.lock,
                isPassword: true,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: ValidationTextField(
                key: _confirmPasswordFieldKey,
                hintText: 'Confirm password',
                labelText: 'Confirm password',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password confirmation';
                  } else if (value != _passwordFieldKey.currentState!.text) {
                    return "Password doesn't match.";
                  }
                  return null;
                },
                icon: Icons.lock,
                isPassword: true,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<AuthBloc, AuthState>(builder: (context, state) {
              if (state is AuthLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AuthErrorState) {
                return Column(
                  children: [
                    Center(
                      child: Text(
                        state.message,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _submitForm,
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
                      child: const Text('Create Account'),
                    ),
                  ],
                );
              }
              return ElevatedButton(
                onPressed: _submitForm,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
                  minimumSize: MaterialStateProperty.all(const Size(500, 50)),
                  textStyle:
                      MaterialStateProperty.all(const TextStyle(fontSize: 18)),
                ),
                child: const Text('Create Account'),
              );
            }, listener: (context, state) {
              if (state is AuthSignedUpState) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const HomePage()));
              } else if(state is AuthPostSignUpState) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignIn(username: state.username, password: state.password)));
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
                const Text("Have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignIn()));
                    },
                    child: const Text("Login"))
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
