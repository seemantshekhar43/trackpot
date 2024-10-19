import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff515b92),
      surfaceTint: Color(0xff515b92),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffdee0ff),
      onPrimaryContainer: Color(0xff0b154b),
      secondary: Color(0xff4e5b92),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffdce1ff),
      onSecondaryContainer: Color(0xff05164b),
      tertiary: Color(0xff77536d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffd7f1),
      onTertiaryContainer: Color(0xff2d1228),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfffbf8ff),
      onBackground: Color(0xff1b1b21),
      surface: Color(0xfffbf8ff),
      onSurface: Color(0xff1b1b21),
      surfaceVariant: Color(0xffe3e1ec),
      onSurfaceVariant: Color(0xff46464f),
      outline: Color(0xff767680),
      outlineVariant: Color(0xffc7c5d0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff303036),
      inverseOnSurface: Color(0xfff2eff7),
      inversePrimary: Color(0xffbac3ff),
      primaryFixed: Color(0xffdee0ff),
      onPrimaryFixed: Color(0xff0b154b),
      primaryFixedDim: Color(0xffbac3ff),
      onPrimaryFixedVariant: Color(0xff394379),
      secondaryFixed: Color(0xffdce1ff),
      onSecondaryFixed: Color(0xff05164b),
      secondaryFixedDim: Color(0xffb7c4ff),
      onSecondaryFixedVariant: Color(0xff364479),
      tertiaryFixed: Color(0xffffd7f1),
      onTertiaryFixed: Color(0xff2d1228),
      tertiaryFixedDim: Color(0xffe6bad7),
      onTertiaryFixedVariant: Color(0xff5d3c55),
      surfaceDim: Color(0xffdbd9e0),
      surfaceBright: Color(0xfffbf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff5f2fa),
      surfaceContainer: Color(0xffefedf4),
      surfaceContainerHigh: Color(0xffe9e7ef),
      surfaceContainerHighest: Color(0xffe4e1e9),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff353f74),
      surfaceTint: Color(0xff515b92),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff6871aa),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff324074),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff6472aa),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff593851),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff8e6984),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfffbf8ff),
      onBackground: Color(0xff1b1b21),
      surface: Color(0xfffbf8ff),
      onSurface: Color(0xff1b1b21),
      surfaceVariant: Color(0xffe3e1ec),
      onSurfaceVariant: Color(0xff42424b),
      outline: Color(0xff5e5e67),
      outlineVariant: Color(0xff7a7a83),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff303036),
      inverseOnSurface: Color(0xfff2eff7),
      inversePrimary: Color(0xffbac3ff),
      primaryFixed: Color(0xff6871aa),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff4f5890),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff6472aa),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff4b598f),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff8e6984),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff74516a),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffdbd9e0),
      surfaceBright: Color(0xfffbf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff5f2fa),
      surfaceContainer: Color(0xffefedf4),
      surfaceContainerHigh: Color(0xffe9e7ef),
      surfaceContainerHighest: Color(0xffe4e1e9),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff131d52),
      surfaceTint: Color(0xff515b92),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff353f74),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff0e1e52),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff324074),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff34182f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff593851),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfffbf8ff),
      onBackground: Color(0xff1b1b21),
      surface: Color(0xfffbf8ff),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xffe3e1ec),
      onSurfaceVariant: Color(0xff23232b),
      outline: Color(0xff42424b),
      outlineVariant: Color(0xff42424b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff303036),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffeaeaff),
      primaryFixed: Color(0xff353f74),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff1e285d),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff324074),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff1a295d),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff593851),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff40233a),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffdbd9e0),
      surfaceBright: Color(0xfffbf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff5f2fa),
      surfaceContainer: Color(0xffefedf4),
      surfaceContainerHigh: Color(0xffe9e7ef),
      surfaceContainerHighest: Color(0xffe4e1e9),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffbac3ff),
      surfaceTint: Color(0xffbac3ff),
      onPrimary: Color(0xff222c61),
      primaryContainer: Color(0xff394379),
      onPrimaryContainer: Color(0xffdee0ff),
      secondary: Color(0xffb7c4ff),
      onSecondary: Color(0xff1e2d61),
      secondaryContainer: Color(0xff364479),
      onSecondaryContainer: Color(0xffdce1ff),
      tertiary: Color(0xffe6bad7),
      onTertiary: Color(0xff44263d),
      tertiaryContainer: Color(0xff5d3c55),
      onTertiaryContainer: Color(0xffffd7f1),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff121318),
      onBackground: Color(0xffe4e1e9),
      surface: Color(0xff121318),
      onSurface: Color(0xffe4e1e9),
      surfaceVariant: Color(0xff46464f),
      onSurfaceVariant: Color(0xffc7c5d0),
      outline: Color(0xff90909a),
      outlineVariant: Color(0xff46464f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe4e1e9),
      inverseOnSurface: Color(0xff303036),
      inversePrimary: Color(0xff515b92),
      primaryFixed: Color(0xffdee0ff),
      onPrimaryFixed: Color(0xff0b154b),
      primaryFixedDim: Color(0xffbac3ff),
      onPrimaryFixedVariant: Color(0xff394379),
      secondaryFixed: Color(0xffdce1ff),
      onSecondaryFixed: Color(0xff05164b),
      secondaryFixedDim: Color(0xffb7c4ff),
      onSecondaryFixedVariant: Color(0xff364479),
      tertiaryFixed: Color(0xffffd7f1),
      onTertiaryFixed: Color(0xff2d1228),
      tertiaryFixedDim: Color(0xffe6bad7),
      onTertiaryFixedVariant: Color(0xff5d3c55),
      surfaceDim: Color(0xff121318),
      surfaceBright: Color(0xff39393f),
      surfaceContainerLowest: Color(0xff0d0e13),
      surfaceContainerLow: Color(0xff1b1b21),
      surfaceContainer: Color(0xff1f1f25),
      surfaceContainerHigh: Color(0xff29292f),
      surfaceContainerHighest: Color(0xff34343a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc0c7ff),
      surfaceTint: Color(0xffbac3ff),
      onPrimary: Color(0xff050f46),
      primaryContainer: Color(0xff848dc8),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffbdc8ff),
      onSecondary: Color(0xff001046),
      secondaryContainer: Color(0xff808ec8),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffeabedc),
      onTertiary: Color(0xff270c22),
      tertiaryContainer: Color(0xffac85a1),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff121318),
      onBackground: Color(0xffe4e1e9),
      surface: Color(0xff121318),
      onSurface: Color(0xfffdfaff),
      surfaceVariant: Color(0xff46464f),
      onSurfaceVariant: Color(0xffcbc9d4),
      outline: Color(0xffa3a2ac),
      outlineVariant: Color(0xff83828c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe4e1e9),
      inverseOnSurface: Color(0xff292a2f),
      inversePrimary: Color(0xff3b447a),
      primaryFixed: Color(0xffdee0ff),
      onPrimaryFixed: Color(0xff000841),
      primaryFixedDim: Color(0xffbac3ff),
      onPrimaryFixedVariant: Color(0xff283267),
      secondaryFixed: Color(0xffdce1ff),
      onSecondaryFixed: Color(0xff000c3a),
      secondaryFixedDim: Color(0xffb7c4ff),
      onSecondaryFixedVariant: Color(0xff253367),
      tertiaryFixed: Color(0xffffd7f1),
      onTertiaryFixed: Color(0xff21071d),
      tertiaryFixedDim: Color(0xffe6bad7),
      onTertiaryFixedVariant: Color(0xff4b2c43),
      surfaceDim: Color(0xff121318),
      surfaceBright: Color(0xff39393f),
      surfaceContainerLowest: Color(0xff0d0e13),
      surfaceContainerLow: Color(0xff1b1b21),
      surfaceContainer: Color(0xff1f1f25),
      surfaceContainerHigh: Color(0xff29292f),
      surfaceContainerHighest: Color(0xff34343a),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffdfaff),
      surfaceTint: Color(0xffbac3ff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffc0c7ff),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffcfaff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffbdc8ff),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffff9f9),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffeabedc),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff121318),
      onBackground: Color(0xffe4e1e9),
      surface: Color(0xff121318),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff46464f),
      onSurfaceVariant: Color(0xfffdfaff),
      outline: Color(0xffcbc9d4),
      outlineVariant: Color(0xffcbc9d4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe4e1e9),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff1c255a),
      primaryFixed: Color(0xffe4e5ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffc0c7ff),
      onPrimaryFixedVariant: Color(0xff050f46),
      secondaryFixed: Color(0xffe2e5ff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffbdc8ff),
      onSecondaryFixedVariant: Color(0xff001046),
      tertiaryFixed: Color(0xffffddf2),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffeabedc),
      onTertiaryFixedVariant: Color(0xff270c22),
      surfaceDim: Color(0xff121318),
      surfaceBright: Color(0xff39393f),
      surfaceContainerLowest: Color(0xff0d0e13),
      surfaceContainerLow: Color(0xff1b1b21),
      surfaceContainer: Color(0xff1f1f25),
      surfaceContainerHigh: Color(0xff29292f),
      surfaceContainerHighest: Color(0xff34343a),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.surface,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary, 
    required this.surfaceTint, 
    required this.onPrimary, 
    required this.primaryContainer, 
    required this.onPrimaryContainer, 
    required this.secondary, 
    required this.onSecondary, 
    required this.secondaryContainer, 
    required this.onSecondaryContainer, 
    required this.tertiary, 
    required this.onTertiary, 
    required this.tertiaryContainer, 
    required this.onTertiaryContainer, 
    required this.error, 
    required this.onError, 
    required this.errorContainer, 
    required this.onErrorContainer, 
    required this.background, 
    required this.onBackground, 
    required this.surface, 
    required this.onSurface, 
    required this.surfaceVariant, 
    required this.onSurfaceVariant, 
    required this.outline, 
    required this.outlineVariant, 
    required this.shadow, 
    required this.scrim, 
    required this.inverseSurface, 
    required this.inverseOnSurface, 
    required this.inversePrimary, 
    required this.primaryFixed, 
    required this.onPrimaryFixed, 
    required this.primaryFixedDim, 
    required this.onPrimaryFixedVariant, 
    required this.secondaryFixed, 
    required this.onSecondaryFixed, 
    required this.secondaryFixedDim, 
    required this.onSecondaryFixedVariant, 
    required this.tertiaryFixed, 
    required this.onTertiaryFixed, 
    required this.tertiaryFixedDim, 
    required this.onTertiaryFixedVariant, 
    required this.surfaceDim, 
    required this.surfaceBright, 
    required this.surfaceContainerLowest, 
    required this.surfaceContainerLow, 
    required this.surfaceContainer, 
    required this.surfaceContainerHigh, 
    required this.surfaceContainerHighest, 
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surface: surface,
      onSurface: onSurface,
      surfaceContainerHighest: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
