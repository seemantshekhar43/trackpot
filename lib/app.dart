import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/common/cubits/app_user/app_user_cubit.dart';
import 'core/theme/theme.dart';
import 'core/theme/theme_constants.dart';
import 'core/theme/theme_util.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/splash/presentation/pages/splash_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    // Initialize app theme
    GoogleFonts.config.allowRuntimeFetching = false;
    TextTheme textTheme = createTextTheme(
        context,
        ThemeConstants.textBodyFontFamily,
        ThemeConstants.textDisplayFontFamily);
    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trackpot',
      theme: isDarkMode(context) ? theme.dark() : theme.light(),
      //home: HomePage(),
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const HomePage();
          }
          return const LoginPage();
        },
      ),
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
