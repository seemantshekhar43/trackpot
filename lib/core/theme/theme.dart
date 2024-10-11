import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4283521938),
      surfaceTint: Color(4283521938),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4292796671),
      onPrimaryContainer: Color(4278916427),
      secondary: Color(4283325330),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4292665855),
      onSecondaryContainer: Color(4278523467),
      tertiary: Color(4286010221),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4294957041),
      onTertiaryContainer: Color(4281143848),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      background: Color(4294703359),
      onBackground: Color(4279966497),
      surface: Color(4294703359),
      onSurface: Color(4279966497),
      surfaceVariant: Color(4293124588),
      onSurfaceVariant: Color(4282795599),
      outline: Color(4285953664),
      outlineVariant: Color(4291282384),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281348150),
      inverseOnSurface: Color(4294111223),
      inversePrimary: Color(4290429951),
      primaryFixed: Color(4292796671),
      onPrimaryFixed: Color(4278916427),
      primaryFixedDim: Color(4290429951),
      onPrimaryFixedVariant: Color(4281942905),
      secondaryFixed: Color(4292665855),
      onSecondaryFixed: Color(4278523467),
      secondaryFixedDim: Color(4290233599),
      onSecondaryFixedVariant: Color(4281746553),
      tertiaryFixed: Color(4294957041),
      onTertiaryFixed: Color(4281143848),
      tertiaryFixedDim: Color(4293311191),
      onTertiaryFixedVariant: Color(4284300373),
      surfaceDim: Color(4292598240),
      surfaceBright: Color(4294703359),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294308602),
      surfaceContainer: Color(4293914100),
      surfaceContainerHigh: Color(4293519343),
      surfaceContainerHighest: Color(4293190121),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4281679732),
      surfaceTint: Color(4283521938),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4285034922),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4281483380),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4284773034),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4284037201),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4287523204),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      background: Color(4294703359),
      onBackground: Color(4279966497),
      surface: Color(4294703359),
      onSurface: Color(4279966497),
      surfaceVariant: Color(4293124588),
      onSurfaceVariant: Color(4282532427),
      outline: Color(4284374631),
      outlineVariant: Color(4286216835),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281348150),
      inverseOnSurface: Color(4294111223),
      inversePrimary: Color(4290429951),
      primaryFixed: Color(4285034922),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4283390096),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4284773034),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4283128207),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4287523204),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4285813098),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292598240),
      surfaceBright: Color(4294703359),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294308602),
      surfaceContainer: Color(4293914100),
      surfaceContainerHigh: Color(4293519343),
      surfaceContainerHighest: Color(4293190121),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4279442770),
      surfaceTint: Color(4283521938),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4281679732),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4279115346),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4281483380),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4281604143),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4284037201),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      background: Color(4294703359),
      onBackground: Color(4279966497),
      surface: Color(4294703359),
      onSurface: Color(4278190080),
      surfaceVariant: Color(4293124588),
      onSurfaceVariant: Color(4280492843),
      outline: Color(4282532427),
      outlineVariant: Color(4282532427),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281348150),
      inverseOnSurface: Color(4294967295),
      inversePrimary: Color(4293585663),
      primaryFixed: Color(4281679732),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4280166493),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4281483380),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4279904605),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4284037201),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4282393402),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292598240),
      surfaceBright: Color(4294703359),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294308602),
      surfaceContainer: Color(4293914100),
      surfaceContainerHigh: Color(4293519343),
      surfaceContainerHighest: Color(4293190121),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4290429951),
      surfaceTint: Color(4290429951),
      onPrimary: Color(4280429665),
      primaryContainer: Color(4281942905),
      onPrimaryContainer: Color(4292796671),
      secondary: Color(4290233599),
      onSecondary: Color(4280167777),
      secondaryContainer: Color(4281746553),
      onSecondaryContainer: Color(4292665855),
      tertiary: Color(4293311191),
      onTertiary: Color(4282656317),
      tertiaryContainer: Color(4284300373),
      onTertiaryContainer: Color(4294957041),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      background: Color(4279374616),
      onBackground: Color(4293190121),
      surface: Color(4279374616),
      onSurface: Color(4293190121),
      surfaceVariant: Color(4282795599),
      onSurfaceVariant: Color(4291282384),
      outline: Color(4287664282),
      outlineVariant: Color(4282795599),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293190121),
      inverseOnSurface: Color(4281348150),
      inversePrimary: Color(4283521938),
      primaryFixed: Color(4292796671),
      onPrimaryFixed: Color(4278916427),
      primaryFixedDim: Color(4290429951),
      onPrimaryFixedVariant: Color(4281942905),
      secondaryFixed: Color(4292665855),
      onSecondaryFixed: Color(4278523467),
      secondaryFixedDim: Color(4290233599),
      onSecondaryFixedVariant: Color(4281746553),
      tertiaryFixed: Color(4294957041),
      onTertiaryFixed: Color(4281143848),
      tertiaryFixedDim: Color(4293311191),
      onTertiaryFixedVariant: Color(4284300373),
      surfaceDim: Color(4279374616),
      surfaceBright: Color(4281940287),
      surfaceContainerLowest: Color(4279045651),
      surfaceContainerLow: Color(4279966497),
      surfaceContainer: Color(4280229669),
      surfaceContainerHigh: Color(4280887599),
      surfaceContainerHighest: Color(4281611322),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4290824191),
      surfaceTint: Color(4290429951),
      onPrimary: Color(4278521670),
      primaryContainer: Color(4286877128),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4290627839),
      onSecondary: Color(4278194246),
      secondaryContainer: Color(4286615240),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4293574364),
      onTertiary: Color(4280749090),
      tertiaryContainer: Color(4289496481),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      background: Color(4279374616),
      onBackground: Color(4293190121),
      surface: Color(4279374616),
      onSurface: Color(4294834943),
      surfaceVariant: Color(4282795599),
      onSurfaceVariant: Color(4291545556),
      outline: Color(4288914092),
      outlineVariant: Color(4286808716),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293190121),
      inverseOnSurface: Color(4280887855),
      inversePrimary: Color(4282074234),
      primaryFixed: Color(4292796671),
      onPrimaryFixed: Color(4278192193),
      primaryFixedDim: Color(4290429951),
      onPrimaryFixedVariant: Color(4280824423),
      secondaryFixed: Color(4292665855),
      onSecondaryFixed: Color(4278193210),
      secondaryFixedDim: Color(4290233599),
      onSecondaryFixedVariant: Color(4280628071),
      tertiaryFixed: Color(4294957041),
      onTertiaryFixed: Color(4280354589),
      tertiaryFixedDim: Color(4293311191),
      onTertiaryFixedVariant: Color(4283116611),
      surfaceDim: Color(4279374616),
      surfaceBright: Color(4281940287),
      surfaceContainerLowest: Color(4279045651),
      surfaceContainerLow: Color(4279966497),
      surfaceContainer: Color(4280229669),
      surfaceContainerHigh: Color(4280887599),
      surfaceContainerHighest: Color(4281611322),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294834943),
      surfaceTint: Color(4290429951),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4290824191),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294769407),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4290627839),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294965753),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4293574364),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      background: Color(4279374616),
      onBackground: Color(4293190121),
      surface: Color(4279374616),
      onSurface: Color(4294967295),
      surfaceVariant: Color(4282795599),
      onSurfaceVariant: Color(4294834943),
      outline: Color(4291545556),
      outlineVariant: Color(4291545556),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293190121),
      inverseOnSurface: Color(4278190080),
      inversePrimary: Color(4280034650),
      primaryFixed: Color(4293191167),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4290824191),
      onPrimaryFixedVariant: Color(4278521670),
      secondaryFixed: Color(4293060095),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4290627839),
      onSecondaryFixedVariant: Color(4278194246),
      tertiaryFixed: Color(4294958578),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4293574364),
      onTertiaryFixedVariant: Color(4280749090),
      surfaceDim: Color(4279374616),
      surfaceBright: Color(4281940287),
      surfaceContainerLowest: Color(4279045651),
      surfaceContainerLow: Color(4279966497),
      surfaceContainer: Color(4280229669),
      surfaceContainerHigh: Color(4280887599),
      surfaceContainerHighest: Color(4281611322),
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
     scaffoldBackgroundColor: colorScheme.background,
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
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
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
