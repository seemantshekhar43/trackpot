import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SplashPage(),
      );
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
