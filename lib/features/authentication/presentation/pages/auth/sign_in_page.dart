import 'package:flutter/material.dart';
import 'package:vou_games/features/authentication/presentation/widgets/auth/sign_in_form.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.inversePrimary,
        body: ListView(
          children: const [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Image(
                  height: 200,
                  width: 200,
                  image: AssetImage("assets/sign_in.png")),
            ),
            Center(
                child: Text("Login", style: TextStyle(fontSize: 25 , fontWeight: FontWeight.bold),)),
            SizedBox(height: 10,),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}
