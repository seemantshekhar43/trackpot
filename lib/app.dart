import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trackpot/core/common/cubits/user_preferences/user_preferences_cubit.dart';

import 'core/common/cubits/app_user/app_user_cubit.dart';
import 'core/common/features/preferences/domain/entities/user_preferences.dart';
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
    return BlocBuilder<UserPreferencesCubit, UserPreferences>(
        buildWhen: (previous, current) =>
            previous.themeMode != current.themeMode,
        builder: (context, preferences) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Trackpot',
            theme: theme.light(),
            darkTheme: theme.dark(),
            themeMode: context.read<UserPreferencesCubit>().state.themeMode,
            //home: HomePage(),
            home: BlocSelector<AppUserCubit, AppUserState, bool>(
              selector: (state) {
                return state is AppUserAuthenticated;
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
        });
  }
}
