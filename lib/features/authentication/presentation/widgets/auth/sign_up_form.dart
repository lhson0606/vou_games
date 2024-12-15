import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../pages/auth/sign_in_page.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool isVisible = false;

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
              child: TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your username';
                  } else if (false) {
                    return 'This username is taken';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'E-Mail',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your E-Mail';
                  } else if (false) {
                    return 'Please enter a valid E-Mail';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: TextFormField(
                controller: _passwordController,
                obscureText: isVisible ? false : true,
                decoration: InputDecoration(
                  labelText: 'Create password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 5) {
                    return 'The password must contains more than five characters.';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: TextFormField(
                controller: _confirmPasswordController,
                obscureText: isVisible ? false : true,
                decoration: const InputDecoration(
                  labelText: 'Confirm password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password confirmation';
                  } else if (value != _passwordController.text) {
                    return "Password doesn't match.";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
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
