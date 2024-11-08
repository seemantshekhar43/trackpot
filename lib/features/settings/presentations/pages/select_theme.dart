import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/cubits/user_preferences/user_preferences_cubit.dart';
import '../../../../core/common/features/preferences/domain/entities/user_preferences.dart';

class SelectTheme extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SelectTheme(),
      );
  const SelectTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPreferencesCubit, UserPreferences>(
      buildWhen: (previous, current) => previous.themeMode != current.themeMode,
      builder: (context, preferences) {
        return Scaffold(
          body: Center(
            child: DropdownButton<ThemeMode>(
              value: preferences.themeMode,
              items: ThemeMode.values.map((mode) {
                return DropdownMenuItem(
                  value: mode,
                  child: Text(mode.toString().split('.').last),
                );
              }).toList(),
              onChanged: (ThemeMode? newMode) {
                if (newMode != null) {
                  context.read<UserPreferencesCubit>().updateThemeMode(newMode);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
