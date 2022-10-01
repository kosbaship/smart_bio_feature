import 'package:feature_oriented/core/utils/compass.dart';
import 'package:feature_oriented/feature/login/presentation/page/login.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    waiting();
    super.initState();
  }

  waiting() async {
    await Future.delayed(const Duration(seconds: 2));
    navTo(context, const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: LinearProgressIndicator(
          color: Colors.amber,
        ),
      ),
    );
  }
}
