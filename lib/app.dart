import 'package:flutter/material.dart';
import 'features/auth/presentation/pages/login_page.dart';

import 'core/theme/theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trackpot',
      theme: AppTheme.darkThemeMode,
      home: const LoginPage(),
    );
  }
}
