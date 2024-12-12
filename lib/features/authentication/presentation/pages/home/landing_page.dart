import 'package:flutter/cupertino.dart';

class LandingPage extends StatefulWidget {
  final String title = 'Landing Page';

  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>{
  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(
        child: Text('Home Page'),
      ),
    );
  }
}